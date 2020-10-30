+++
title = "Outlook Org-mode integration on MacOS"
author = ["admin"]
date = "2020-10-30T15:45:00"
tags = ["orgmode", "outlook", "applescript", "lisp"]
categories = ["Emacs"]
draft = false
summary = "Dealing with Outlook with Emacs on MacOS"
+++

-   State "DONE"       from              <span class="timestamp-wrapper"><span class="timestamp">[2020-10-30 Fri 15:45]</span></span>


## Motivation {#motivation}

So a lot of my notes and tasks will require me to reference outlook items,
either emails or meetings.

There aren't any real solutions for Achieving this on MacOS at the moment, and
the Windows solutions are not too great.

So I decided to create this unholy abomination. I'm sorry.


## Components {#components}

So there's a few moving parts to this, but overall it's mainly leverging
**AppleScript**, **Karabiner** and **Emacs** to provide this functionality.


### AppleScript {#applescript}

Let's start with the MacOS Native automation tools, this is how we'll get the ID
of the Outlook item, which we will need later when searching for it.

There are two AppleScript files, one for inserting a link into the current
buffer, and another for using a capture template. Both are almost identical, but
one evals some Elisp to ensure we insert at the right point and file.


#### Insertion {#insertion}

```applescript
tell application "Microsoft Outlook"
  set theMessages to selected objects
  repeat with theMessage in theMessages
    set toOpen to id of theMessage
  end repeat
end tell

tell application "Emacs" to activate
do shell script "/usr/local/bin/emacsclient --eval '(with-current-buffer (window-buffer) (org-insert-link nil \"outlook:" & toOpen & "\" (read-string \"Link Name:\")))'"
```


#### Capture {#capture}

```applescript
tell application "Microsoft Outlook"
  set theMessages to selected objects
  repeat with theMessage in theMessages
    set toOpen to id of theMessage
  end repeat
end tell

tell application "Emacs" to activate
do shell script "/usr/local/bin/emacsclient \"org-protocol://capture?template=o&id=" & toOpen & "\""
```


### Karabiner {#karabiner}

Karabiner provides a very nice way of running a shell script from a keybind, and
even supports filtering to the correct window. Thus this keybind will only
trigger when Outlook is focused.

<kbd>Command+L</kbd> will insert and <kbd>Command+Shift+L</kbd> will capture

```json
{
    "title": "Outlook-Emacs",
    "rules": [
        {
            "description": "Meta-L to copy outlook item to orgmode",
            "manipulators": [
                {
                    "type": "basic",
                    "from": {
                        "key_code": "l",
                        "modifiers": {
                            "mandatory": ["left_command"],
                            "optional": ["caps_lock"]
                        }
                    },
                    "to": [
                        {
                            "shell_command": "osascript ~/Documents/Store_Selected_OutlookItem_As_Orgmode_Link.scpt"
                        }
                    ],
                    "conditions": [
                        {
                            "type": "frontmost_application_if",
                            "bundle_identifiers": ["^com\\.microsoft\\.Outlook$"]
                        }
                    ]
                },
                {
                    "type": "basic",
                    "from": {
                        "key_code": "l",
                        "modifiers": {
                            "mandatory": ["left_command", "left_shift"],
                            "optional": ["caps_lock"]
                        }
                    },
                    "to": [
                        {
                            "shell_command": "osascript ~/Documents/Capture_Selected_OutlookItem_As_Orgmode_Link.scpt"
                        }
                    ],
                    "conditions": [
                        {
                            "type": "frontmost_application_if",
                            "bundle_identifiers": ["^com\\.microsoft\\.Outlook$"]
                        }
                    ]
                }
            ]
        }
    ]
}
```


### Emacs {#emacs}

There are two parts of this for Emacs, the Capture template, and the custom hyperlink


#### Custom Link {#custom-link}

I just dump this into my startup config, but you could make an `ol-outlook.el`
if you wanted to make it less platform specific.

This relies on MDFind which is the macos spotlight CLI, it will find it, then
open it in outlook.

```emacs-lisp
(require 'ol)

(org-add-link-type "outlook" 'org-outlook-open)

(defun org-outlook-open (id _)
  "Open the outlook item matching that ID"
  (shell-command (format "mdfind \"com_microsoft_outlook_recordID == '%s'\" -0 | xargs -0 open " id)))
```


#### Capture template {#capture-template}

Ideally this should be customized more for your setup, but this is what I use.

```emacs-lisp
(add-to-list 'org-capture-templates '("o" "Outlook item to capture" entry
           (file+headline "~/Documents/Notes/inbox.org" "Tasks")
           "* TODO [[outlook:%:id][%^{Item name|Email}]]" :clock-in t :clock-resume t))
```
