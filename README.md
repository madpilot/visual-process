# Visual Process

This is a Processing.js experiment. It visualises the Process table on your UNIX (tested on OSX and Linux) computer.

Simply fire up the Sinatra app, and point your modern browser (no IE please) and watch the process balls fly around the screen.

The bigger the ball, the more memory it takes. The higher the ball, the more CPU time it is taking.

## Screenshot:

![Alt Screenshot](http://dl.dropbox.com/u/26498/visual-ps.png)

See a bad quality [video of it here](http://www.youtube.com/watch?v=TQTLYG1qZRI)

## Make it work on another server

Setup SSH certificates so the sinatra app can login to the remote server, then change line 16 to something like:

`` ps = `ssh [user@hostname] 'ps aux'` ``

## TODO

1. Make the code more efficient
2. Automatically adjust for screen sizes - it's all very hard-coded for 640x480 at the moment

