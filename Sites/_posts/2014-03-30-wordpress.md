---
title: WordPress Basics and Setup
description: Overview of WordPress as a Content Management System and how we use it for OSI Agency websites.
---

**Purpose**: To make you familiar with the basics of WordPress and how we use it for the OSI Agency websites.

**Background**: WordPress is an open-source content management system (CMS), meaning it stores and produces the content you see on a website dynamically. We use it to allow agencies to update their own content as much as possible. WordPress has come a long way since its beginning as a blog, and there are always new updates in development.

---

### General Overview

WordPress is nothing more than a set of PHP files that allow users to create and store content in a database for display on a site. Of course, it is well-developed and has been through many iterations, but that is its purpose. The content is stored in a MySQL database with a specific structure that WordPress knows how to manage.

As a normal web user, someone may not be aware that WordPress exists. As you navigate about a WordPress site, it creates fake URLs (meaning, URLs that don't align with any files on the server). HTML is served to the browser just as if it were a `.html` file. In the background, WordPress is making tons of database calls and running tons of PHP scripts before that HTML is generated.

The point you should take away from this is that WordPress makes a site dynamic. If you just need to post text on the internet and never change it, WordPress is overkill. We use WordPress because it allows people without any knowledge of web design to manage their sites.

You can access the admin side of things by going to `<site URL>/wp-admin` on any WordPress site.

---

### Our Usage

The main OSI website, and all of the OSI Agency sites, are part of a WordPress Multisite network.  This means that one set of WordPress files handles web requests to all of the sites. In the database, you'll find a few master tables (ex. "osi-site" and "osi-blogs") along with a set of tables for each site on the network.

In the past, we've had separate WordPress installations: each agency would have a separate directory with its own installation of WordPress. This worked fine, but it was difficult to update all of the sites as new versions of Wordpress came out. Now, we can upgrade all of them at once and manage them with a single user account.

When WordPress updates come out, test them out on the development server first. If all of the sites seem to function properly, then upgrade the live site during off-hours (as early in the day as possible, preferably on a weekend). It may be a good idea to check Google Analytics to see when there are lulls in traffic.

---

### Network Setup

As of writing, instructions for creating the Multisite network can be found [here](http://codex.wordpress.org/Create_A_Network).  The rest of this section will concern minor details that may make things easier for you.

**Sub-domain or Sub-directory**:  We use subdirectory networks, since we don't have control over subdomains.  Also, vucf.osi.ucf.edu is too much; osi.ucf.edu/vucf is easier to think of.

**Network Name**:  Example, OSI Agency Sites

**Site Names and Paths**:  While the network is a plural descriptor like the one above, individual sites are usually described by the agency name (i.e. Volunteer UCF, Campus Activities Board, etc.).  Paths to the sites are usually acronyms (i.e. /vucf, /cab, etc.).  You can strike a balance between brevity and clarity (for example, at the time of writing we have chosen to keep /homecoming instead of /hc).  It is not a good idea to try and change the path of a site after it has been set, but it is possible.

**Admin Email**:  Use osiweb@ucf.edu whenever possible, so that you know if the WordPress site is sending out emails.

---

### Site Setup

Each new site you create (including the original site) usually comes with some default settings that don't make much sense for us.  Here's a listing of all the things I usually do when a new site is created:

**Dashboard**:  Hide any widgets you don't care to see.

**Posts**:  Trash the pre-written post.

**Pages**:  Trash the sample page.  Go ahead and create a page named "Home" even if that isn't what you want to call it in the future.

**Plugins**:  Delete Akismet and Hello Dolly.

**Settings, General**:  Ensure the Site Title is correct and the Tagline is either meaningful or blank.  osiweb@ucf.edu should be the admin e-mail address.  Use America > New York as the timezone, and Sunday as the start of the week.  Don't forget to "Save Changes" on each page of the settings.

**Writing**:  Uncheck "Convert emoticons…"

**Reading**:  Front page displays "A static page" - the Home page you just created.  Ensure the search engine setting is as you would like it to be.

**Discussion**:  Uncheck everything in the first section, "Default article settings".  Check "Comment author must…", "Users must be…", "Automatically close…", and uncheck the rest in that section.  Uncheck everything in the E-mail section, check everything in "Before a comment appears", do not show avatars (below) and use the Blank default avatar.

---

### Other Requirements

WordPress in general uses some advanced features of PHP, including image manipulation, external web requests, and mail. The server must have a few packages installed for these to work:

{% highlight bash %}
sudo apt-get install php5-gd php5-curl sendmail
{% endhighlight %}

If you set up a new WordPress site, you may notice that it won't complete file uploads. It might ask you for FTP login details. This happens when WordPress *thinks* it can't manipulate files on the server because it has group rights, rather than direct ownership, of its files. A quick addition to the `wp-config.php` file in the main WordPress directory will fix this:

{% highlight php %}
define('FS_METHOD', 'direct');
{% endhighlight %}