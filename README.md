# gitdownload

## Requirements

* Linux/Unix based OS
* GIT installed

## Should work with ...
 * Redmine >= 2.6
 * Git >= 1.9

## Installation

_Clone repository:_

```
cd /your/redmine/root/plugins/
git clone https://github.com/ochorocho/gitdownload.git
```

_Run plugin migration_

```
cd /your/redmine/root/
rake redmine:plugins:migrate RAILS_ENV=production
```

_Install rack-cors:_

Follow https://github.com/cyu/rack-cors to install rack-cors and create `$REDMINE_HOME/config/initializers/cors.rb` with following content:

```
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: [:get, :post, :patch, :put]
  end
end
```

_Restart Redmine:_

```
touch tmp/restart.txt
```

## Uninstallation

_Undo plugin migration_

```
cd /your/redmine/root/
rake redmine:plugins:migrate NAME=gitdownload VERSION=0 RAILS_ENV=production
```

_Delete gitdownload plugin directory:_

```
rm -rf /your/redmine/root/plugins/gitdownload
```

_Delete cors middleware:_

```
rm /your/redmine/root/config/initializers/cors.rb
```

_Restart Redmine:_

```
touch tmp/restart.txt
```

**IMPORTANT:**

* Permissions are tied to "commit_access"
* Make sure "Hostname" and "Protocol" is set correctly under Administration -> Plugins -> Gitdownload -> Configure!
* On the plugins configuration site set the GIT Url
* For authentications repositories needs a name following tis schema `<project identifier>.<repository identifier>.git` e.g. mytestrepo.typo3.git (just leave the name as generated)

## Features

* export branches
* export specific changeset
* choose format for export, tar.gz or zip
* show and copy repository path
* Initialize/create repository when created in Redmine
* Insert default files to created repository
* Editable .gitconfig to use with Redmine
