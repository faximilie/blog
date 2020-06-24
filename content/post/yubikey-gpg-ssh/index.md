---
title: "Yubikey Gpg Ssh"
date: 2019-08-23T10:34:19+10:00
draft: true
---

## Preface

Starting my new job at [ac3](https://ac3.com.au) meant I needed to sign all git
commits, along with having an SSH key [^1] associated with my user.

Lucky for me I managed to grab a LOT of free yubikeys at
[AISA 2018](https://cyberconference.com.au/).

## Requirements

Currently, while I am a cryptonut, I don't actually use the GPG key outside of
signing commits, and sshing into company managed servers.

So there's little point in me spending the time to generate keys on an airgapped
machine, and store an encrypted offline backup somewhere safe.

If I lose the yubikey, I can simply generate new keys and assign them on github
and deploy them to the required servers.

Not an ideal setup, but good enough.

[^1]: See [here](/post/avoiding-shared-ssh-aws)
