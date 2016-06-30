# gitdownload

## Requirements

* Linux/Unix based OS
* GIT installed

## Should work with ...
 * Redmine >= 2.6
 * Redmine 3.x
 * Git >= 1.9

## Installation

_Clone repository:_

```
git clone https://github.com/ochorocho/gitdownload.git
```

_Restart Redmine:_

```
cd /your/redmine/root/
touch tmp/restart.txt
```

** IMPORTANT: **

* Permissions are tied to "commit_access"
* Make sure "Hostname" and "Protocol" is set correctly!
* On the plugins configuration site set the GIT Url

## Features

* export branches
* export specific changeset
* choose format for export, tar.gz or zip
* show and copy repository path
