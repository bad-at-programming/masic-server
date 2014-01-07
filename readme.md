Masic Server
==============

A web application designed to store and share music libraries.


Song Storage
-------------
Songs are stored on the server as .mp3 files

Song Creation
----------------
Songs can be uploaded as an .mp3 file, OR a youtube link to it can be provided. The server will then download the video, convert it to mp3, and then save it.

Playlists
-----------
Playlists have a HABTM relationship with songs. Many songs can have belong to playlists, etc.

Playlist creation
--------------------
Playlists will be created in the various GUIs, hopefully in a pretty interface with drag+drop, YouTube import, iTunes import, etc.



Server Setup
==============
If you clone this project, you will need a few dependencies

MPlayer and LAME
-----------------
This project requires MPlayer and LAME. They must be accessible in your PATH (easiest way to do this is with apt-get)

`sudo apt-get install mplayer`

Or, you could manually install it to /bin if apt-get does not work.

Any2mp3.sh
------------
This file must also be in your path. A simple google search should find it. Or you can copy/paste it from here: http://askubuntu.com/a/84613
It uses MPlayer and LAME to convert *any* multimedia format to mp3. This can also be used later to allow clients to upload multimiedia in any format (instead of just mp3).

Database creation
-------------------
Simple, standard stuff. 
`rake db:create ; rake db:migrate`

Miscellaneous
=============

* Be sure to run `bundle install`

* There will be a test suite eventually

To-Do
======

* Port youtube-dl to Ruby or C (for maintainability or speed, not sure which to go with yet)

* Implement playlists

* Develop a web interface with an inline mp3 player and use AJAX to avoid resetting song play state

* Build desktop applications (I am doing this right now, See mavvie/masic-client on github, using Qt to make a simple iTunes-like media player that will hopefully be cross platform)
