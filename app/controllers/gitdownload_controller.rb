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
			system("find #{storage} -type f -mmin +10 -exec rm {} \;")
			
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

  				send_file "#{storage}#{filename}", :disposition => 'attachment'
			end			
		else
			#@gitAjax = ['status' => 'error']
		end 

		#render json: @gitAjax
	else
		#@gitAjax = ['status' => 'error', 'permission' => 'false']
		#render json: @gitAjax
	end
  end
end