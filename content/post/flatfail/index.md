+++
title = "Flatfail"
subtitle = "How flatpak fails to provide any additional security"

# Add a summary to display on homepage (optional).
summary = "How flatpak provides security theatre, and actually increases one's attack surface."

date = 2019-05-22T21:54:29-04:00
draft = true

# Authors. Comma separated list, e.g. `["Bob Smith", "David Jones"]`.
authors = ["admin"]

# Is this a featured post? (true/false)
featured = true

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["Sandbox", "Namespaces", "Security", "Fail"]
categories = ["Security"]

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

So after re-installing fedora and having some trouble with firejail, which is discussed further here, I decided to try out flatpak's sandboxing features. After having done what I always do with new security solutions, try to break it, I discovered that there are many flaws inherent in flatpak's approach to security.

## What is flatpak

Flatpak is self-described as "The future of apps on Linux", and is a new-age application manager developed mainly by RedHat. It tries to take the Android/iOS approach to application isolation, where each application is sandboxed, and permission has to be requested and approved by the user. It tries to achieve this through sandboxing applications using Linux Namespaces, and limiting Kernel calls available to the application.

## How not to make a Sandbox

Sandboxes are supposed to restrict access to a system in various ways, such that a sandboxed application is isolated from the rest of the system. In principle, these can be incredibly powerful, providing comprehensive protections from malicious code. The main benefit of this, is not to run un-trusted code, but to prevent exploited applications from pivoting, or maintaining persistence.

It's inherently hard to escape a sandbox, in fact sandbox escapes are quite valuable as exploits. That being said, a sandbox is only as strong as it's policies. If a sandbox does not properly police access, it can be trivial to escape. So it's incredibly important to make sure policies are properly setup.

This is where Flatpak's first mistake is made, almost all major applications have write access to a user's home directory, leaving many opportunities to escape the sandbox. Writing to `.bashrc` or `.profile` can provide a method of privilege escalation
