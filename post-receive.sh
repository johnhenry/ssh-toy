#!/bin/sh
rm -rf /temp/* # remove files from from temp
rm -rf /temp/.* # remove hidden files from from temp
git clone /.git /temp
# cd /temp && sudo act push #TODO does not write to directory (even when run outisde of docker?
export DIR=.
rsync -rlt --delete  /temp/$DIR /live/ --exclude /.git/ # copy files from temp to live
