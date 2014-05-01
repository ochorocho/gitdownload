class GitdownloadController < ApplicationController
  unloadable

  def index
  
	if User.current.allowed_to?(:commit_access, @project)
		if !params[:journal].nil?
#			@journalHide = Journal.find(params[:journal])
# 			if @journalHide.private_notes?
# 				@journalAjax = ['status' => 'success', 'changed_to' => 'false']
# 				
# 				@journalHide.private_notes = '0'
# 				@journalHide.save
# 			else
# 				@journalAjax = ['status' => 'success', 'changed_to' => 'true']
# 
# 				@journalHide.private_notes = '1'
# 				@journalHide.save
# 			end
			
		else
			@gitAjax = ['status' => 'error']
		end 

		render json: @gitAjax
	else
		@gitAjax = ['status' => 'error', 'permission' => 'false']
		render json: @gitAjax
	end
  end
end
