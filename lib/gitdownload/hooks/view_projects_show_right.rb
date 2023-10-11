module Gitdownload
  module Hooks
    class ViewProjectsShowRight < Redmine::Hook::ViewListener
      render_on :view_projects_show_right,
                :partial => 'hooks/gitdownload/view_projects_show_right'
    end
  end
end
