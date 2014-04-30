module Hidejournal
  class Hooks < Redmine::Hook::ViewListener
    render_on :view_repositories_show_contextual,
              :partial => 'hooks/gitdownload/view_repositories_show_contextual'
  end
end
