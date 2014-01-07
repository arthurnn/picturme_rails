Pictur.me RoR project
=====================

This is a version of the original http://pictur.me, however made in Ruby on Rails. 
The original pictur.me is done using python/Django however this a good example that things can be done in any technology.


Instructions
============

* bundle install
* mysqladmin -uroot -proot create picturme_db
* rake db:migrate
* mysql -uroot -proot picturme_db < db/dump.sql
* rails server

Authors
-------
@arthurnn


Special thanks for "MagLev Engineering Team" for the KD-tree implementation.
https://github.com/MagLev/maglev/tree/master/examples/persistence/kdtree/


