class GitdownloadController < ApplicationController
  unloadable

  def index
  
	if User.current.logged?
		if !params[:repository].nil?
			repo = Repository.find(params[:repository])
			storage = "#{Rails.root}/tmp/git/"
			filename = "#{params[:identifier]}-#{params[:archive]}.#{params[:gitFormat]}"

			# CREATE GIT FOLDER in tmp/
			dir = File.dirname("#{storage}")
			FileUtils.mkdir_p("#{dir}")

			# HANDLE TMP FOLDER
			Dir.mkdir("#{storage}") unless File.exists?("#{storage}")
			minutes = Setting.plugin_gitdownload["git_archive_last"].to_i
			rmfiles = "find #{storage} -type f -mmin +#{minutes} -exec rm {} \\;"
			system(rmfiles)
			
			# GIT GERNERATE ARCHIVE
			if !params[:archive].nil?
				# BUILD GIT COMMAND
				if params[:gitFormat] == 'tar.gz'
					command = "cd #{repo.root_url} && git archive #{params[:archive]} --format tar | gzip -9 > #{storage}#{filename}"
					system(command)
				end
				if params[:gitFormat] == 'zip'
					command = "cd #{repo.root_url} && git archive #{params[:archive]} --format #{params[:gitFormat]} > #{storage}#{filename}"
					system(command)
				end
			end
			@gitAjax = {'status' => 'success', 'filename' => filename, 'rm' => rmfiles}
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
	if User.current.logged?
		if !params[:filename].nil?
			storage = "#{Rails.root}/tmp/git/"
			send_file "#{storage}#{params[:filename]}", :disposition => 'attachment'
		end
	end
  end
end