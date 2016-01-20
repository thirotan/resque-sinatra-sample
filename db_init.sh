#!/bin/sh

myuserte user 'www'@'localhost' identified by 'www';
mysql -h localhost -u www -p sinatra_db < sql/schema.sql
