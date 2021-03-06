PEX - Photo Engine X
====================

A photo gallery with next to no chrome, written in lua deploying with nginx
See demo at <http://pix.hveem.no>


 * Full width and responsive design
 * Simplistic interface
 * Expirable shareable URLs for albums to share with friends
 * Super fast
 * Open source
 * Backend in MoonScript (Lapis Framework)
 * Runs on nginx (openresty)
 * Postgres as database
 * Redis as queue
 * AngularJS admin panel
 * Download albums as ZIP archive
 * Multi user
 * Display exif info

Features planned
================

 * Anonymous galleries
 * Linux utility that uploads images based on foldernames using API
 * Share from android ?
 * Sorty/query exif
 * Show disk space used
 * Tags
 * Organize photos into albums/tags
 * Date picker to find photos in a given time period
 * A "drop box" for fast/easy upload

Installation
================

*Warning*, this software project uses lots of uncommon requirements, so it can be a bit tricky to install.

Watch Leafo's Lapis screencast to get familiar with Lapis <http://www.youtube.com/watch?v=Eo67iTY1Yf8>
It includes information that is relevant to this development process.

```
$ sudo apt-get install luajit
$ sudo apt-get install luarocks
$ sudo apt-get install postgresql

$ luarocks install bcrypt
$ luarocks install lapis
$ luarocks install md5
```


Hacking
=======

Docker lets you share a directory from the host to the container using the *-v* argument, so if you want to hack on the source you can check out the source on the host as you usually would do and then share the directory to the container like this:

    $ docker run -i -p 8080:8080 -v /home/tor/projects/pix:/pix -t torhve/pix

This maps the directory /home/tor/projects/pix to the container directory /pix.

Then you would want to install <http://gittup.org/tup/> on the host to automatically compile MoonScript to Lua and LESS to CSS.
I could not get tup working inside the docker since it requires FUSE filesystem which did not work in the container.

Tup installation on Ubuntu:

    sudo apt-add-repository 'deb http://ppa.launchpad.net/anatol/tup/ubuntu lucid main'
    sudo apt-get update
    sudo apt-get install tup

Tup first time:

    cd /home/tor/projects/pix
    tup init
    tup upd

Tup each time:

    tup monitor -a


If you do not want to run Redis and PostgreSQL inside the container, but rather on the host itself you have to get the postgresql daemon and the redis daemon to listen on the docker0 interface IP on the host. And then have the container configuration connect to the docker0 IP for redis and postgresql.



PIX Configuration is in etc/config.json and config.moon

Deployment
==========

Use nginx with proxy_pass (or similar) to the exposed lapis port.
You can then start a different lapis configuration like this:

    $ docker run -i -p 8181:8080 -v=/home/tor/src/pix:/pix -w=/pix -t torhve/pix lapis server production

