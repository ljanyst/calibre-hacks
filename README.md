calibre-hacks
=============

I use *calibre* primarily to download web content and convert it so that it
could be easily read in the form of an ebook on my kindle. I don't want to
have the *calibre* GUI open to do that. I'd rather have a cron job that does
the right thing freeing me from remembering about repeating this process for
every issue of every e-zine I read. *calibre-hacks* does just that.

journal-plugin
--------------
It's a dummy plug-in that adds some parameters to the ebook-convert program
so that they could be passed further to the selected donwload recipe.

download-and-send.sh
--------------------
A shell script that runs the selected recipe and sends the resulting ebook to
the given email address. Handy for use in cron jobs.

Requirements
------------

The following programs are required:

 * calibre
 * mpack

The recipes make use of the following additional python libraries:

 * pythonmagick
 * lxml

On Debian:

    sudo apt-get install calibre mpack python-lxml python-pythonmagick

Installation
------------
You need to install the journal-plugin by running the following in the root
directory of this repo:

    calibre-customize -b journal-plugin

Usage
-----

**ebook-convert**:

    ebook-convert lwn/input.recipe lwn_current.mobi     \
        --username=your_username                        \
        --password=your_password                        \
        --journal-download-issue=0                      \
        --journal-cover=/absolute/path/to/lwn/cover.png

     ebook-convert lwn/input.recipe blah.mobi --journal-list-issues=true

**download-and-send.sh**: edit the *username*, *password* and *issue* files in
the recipe subdirectory and run:

    ./download-and-send.sh lwn blah@kindle.com

