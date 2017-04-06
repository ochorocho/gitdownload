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
git clone https://github.com/ochorocho/gitdownload.git
```

_Run plugin migration_

```
cd /your/redmine/root/
rake redmine:plugins:migrate RAILS_ENV=production
```

_Restart Redmine:_

```
touch tmp/restart.txt
```

** IMPORTANT: **

* Permissions are tied to "commit_access"
* Make sure "Hostname" and "Protocol" is set correctly under Administration -> Plugins -> Gitdownload -> Configure!
* On the plugins configuration site set the GIT Url

## Features

* export branches
* export specific changeset
* choose format for export, tar.gz or zip
* show and copy repository path
* Initialize repository when created in Redmine
* Insert default files to created repository
* Editable .gitconfig to use with Redmine