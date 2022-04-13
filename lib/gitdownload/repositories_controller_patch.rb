require 'fileutils'
require_dependency 'repositories_controller'

module RepositoriesControllerPatch
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development
      alias_method :create, :create_with_patch
      alias_method :create_with_patch, :create
    end
  end

  module InstanceMethods

      def create_with_patch
        
        if params[:repository_scm] == 'Git'
        
            @repository = Repository.factory(params[:repository_scm])
            @repository.safe_attributes = params[:repository]
            @repository.project = @project
            
            
            if request.post? && @repository.save
    
                # WRITE .gitconfig FILE TO USE WITH THE GIT COMMANDS
                configContent = Setting.plugin_gitdownload["git_configfile"].to_s
                configContent.gsub! /\r\n?/, "\n"
        
                configDir = "#{Rails.root}/plugins/gitdownload/"
                configFile = "#{configDir}.gitconfig"
                
                out_file = File.new("#{configFile}", "w")
                out_file.puts("#{configContent}")
                out_file.close 
                
                # CREATE REPOSITORY
                git = "#{Redmine::Configuration['scm_git_command']}"
                git = "git" if git.empty?
                git = "HOME=#{configDir} " + git
                path = params[:repository][:url]
                storage = "#{Rails.root}/tmp/git/"
                
                FileUtils.mkdir_p(path) unless File.exists?(path)
                Dir.chdir(path) do
                    system "#{git} --bare init --shared"
                    system "#{git} update-server-info"
                end
        
                # CLONE REPOSITORY TO ./tmp/git/repo_*
                repo_init = "#{storage}repo_#{@repository.identifier}"
                FileUtils.mkdir_p(repo_init) unless File.exists?(repo_init)
                Dir.chdir(storage) do
                    clone = system "#{git} clone #{path} repo_#{@repository.identifier}"
                    if clone == true
                        logger.info "[#{Time.now}] - Git: cloned repo #{path} to #{repo_init}"
                    else
                        logger.info "[#{Time.now}] - Git: could not clone repo #{path} to #{repo_init}"
                    end
        
                end
        
                # INIT REPO WITH CUSTOM FILES, ADD, COMMIT, PUSH TO REMOTE
                Dir.chdir(repo_init) do
                    
                    copyFiles = Setting.plugin_gitdownload["git_copyfiles"].to_s.strip
                    if copyFiles.blank?
                        out_file = File.new("init_repo.txt", "w")
                        out_file.puts("Repository: #{path}")
                        out_file.close 
                    else
                        FileUtils.cp_r "#{copyFiles}/.", "#{repo_init}"
                    end
        
                    add = system "#{git} add ."
                    if add == true
                        logger.info "[#{Time.now}] - Git: files added #{path}"
                    else
                        logger.info "[#{Time.now}] - Git: could not add files #{path}"
                    end
        
                    commit = system "#{git} commit -m 'Init Commit ...' && #{git} push origin master"
                    if commit == true
                        logger.info "[#{Time.now}] - Git: files pushed to repo #{path}"
                    else
                        logger.info "[#{Time.now}] - Git: could not commit and push files #{path}"
                    end            
        
                    FileUtils.rm_rf(repo_init)
                end
    
                redirect_to settings_project_path(@project, :tab => 'repositories')
            else
                render :action => 'new'
            end
        end
      end
        
  end
end

RepositoriesController.send(:include, RepositoriesControllerPatch)