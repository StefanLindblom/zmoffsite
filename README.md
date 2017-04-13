# zmoffsite
Small script for handling ZoneMinder offsite uploads

Purpose
=======
I created this to handle my ZoneMinder offsite uploads.
My ZoneMinder setup at home will automatically upload images when motion is detected via SFTP to a server in the "cloud".
This little script unarchives the uploaded images, and lets me browse them via HTTP.
It adds the same html-file with a simple JavaScript based viewer as ZoneMinder itself uses when you export events.

Installation
============
- Set up your ZoneMinder instance to upload (see options) events (using filters) as TAR-files
- The default location I've configured in the script is /home/zm
- Create a directory where the unarchived files will end up, like /home/zm/untar
- Put this repository's two files in the same directory, make sure zmoffsite-process.sh has chmod +x permissions.
- Add a cronjob to run it automatically (example for every minute: */1 * * * * /home/zm/zmoffsite-process.sh)
- Install a webserver if you like, like nginx, and let this directory be served
