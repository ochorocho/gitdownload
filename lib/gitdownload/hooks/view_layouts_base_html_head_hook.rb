module Gitdownload
  class Hooks < Redmine::Hook::ViewListener
    class ViewLayoutsBaseHtmlHeadHook < Redmine::Hook::ViewListener
      def view_layouts_base_html_head(context={})
		  content = stylesheet_link_tag('application', :plugin => 'gitdownload')
		  content += javascript_include_tag('script.js', :plugin => 'gitdownload')
		  content += javascript_include_tag('jquery.clippy/jquery.clippy.js', :plugin => 'gitdownload')
      end
    end
  end
end
