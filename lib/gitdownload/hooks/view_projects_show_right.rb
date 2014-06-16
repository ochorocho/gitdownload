module Hidejournal
  class Hooks < Redmine::Hook::ViewListener
    render_on :view_projects_show_right,
              :partial => 'hooks/gitdownload/view_projects_show_right'
  end
end
