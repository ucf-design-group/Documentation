---
title: Server Overview
description: Information about how our servers are set up and the software we use.
---

**Purpose**: To make you familiar and comfortable with how the servers are set up.

**Background**: Before the summer of 2013, OSI used a Windows (IIS) server and offsite hosting to serve all of its sites. This worked well back then, but we soon needed to do more advanced things (for example, host DesignQ / CreativeQ). We leveraged for our own Linux servers, and got two: one for production, and one for development. Management of these servers is up to us.

---

### 1. Accessing the Servers

Before you can access the servers, you'll need an account on the SDES domain. You should contact [DJ at SDES IT](mailto:dj@ucf.edu) to ask for an account and for access. He'll add you to one of two groups: "osi-web user" or "osi-web admin". Users have access to the servers, and admins have administrative (sudo) privileges.

Our two servers are:

* sdesosiweb1.sdes.ucf.edu (a.k.a. osi.ucf.edu) - Production / Live
* sdesosiwebdev1.sdes.ucf.edu - Development

Having two servers allows us to be reckless on one without messing up the experience for people who are actively visiting the other.

We access the servers via SSH (Secure SHell) using a terminal. You'll need to be on a Mac for this to work, or PuTTY on Windows. *Note: SSH access is restricted to users who are on-campus. If you're off-campus, you can use the UCF VPN to get access.*

If you aren't familiar with the Terminal, fear not! Here's a [brief tutorial]({{ site.url }}/server/terminal-primer.html) you can check out.

Here's how you connect to the development server (replacing <SDES Account> with your account, usually your NID):

{% highlight bash %}
ssh <SDES Account>@sdesosiwebdev1.sdes.ucf.edu
{% endhighlight %}

As you type your password, no characters will appear. That's normal. Once you log in, you'll something similar to this:

{% highlight bash %}
Welcome to Ubuntu 12.04.4 LTS (GNU/Linux 3.5.0-49-generic x86_64)

 * Documentation:  https://help.ubuntu.com/

  System information as of Mon Jun 30 12:10:34 EDT 2014

  System load:  0.27                Processes:           174
  Usage of /:   10.4% of 117.13GB   Users logged in:     0
  Memory usage: 48%                 IP address for eth0: 10.171.102.86
  Swap usage:   12%

  Graph this data and manage this system at:
    https://landscape.canonical.com/

2 packages can be updated.
0 updates are security updates.
{% endhighlight %}

These are just some basic statistics about your server. If you ever notice a high memory usage or system load, there are some things you can do to track down the source of the usage and see if something has gone wrong. We'll get to that later.

---

### 2. Operating System

As you can see from the welcome message, our servers run on Ubuntu, which is one distribution of Linux. If you spend any time using Linux via the terminal, you'll notice that it is very similar to using Mac OS X via the terminal. Both operating systems are built on Unix, a very robust set of software that makes for a good server.

Applications in Linux are called packages, and they are very easy to install. We use a program called `apt` to install and update packages. The following 1) updates the list of packages that are available and 2) upgrades existing packages to their latest version. This is a good thing to do on a weekly basis:

{% highlight bash %}
sudo apt-get update
sudo apt-get upgrade
{% endhighlight %}

Notice that we preface the commands with `sudo`. Because updating packages is an important task, you have to run it as the `root` (super-admin) user. Prefacing a command with `sudo` runs it as the root user (if you are allowed to use `sudo`).

Later in this document, we'll outline some of the important packages that are in use on the server.

**Distribution Upgrades**

The official title of the operating system in use at the time of writing is "Ubuntu 12.04.4 LTS". Ubuntu is the distribution, 12 is the year of original release (2012), 04 is the month of original release (April), .4 is the point release (there have been 4 major updates since the initial release), and LTS stands for "Long-Term Service". We use LTS releases of the operating system because they are guaranteed to be supported for 5 years. Even though new versions of Ubuntu are released every six months, the LTS versions continue to get package updates and support.

When a new point-release comes along, you'll notice that there are packages upgrades that aren't completed when you use `sudo apt-get upgrade` (apt will say "the following packages have been held back"). In order to complete the distribution upgrade, you'll have to use `sudo apt-get dist-upgrade`. *You should do this at an hour when not many people are visiting the server.*

When new LTS versions are released, it's up to you to talk about upgrading with DJ from SDES IT (or his eventual replacement).

---

### 3. Apache, PHP, and MySQL

Apache accepts web traffic and serves web pages to visitors. We use Apache because it is the most popular web server; it's easier to get help with Apache than with something like Nginx (Engine X). We also don't get enough traffic to warrant the fast features of Nginx. *Note that most files related to Apache are actually labeled apache2.*

You can learn more about Apache [over here]({{ site.url }}/server/apache.html)

Apache interfaces with PHP quite easily using the `libapache2-mod-php5` package. PHP, by itself, is just a language that can be used to run files; Apache has to supply PHP the files and serve the resulting HTML.

FINDME: more info about PHP...

Similarly, MySQL is just a database to store information; the package `php5-mysql` allows PHP to access and manipulate the information. In reality, we only use MySQL because Wordpress requires it.

For more information about MySQL, check [this]({{ site.url }}/server/mysql.html) out.

---

### 4. Files and Permissions

Unix has a strict system of permissions concerning who can read and write files. The files you'll be most concerned with are those in `/var/www`, the public web files. Inside of `/var/www`, there is one directory per domain or application the server hosts. Files here are set up with group read/write permissions, so that anyone in the `www-data` group can manage them.

Head [over here]({{ site.url }}/server/file-permissions.html) to learn more about permissions.

---

### 5. Transferring Files

As a matter of security, FTP is not intalled on either server. This shouldn't matter, however, as you can use SFTP to connect and transfer files using your SSH login.

We recommend spending the money to get [Transmit](http://panic.com/transmit/); you won't be disappointed. There are free FTP tools like [FileZilla](https://filezilla-project.org/) that you can use.

Here's an example of the settings you need to transfer files to the development server:

* Protocol: SFTP
* Server: sdesosiwebdev1.sdes.ucf.edu
* Port: 22
* Username: <SDES Account>
* Start directory: /var/www