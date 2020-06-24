---
title: Becoming a Command Line Ninja
summary: Using the Linux CLI to do things quickly
authors: [ "admin" ]
tags: [ "Linux", "CLI", "Workflow", "Slide" ] 
categories: ["CLI"]
date: "2019-05-22:00:00Z"
slides:
  theme: black
  highlight_style: dracula
---

# Becoming a Command Line Ninja

---
## About me

-   Patrick Childs
-   Associate Global Tech ops Engineer at tigerspike
-   Terminal Junky
-   Really lazy
-   Like REALLY lazy
-   Hates typing
-   Hate mice even more

{{< speaker_note >}}
-   You may know me
-   Terminal junky
    -   Made talk with CLI
-   Lazy
    -   Really lazy
    -   bound nvim to v
-   I have an adversion to typing
    -   GUIs require you to type more
    -   can't scipt GUIs

{{< /speaker_note >}}


---
## Why use the Terminal

-   Fast, and accurate
-   Mice suck
-   Allows scripting, which reduces repetition and thus mistakes
-   String commands together to fit your workflow
-   Unix Philosophy: Do one thing and do it well

{{< speaker_note >}}
-   Mice suck
    -   They're slow and inaccurate
-   Unix philosophy
    -   Most CLI applications follow Unix philosohpy

{{< /speaker_note >}}


---
## Example

![Finding the largest folder modified within 30 days](./CommandLineFu/Images/Largest folders modified in the last 30 days.png)


---
## How to Git Gud with the CLI


---
## Learn CoreUtils

-   cat
-   Grep
-   sed
-   find


---
## Learn to modify data

-   head
-   tail
-   awk
-   Everything is a list of strings


---
## Learn to use the Shell

![img](./CommandLineFu/Images/My Shell.png "My Shell")

-   BASH and ZSH are shells
-   It's what you interact with


---
## Shell shortcuts

-   Directory stack
    -   pushd
    -   popd

-   History searching
-   Parameter history
    -   !$
    -   !2
    -   `sudo !!`


---
## Stop repeating yourself

-   Learn to script
-   If you do it once, that's already too many times
-   Do it now so you can be lazy later


---
## Find hackable programs

-   Means you can modify them to how **\*you** want


---
## Programs like

-   Ripgrep
-   FZF
-   Vim
-   Ranger
-   Tmux
-   FASD
-   Taskwarrior


---
## Programs to use


---
## Ripgrep

-   Source code searcher
-   Like grep, ack and the silver searcher
-   Super fast
-   Ignores `.git`
-   Ignores based on `.gitignore` and `.ignore` files


---
## FZF

-   Fuzzy searcher
-   Takes any line delimited input on `STDIN`
-   Prints selected to `STDOUT`
-   Without `STDIN` defaults to files
-   Great for scripts


---
## FZF demo

{{< speaker_note >}}
-   Fuzzy files
-   Fuzzy git
-   Fuzzy history

{{< /speaker_note >}}


---
## Ranger

-   CLI File explorer
-   Powerful and scriptable
-   Knows when to defer tasks to other programs
-   Bulk renaming through text editing
-   Searching through FZF


---
## Ranger demo


---
## Vim

-   Vim is old
-   Vim is different
-   Vim is amazing

-   Vim is old
    -   Has it's roots in an editor from the 1970s

-   Vim is different
    -   It's a modal editor


---
## Reasons to use vim

-   It's fast to startup
-   It's fast to use
-   It uses almost no memory
-   You're already in the terminal, why bother with GUI
-   Reduces key presses


---
## Modal Editor

-   Vim is a model editor
-   Based around the idea of making agnostic, atomic and repeatable
    changes


---
## What the hell does that mean?

-   Surround this word with quotes
-   Delete 3 paragraphs
-   Swap every third word that matches what is in my clipboard


---
## Vim plugins

-   Vim has at least 16000 plugins
    -   More than Sublime, or Atom

-   Has own language called VimScript
-   Plugins that integrate with FZF and Ripgrep
-   Snippets


---
## Snippets

-   UltiSnippets is probably the best around
-   Python and Vimscript evaluation of default values

Which means you can have it fill in the blanks programatically


---
## Vim demo

{{< speaker_note >}}
Look through bkash find bkash.yaml filter lines to find rds template
goto file fzf files make change show off magit

{{< /speaker_note >}}


---
## FASD

-   Frecencey fuzzy matching (frequency + recency)
-   F for files
-   A for All
-   S for interactive search
-   D for directories
-   Z for autojump to drectory


---
## Fasd demo


---
## TMux

-   Terminal multiplexer
-   Window manager for your terminal
-   Gives you windows, tabs, and sessions
-   Is scriptable, so you can make it create a workspace for a specific
    project


---
## Taskwarrior

-   Hackable, extensible task management system
-   Scriptable, and plugin support
    -   Bugwarrior - Email and Jira integration

-   Time tracking
-   Tags (many to many)
-   Projects (many to one)


---
## Takeaways

-   Stop repeating yourself (make scripts)
-   Be lazy and hate typing
-   Find ways you can integrate everything
-   Don't be afraid to try new things and put some elbow grease into a
    task

