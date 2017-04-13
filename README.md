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

Screenshots
===========
![zmoffsite_1](https://cloud.githubusercontent.com/assets/854197/25024492/7003e3ce-209e-11e7-98a2-741efef7e805.jpg)
![zmoffsite_3](https://cloud.githubusercontent.com/assets/854197/25024490/7000817a-209e-11e7-80b0-715f6b7d34b4.jpg)
![zmoffsite_2](https://cloud.githubusercontent.com/assets/854197/25024491/70026756-209e-11e7-963c-18c1edfa5a95.jpg)
![zmoffsite_4](https://cloud.githubusercontent.com/assets/854197/25024489/70004048-209e-11e7-852f-38bc19e0e7d4.jpg)
In this last screenshot you can see the settings I'm using for the upload tab in ZoneMinder.
