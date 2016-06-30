Redmine::Plugin.register :gitdownload do
  name 'Gitdownload plugin'
  author 'Jochen Roth'
  description 'Enable Redmine to export/archive GIT repositories'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
  
  permission :commit_access, :gitdownload => :index
  
  settings :default => {'git_url' => 'http://your.git.url/git/',
  		'git_show_repourl' => "1",
  		'git_show_branch' => "1",
  		'git_show_revs' => "1",
  		'git_archive_last' => "10"}, :partial => 'settings/gitdownload'
end

# VIEW HOOKS
require 'gitdownload/hooks/view_layouts_base_html_head_hook'
require 'gitdownload/hooks/view_repositories_show_contextual'
require 'gitdownload/hooks/view_projects_show_right'