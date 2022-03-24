require 'redmine'


Rails.configuration.to_prepare do
  require_dependency 'gitdownload/repositories_controller_patch'
end

Redmine::Plugin.register :gitdownload do
  name 'Gitdownload plugin'
  author 'Jochen Roth'
  description 'Enable Redmine to export/archive GIT repositories'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  permission :commit_access, :gitdownload => :index

  settings :default => {'git_url' => 'http://your.git.url/git/',
               'git_show_repourl' => "off",
               'git_show_branch' => "on",
               'git_show_revs' => "on",
               'git_archive_last' => "10",
               'git_repo_is_remote' => "off"}, :partial => 'settings/gitdownload'
end


# VIEW HOOKS
require 'gitdownload/hooks/view_layouts_base_html_head_hook'
require 'gitdownload/hooks/view_repositories_show_contextual'
require 'gitdownload/hooks/view_projects_show_right'