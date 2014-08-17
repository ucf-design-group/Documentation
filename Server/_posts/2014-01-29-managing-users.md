---
title: Managing Users
description: How to manage access to the OSI servers.
---

**Purpose**: To inform the process of managing users on the OSI servers.

**Background**: Access to the OSI servers is controlled by SDES IT. In order to make changes to access, you'll have to communicate with someone in the Infrastructure Team (i.e. DJ).

---

### Access Groups

There are two levels of access to our servers and Mac computers. "Admins" have the ability to change (and destroy) every aspect of the servers, while "Users" can perform some basic tasks without changing settings. Traditionally, students in the paid web positions are "Admins" while interns are "Users."

The actual user accounts that are put into these groups are SDES-domain accounts. New users will have to ask IT for an SDES account. The account will consist of their NID and a separate password.

---

### Making Changes

Three people are currently recognized by SDES IT as able to make changes to server access:

* David Oglethorpe (david.oglethorpe@ucf.edu)
* Haley Winston (haley.winston@ucf.edu)
* Chantel Carter (chantel.carter@ucf.edu)

One of these people can contact [Dieuner Juleseus (DJ)](dj@ucf.edu) to request any necessary changes. DJ is part of the SDES IT Infrastructure Team, and he was involved with the original setup of the servers. It may be good to check in with DJ every semester.

You'll have to supply DJ the user's name and NID. Here are some quick translations to help you ensure that you're on the same page:

* Paid position = Admin = OSI Web Admin group = "sudo" privileges
* Intern position = User = OSI Web Users group = "non-sudo" access

---

### Technical Notes

The following is more relevant to the students:

SDES account passwords have to be changed using one of the Windows computers in the office. Someone must log in, press Ctrl+Alt+Del, and ask to Change a Password.

Once your account is given access to the server, there are some things you'll have to do in order to work effectively. First, you'll have to add yourself to the `www` and `rvm` groups in order to work on web files:

{% highlight bash %}
sudo usermod -a -G www <username>
sudo usermod -a -G rvm <username>
{% endhighlight %}

This will allow you to view and edit files in `/var/www` and manage Ruby-related stuff. Similarly, on the Mac computers, run:

{% highlight bash %}
sudo dseditgroup -o edit -a <username> -t user www
sudo dseditgroup -o edit -a <username> -t user rvm
{% endhighlight %}