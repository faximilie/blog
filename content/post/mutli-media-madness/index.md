+++
title = "Mutli-media Madness"
subtitle = "Watching anime has never been so hard"

# Add a summary to display on homepage (optional).
summary = ""

date = 2020-06-21T14:43:59+10:00
draft = true

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
This external script will query the Plex API and ensure that Anilist is kept up to date with the watch status.
#### plex-mpv-shim
This allows me to play videos from Plex locally on my favorite web

### Sonarr
### Flexget
#### Flex fix
