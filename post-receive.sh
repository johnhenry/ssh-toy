#!/bin/sh
rm -rf /temp/* # remove files from from temp
rm -rf /temp/.* # remove hidden files from from temp
git clone /.git /temp
rm -rf /live/* # remove files from from live
rm -rf /live/.* # remove hidden files from from live
rsync -rlt --delete  /temp/ /live/ --exclude /.git/ # copy files from temp to live
