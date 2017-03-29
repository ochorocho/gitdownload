require_dependency 'repositories_controller'

module RepositoriesControllerPatch
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development
      alias_method_chain :create, :patch
#       alias_method_chain :update, :patch
    end
  end

  module InstanceMethods

      def create_with_patch
        attrs = pickup_extra_info
        @repository = Repository.factory(params[:repository_scm])
        @repository.safe_attributes = params[:repository]
        if attrs[:attrs_extra].keys.any?
          @repository.merge_extra_info(attrs[:attrs_extra])
        end
        @repository.project = @project
        if request.post? && @repository.save
          redirect_to settings_project_path(@project, :tab => 'wiki')
        else
          render :action => 'new'
        end
      end
        
#       def update_with_enhance
#         attrs = pickup_extra_info
#         @repository.safe_attributes = attrs[:attrs]
#         if attrs[:attrs_extra].keys.any?
#           @repository.merge_extra_info(attrs[:attrs_extra])
#         end
#         @repository.project = @project
#         if @repository.save
#           redirect_to settings_project_path(@project, :tab => 'wiki')
#         else
#           render :action => 'edit'
#         end
#         true
#       end

  end
end

RepositoriesController.send(:include, RepositoriesControllerPatch)