---
title: File Management Conventions
description: Information about how some of the file management conventions we have employed on the servers.
---

**Purpose**: To make you familiar and comfortable with how the file system on the servers are set up.

**Background**: If you haven't already been thrown into a situation where you need to fix a file in an unfamiliar project where the file system is unfamiliar, you are not about to start today. Just like coding, there is definitely more than one way to tackle file management on a server. Having gone through some of these experiences myself, I have devided to write up some general conventions we have employed here at OSI that will likely be helpful in navigating the site and keeping a mental track of where everything is.

---

### Live Server File Structure


One of the things that you'll notice when connecting to the live server is that there are several directories immediately availiable. As of 23, May 2015, these directories include the following:


* /creativeq-app
* /old.osi.ucf.edu
* /osi.ucf.edu
* /sdesosiweb1.sdes.ucf.edu
* /sgadesign-app
* /tedxucf.org

*Note: this file structure is likely to change over time and this is is only a representation of what is currently active (May 2015). While some of these directories may change, the most important ones (creativeq & osi.ucf.edu) should stay uniform.*


####/creativeq-app


Access: [http://osi.ucf.edu/creativeq](http://osi.ucf.edu/creativeq "CreativeQ")

This is a rails application used to handle orders requested through OSI. This is a standalone application that for the most part shouldn't need any administration. Of course if there is something wrong with it or you wish to make an modification to the application, editing these files is within your grasp, but for the most part this directory should not be touched. This is a completely seperate instance of a web site from anything else you should find in the other directories and should be treated as such. In other words, it is independent of the other sites found on the server and changes made here (or elsewhere for that matter) will not have an effect on seperate sites or vice versa.

####/old.osi.ucf.edu

Access: No access, you must move the sites from this folder to /osi.ucf.edu

Here is where you'll find deprecaited information and event/registration sites for events. These are sites that are no longer availiable to the public (because they're outdated or the event has passed at this point). But because we as programmers never throw anything away, we have made a special folder jsut for you to look over what we did in the past so that you may recerence, hack, and strip our code and make it your own. Anything found here is free for you to use, as well as any other documents found on these server. Think of it as our parting gift, to you.

####/osi.ucf.edu

Access: [http://osi.ucf.edu/](http://osi.ucf.edu/ "OSI Live Site")

This is the main directory for the live site (i.e. this is where http://osi.ucf.edu/ points to). In other words, it's the 'root' of the web server. Here you will find the wordpress installation and other custom sites (and other occasional files). Here is where you will be publishing your websites, templates, and other scripts. While it is a bit of a mess looking at this folder and determining what is what, it is the best way that this can be done without employing unnecessary folder structures (making URLs unnecessarily long).

What's installed here:

* WordPress
* Live sites that don't require WordPress
* Files that require hosting and other misc. items

*A quick breakdown of how this all works*

> ####WordPress

> Wordpress is it's own CMS that handles requests differently than say one of the other live sites that isn't associated with the wordpress installation. When adding a site on wordpress, it has to be done through the web interface (which stores the information in the attached database). This is why there are more than a handful of files randomly scattered around in here with the prefix "wp-". These all contribute to the functionality of the WordPress CMS. For the most part, you shouldn't have to touch any of these files (but may be required to every now and again for more advanced control management). In general, you will only need to access /wp-content/themes/, which is where all the themes for wordpress are installed. For more information regarding how to create a wordpress theme (something you should take a look at if you aren't familiar with it already), take a look [here](http://codex.wordpress.org/Theme_Development "WordPress Theme Development").

> In general, for all things WordPress related, [http://codex.wordpress.org/](http://codex.wordpress.org/ "Codex") is a great place to reference functions and other WordPress conventions (they're very picky too).

> ####Other independent live sites

> These are sites that are independent of the WordPress CMS, like the title suggests. This means that they are not themes, nor can they employ typical functionality found in the WordPress reference. Here is where you'll find the good 'ol nitty gritty real PHP programming that we decided would be the best/quickest way to deploy any given site that can be found here. These sites are usually small registration sites or even a page or two of information regarding an upcoming event. When going over what's needed for a site, you'll have to make the descision whether or not the site should be a WordPress site or not based on the needs of the consumer and the amount of time required to employ certain functionality. For the most part, you'll be making updateable easy-to-use multi-accessable sites for on-campus orginizations (which would probably be a good time to use WordPress), but if you feel that you need functionality not allowed (or allowed with major modifications) in WordPress, you might consider making it a stand-alone site. Like previously stated, these sites are usually smaller registration sites and the like.

> Something important to note here: these sites usually become depreciated after a while. The links will be removed from posts created to advertise the site or will just become dust in the wind. It is probably a good idea at some point after the event when there aren't as many stragglers visiting the site to move it over to **/old.osi.ucf.edu**, marking it as deprecaited. This way if someone were to stumble onto the site somehow they wouldn't be confused about what is likely an old event and show up a year or two late.

####/sdesosiweb1.sdes.ucf.edu

Access: [http://sdesosiweb1.sdes.ucf.edu/](http://sdesosiweb1.sdes.ucf.edu/ "Live Server Interface")

This is the server's 'real' root directory. Here is where you'll find a welcoming poem and the phpMyAdmin (MySQL web interface) web installation. There really shouldn't be any reason you'll need to edit any files in this directory ~ users aren't accessing this address anyway. If you need to access the phpMyAdmin interface, that can be done through [http://sdesosiweb1.sdes.ucf.edu/phpmyadmin/](http://sdesosiweb1.sdes.ucf.edu/phpmyadmin/ "Live Database Interface")

*Note: this is the interface for the **live** database, not the **development** database. For access to the development database interface, go to [http://sdesosiwebdev1.sdes.ucf.edu/phpmyadmin/](http://sdesosiwebdev1.sdes.ucf.edu/phpmyadmin/ "Development Database Interface")*

####/tedx.ucf.org

Access: [http://tedx.ucf.org](http://tedx.ucf.org "TedX")

(NEEDS MORE INFORMATION)

---

###Developerment Server File Structure




