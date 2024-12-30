#!/bin/bash

rewrite() {
        echo Rewriting $1
        sed -i 's\# baseurl=https://repo.almalinux.org\baseurl=http://repo.local.koryalbert.net\g' $1
        sed -i 's\mirrorlist=\#mirrorlist=\g' $1
}

rewrite '/etc/yum.repos.d/almalinux-appstream.repo'
rewrite '/etc/yum.repos.d/almalinux-baseos.repo'
rewrite '/etc/yum.repos.d/almalinux-extras.repo'