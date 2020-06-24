+++
title = "Mutli-media Madness"
subtitle = "Watching anime has never been so hard"

# Add a summary to display on homepage (optional).
summary = ""

date = 2020-06-21T14:43:59+10:00
draft = false

# Authors. Comma separated list, e.g. `["Bob Smith", "David Jones"]`.
authors = ["Faximilie"]

# Is this a featured post? (true/false)
featured = true

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["automation", "multimedia", "api"]
categories = ["automation"]

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["deep-learning"]` references 
#   `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
# projects = ["internal-project"]

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder. 
[image]
  # Caption (optional)
  caption = ""

  # Focal point (optional)
  # Options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
  focal_point = ""
+++

## The problem
So I'm a bit of a weeb, and enjoy watching anime from time to time. However I often find myself forgetting my place during the weeks between episodes. This often leads me to drop an anime because I can't find the right episode before losing motivation.

I also have the issue of friends recommending me an anime, and I will forget it well before I get a chance to watch it.

Enter Anilist/MyAnimeList, the anime tracking services similar to track.tv. This fixes both problems of tracking watched episodes, and new series to watch. However it introduces new issues, manually updating watched status.

Now I'm a SecDevOps engineer, I won't stand for manual intervention. So let's automate __everything__.
## Components
As mentioned before Anilist is a key component of my setup, however there are a lot of other moving parts at work here to ensure little to no manual intervention is required.

### Kodi
Kodi is the HTPC interface, allowing me to utilize plex as a media library, while still providing a nice interface and other features independent of plex.

Being able to start steam big picture, or watch youtube is nice.
#### Kodi Plex
This kodi plugin automatically syncs plex and kodi, letting kodi be the nice frontend while plex does all the hard work.

It ensures watch status, and the library is synced, and will get plex to stream the transcoded videos to kodi.

### Plex
Plex provides the backbone of my media library. Transcoding, mobile syncing, and most importantly: the plex anilist sync script.

#### Plex anilist sync
This external script will query the Plex API and ensure that Anilist is kept up to date with the watch status. The repo can be found here: https://github.com/RickDB/PlexAniSync
#### plex-mpv-shim
This allows me to play videos from Plex locally on my favorite media player, while still syncing, transcoding and such.
It's a very important feature, that allows me to really save battery on the go.

This project can be found here: https://github.com/iwalton3/plex-mpv-shim/issues

### Sonarr
Somehow I need to get the anime, this is the job of sonarr which... "procures" the files through totally legal channels.
I won't say anymore on sonarr sadly, despite how amazing it really is.

### Flexget
Flexget is the glue that holds most things together, it provides the mechanism of getting my Anilist watchlist into sonarr to be "procured" automagically. However there seems to be a bug which caused me to write a fix in the most horrific way.

#### Flex fix
It seems if a show already exists in sonarr it will return a 500, and give the reason. A sane program would accept this 500 and move on, knowing it was not a severe error. However flexget does not do this, it errors out when 500 is returned for *any reason* which is rather frustrating. It also expects the show details to be returned when it 200s on that same request, so one can not simply have it replace 500 status codes with 200.

To fix this error, you must intercept all requests, and when a 500 error occurs for an existing show, you must then lookup that existing show through the sonarr api, and return those details to flexget with a 200 http code. This python script does exactly that, acting as a proxy, listening on a port below sonarr and connecting to sonarr itself.

Here it is below, eventually this will be put in gist, but not at the moment.

```python
from http.server import HTTPServer, BaseHTTPRequestHandler
from http.client import HTTPConnection

from io import BytesIO
import json


class SimpleHTTPRequestHandler(BaseHTTPRequestHandler):

    def do_GET(self):
        self.send_response(200)
        api_key = self.headers['X-Api-Key']
        self.end_headers()
        client.request('GET', self.path, headers={'X-Api-Key':api_key})
        self.wfile.write(client.getresponse().read())


    def do_POST(self):
        self.send_response(200)
        self.end_headers()
        content_length = int(self.headers['Content-Length'])
        body = self.rfile.read(content_length)
        # Get API Key
        api_key = self.headers['X-Api-Key']
        body_json = json.loads(body.decode('utf8'))

        # Strip everything but ID
        new_body = {i:body_json[i] for i in body_json if i!='id'}

        # Make a connection to sonarr on behalf of the requester
        client.request('POST', self.path, headers={'X-Api-Key':api_key}, body=json.dumps(new_body))
        resp = client.getresponse()
        # If 400 we're gonna do the fix
        if resp.status == 400:
            resp.read()
            # Get the details of the series from sonarr and send it back to the sender pretending they added it
            client.request('GET', '/api/series/' + str(body_json['id']), headers={'X-Api-Key':api_key})
            self.wfile.write(client.getresponse().read())
        else:
            # If it's another code we simply return what we got
            self.wfile.write(resp.read())


client = HTTPConnection('127.0.0.1:8989')
httpd = HTTPServer(('127.0.0.1', 8988), SimpleHTTPRequestHandler)
httpd.serve_forever()
```
