# Welcome to the musicApp

What this application aims to achieve is free mp3 files with the correct header tags which at first will be sccraped from the web to build up the database but the service runs through the local database first to reduce reliance on external factors.

The first step in a search is reliant on the youtube data v3 api to access public records so doesnt go through OAuth2.0 but when a user clicks the link the respective videoID which is then compounded with the youtube watch URL which is what the `youtube-dl` CLI shellscript file expects and then downloads videos and rips the audio 

This is my pet project and therefore will always be in development.

At the moment i have included the Devise gem but haven't implemented it

The idea is that it will ber possible to have your whole library on the server in ActiveStorage which will allow you to never lose your music library
The main advantage is that the downloaded files are in mp3 format which allows you to do more withthem when they are downloaded locally such as using your favourite mp3 player instead of being limited by the fact that Spotify is the only player you can work with

The first release of this webapp will only change the header tags and album art of the mp3 file and make it downloadable for the user

## Future Improvements:
* Implementing Devise properly
* Recording Users playlists and songs 
* Implementing Related random shuffles and a suggested feed 
* streaming service
* Progressive web app that caches music
* add workers 
* add trimming tool to remove unnecesary noise
* add analytics