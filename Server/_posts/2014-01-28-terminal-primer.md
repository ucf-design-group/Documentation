---
title: Terminal Basics
description: A quick guide on using the Terminal to help you get familiar.
---

**Purpose**: To help you get comfortable using the Terminal, since you'll end up using it at some point. This guide assumes that you have no experience with Terminal, but even if you do, it can be a good refresher.

**Background**: Several common tasks require using the terminal: regular maintenance of the servers, setting up and using Grunt or Gulp for asset compilation, correcting permissions on web files, etc. The terminal can be scary when you're first starting out, and I'm not going to discourage that fear. **You can mess up a lot of things in the terminal, and it won't think twice about letting you do it.** But, with that responsibility comes great power.

**Caveats**: The lessons given here apply to using the terminal on Mac OS X or Linux. The Windows command line is not comparable in any way. If you must use Windows, look into installing Cygwin.

---

### Guided Tour

Let's get started with some basic, safe commands. Open up a Terminal window and type `pwd`. Your screen should look something like this (if you aren't on a Mac, it may be different):

{% highlight bash %}
Last login: Mon Jun 30 14:00:00 on console
cf-148486:~ aa123456$ pwd
/Users/aa123456
{% endhighlight %}

What just happened? You opened a terminal window, and it started a new session for you. You can have as many sessions running concurrently as you'd like; Unix is a truly multi-user operating system (unlike Windows). It gave you a prompt, like `cf-148486:~ aa123456$`, which tells you 1) the machine you're logged into, where you are (`~` represents your home directory), and which user you're logged in as. The `$` also tells you that you're logged in as a normal user - if you log in as the root user, you'll see a `#` instead.

You typed `pwd`, which stands for "present working directory", and the terminal gave you `/Users/aa123456` in response. If that's your first terminal command, congratulations! That's how terminal works. It's a call-and-response type of thing, where you give it commands and it responds by printing information or performing actions.

I won't type the prompt when I give you commands to type, but know that it will be there before everything you type.

Try the `ls` command. This lists the files and directories that reside in your present working directory. If you are indeed in your home directory, you'll probably see Documents, Downloads, etc.

Let's create a directory and try out some basic file manipulation.

{% highlight bash %}
mkdir Testing
ls
{% endhighlight %}

You've just created a directory (`mkdir`) and used `ls` to see that it's there. Now let's use `cd` to change directories into the one you just created.

{% highlight bash %}
cd Testing
{% endhighlight %}

*Protip: there's this thing called tab-completion. If you type "cd Tes" and hit tab, assuming that there aren't any directories other than "Testing" that begin with "Tes", the terminal will fill in the rest for you.*

Run `pwd` again to see that you've moved into the Testing directory. Run `ls` to see that there aren't any files inside of it - you only just created it, after all.

Let's create a file.

{% highlight bash %}
touch hello.txt
{% endhighlight %}

`touch` creates a file if it doesn't exist, and updates the "modified" timestamp if it does. Now, let's rename the file. In terminal, renaming is the same as moving a file:

{% highlight bash %}
mv hello.txt hi.txt
{% endhighlight %}

Editing a file can be a little complicated in terminal. We're going to use a program called Nano, which is probably the easiest for beginners. Super-users will eventually learn Vim or Emacs, and then fight about which is best forevermore.

{% highlight bash %}
nano hi.txt
{% endhighlight %}

You're now in nano, editing an empty file. Feel free to type something in, add line breaks, etc. Note that you can't use your mouse, so make friends with the arrow keys!

When you're done editing the file, save it using `ctrl+o` (yes, `ctrl`, even on Mac), and exit with `ctrl+x`. You can check that your file has its new contents by running `cat hi.txt`. `cat` outputs the contents of a file.

Let's make a copy and remove the original file:

{% highlight bash %}
cp hi.txt bonjour.txt
rm hi.txt
{% endhighlight %}

Well, not so bad, right? There's plenty more to do in the terminal, but it's best to learn as you go. Google, and Stack Overflow, are your friends.

Let's clean up our little testing area:

{% highlight bash %}
rm bonjour.txt
cd ..
rmdir Testing
{% endhighlight %}

Using `cd ..` moves "up" one directory, to its parent. *Note: using `cd` by itself moves you to your home directory by default.*

---

### Anatomy of a Command

Here's an excerpt from the manual page for `ls` that can be found by running `man ls` on a Linux machine:

{% highlight bash %}
SYNOPSIS
       ls [OPTION]... [FILE]...
DESCRIPTION
       List  information  about the FILEs (the current
       directory by default).  Sort entries alphabetically
       if none of -cftuvSUX nor --sort is specified.

       Mandatory arguments to long options are mandatory
       for short options too.

       -a, --all
              do not ignore entries starting with .
{% endhighlight %}

Manual pages are helpful because remembering all of the commands and their options is impossible. Let's break down the `ls` command in its entirety:

{% highlight bash %}
ls [OPTION]... [FILE]...
{% endhighlight %}

* `ls` is the command itself.
* Options, or flags, give additional information about how you want `ls` to run. For example, `-a` tells `ls` to display all files, including hidden files. `-l` tells it to give the long-form of the listing, which tells you a file's owner, group, and permissions. You can combine flags, like `-al` or `-la`. Some flags require more information, `ssh aa123456@sdesosiwebdev1.sdes.ucf.edu -p 8022` tells `ssh` to connect to port 8022.
* For `ls`, you can optionally supply a file or directory to run `ls` on. This is useful if you want to list files inside of a directory besides your present working directory.

---

### Quick Reference

* `cat [file]` - output the contents of the file.
* `cd [blank or directory]` - change directory to the specified directory, or to your home directory if blank.
* `ls` - list the files and directories in your present working directory.
	* `ls -a` - list all files and directories, including hidden ones.
	* `ls -l` - list all files and directories, and their permissions.
	* `ls -al` - list all files and directories, including hidden ones, and their permissions.
* `man [command]` - display the manual for the given command.
* `mv [file] [destination]` - move or rename a file.
* `nano [file]` - edit a file using Nano.
* `pwd` - display the present working directory.
* `rm [file]` - remove the given file. **Warning**: this is permanent.
* `rmdir [directory]` - remove the given directory. **Warning**: this is permanent.
* `touch [file]` - create a file, or update its "last modified" timestamp if it already exists.
