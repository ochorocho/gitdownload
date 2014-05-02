# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

post 'gitdownload', :controller => 'gitdownload', :action => 'index'
get 'gitdownload', :controller => 'gitdownload', :action => 'download'