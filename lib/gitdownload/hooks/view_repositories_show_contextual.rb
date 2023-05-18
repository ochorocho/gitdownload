module Gitdownload
  module Hooks
    class ViewRepositoriesShowContextual < Redmine::Hook::ViewListener
      render_on :view_repositories_show_contextual,
                :partial => 'hooks/gitdownload/view_repositories_show_contextual'
    end
  end
end
