require 'fileutils'

class GitdownloadController < ApplicationController
  unloadable

  def index
    
	if User.current.allowed_to?(:commit_access, @project, :global => true)
		if !params[:repository].nil?
			repo = Repository.find(params[:repository])
			@project = Project.find(repo.project_id)
			storage = "#{Rails.root}/tmp/git/"
			
			if repo.identifier.blank?
    			repoid = ""
            else
                repoid = "#{repo.identifier}-"
            end 
			
			filename = "#{@project.identifier}-#{repoid}#{params[:archive]}.#{params[:gitFormat]}"

			# CREATE GIT FOLDER in tmp/
			dir = File.dirname("#{storage}")
			FileUtils.mkdir_p("#{dir}")

			# HANDLE TMP FOLDER
			Dir.mkdir("#{storage}") unless File.exists?("#{storage}")
			minutes = Setting.plugin_gitdownload["git_archive_last"].to_i
			rmfiles = "find #{storage} -type f -mmin +#{minutes} -exec rm {} \\;"
			system(rmfiles)
			
			# GIT GERNERATE ARCHIVE
			if params[:archive] != 'undefined'
				if params[:type] == 'all'
					# BUILD GIT COMMAND
					if params[:gitFormat] == 'tar.gz'
						command = "cd #{repo.root_url} && #{Redmine::Configuration['scm_git_command']} archive #{params[:archive]} --format tar | gzip -9 > #{storage}#{filename}"
						system(command)
					end
					if params[:gitFormat] == 'zip'
						command = "cd #{repo.root_url} && #{Redmine::Configuration['scm_git_command']} archive #{params[:archive]} --format #{params[:gitFormat]} > #{storage}#{filename}"
						system(command)
					end
	
					if params[:gitFormat] == 'tar.bz2'
						command = "cd #{repo.root_url} && #{Redmine::Configuration['scm_git_command']} archive #{params[:archive]} --format tar | bzip2 -9 > #{storage}#{filename}"
						system(command)
					end
				end
				
				if params[:type] == 'changes'
					# BUILD GIT COMMAND
					if params[:gitFormat] == 'tar.gz'
						command = "cd #{repo.root_url} && #{Redmine::Configuration['scm_git_command']} archive -o #{storage}#{filename} #{params[:archive]} $(#{Redmine::Configuration['scm_git_command']} diff --name-only #{params[:archive]} #{params[:archive]}~1)"
						system(command)
					end
					if params[:gitFormat] == 'zip'
						command = "cd #{repo.root_url} && #{Redmine::Configuration['scm_git_command']} archive -o #{storage}#{filename} #{params[:archive]} $(#{Redmine::Configuration['scm_git_command']} diff --name-only #{params[:archive]} #{params[:archive]}~1)"
						system(command)
					end
	
					if params[:gitFormat] == 'tar.bz2'
						command = "cd #{repo.root_url} && #{Redmine::Configuration['scm_git_command']} archive -o #{storage}#{filename} #{params[:archive]} $(#{Redmine::Configuration['scm_git_command']} diff --name-only #{params[:archive]} #{params[:archive]}~1)"
						system(command)
					end
				end				
			end
			@gitAjax = {'status' => 'success', 'filename' => filename, 'rm' => rmfiles, 'command' => command}
		else
			@gitAjax = {'status' => 'error'}
		end 

		render json: @gitAjax
	else
		@gitAjax = {'status' => 'error', 'permission' => 'false'}
		render json: @gitAjax
	end
  end
  
  def download
	if !params[:filename].nil?
		storage = "#{Rails.root}/tmp/git/"
		send_file "#{storage}#{params[:filename]}", :disposition => 'attachment'
	end
  end
end