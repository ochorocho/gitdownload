Redmine::Plugin.register :gitdownload do
  name 'Gitdownload plugin'
  author 'Author name'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
  
  settings :default => {'git_url' => 'http://your.git.url/git/',
  		'git_show_repourl' => "1",
  		'git_show_branch' => "1",
  		'git_show_revs' => "1"}, :partial => 'settings/gitdownload'
end

# VIEW HOOKS
require 'gitdownload/hooks/view_layouts_base_html_head_hook'
require 'gitdownload/hooks/view_repositories_show_contextual'
