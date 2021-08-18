#!/bin/sh
rm -rf /live/*
rsync -rlt --delete  /www/ /live/ --exclude /.git/
