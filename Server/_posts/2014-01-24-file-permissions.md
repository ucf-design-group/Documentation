---
title: File Permissions
description: File permissions can be a pain. This document describes how you can fix them.
---

**Purpose**: To assist you in fixing file permission errors when they crop up. Also, to explain the reasoning for why our permissions are set up the way they are.

**Background**: Every file has a set of permissions attached to it. These tell the system who can read, write, and execute* it. Because permissions are automatically set in many situations depending on the location a file is created, moved, etc., you may sometimes find that you don't have sufficient permission to do what you need. This can be frustrating, but it can also be easily fixed.

*Files in PHP do not need the "execute" permission in order to run.

---

### Principles and Paradigms

In an IT class, you'd learn something called the "Principle of Least Privilege." This basically says that people should only be allowed to do what they need to do, and no more. Aside from being complete bull$#!& when it comes to actually getting work done in a job like yours, it is actually a good rule for file permissions. We will therefore only give files the minimum permissions required.

Permissions are divided into three categories: User (owner), Group, and Others. Typically a user can read and write to his/her own files. Members of a certain group might also be able to write to it. "Others" - meaning **literally anyone in the world**, for all intents and purposes - should probably only be able to read the file (at most).

There are three types of permissions: reading, writing, and executing. For files, the third is only important for Bash and other scripts that are executed locally (i.e. not PHP files). For directories, execution means being able to list the directory's contents.

You can see the permissions of files in the current directory by running `ls -l`. Here's an example of the output:

{% highlight bash %}
total 5
drwxrwxr-- 1 aa123456 www-data 19929 Jul 12 11:33 some-dir
-rwxrwxr-- 1 aa123456 www-data   395 Jul 12 11:33 some-file.txt
(. . .)
{% endhighlight %}

* aa123456 is the owner of the file.
* `www-data` is the group to which the file belongs.
* -(**rwx**)rwxr-- means that the file owner can read/write/execute the file.  This is good.
* -rwx(**rwx**)r-- means that members of the group *www-data* can read/write/execute the file.  This is good for files in `/var/www`, because it lets anyone in the `www-data` group edit them.
* -rwxrwx(**r--**) means that "others" can only read files.  This is for security reasons. You might consider removing this privilege for sensitive files.

---

### Initial Setup of /var/www

File permissions are mostly a concern when dealing with `/var/www`, because multiple users need to edit the files found there. To accomplish this we ensure files are controlled by the `www-data` group. Not only does this allow every member of `www-data` to manage the files, it also ensures that Apache (acting as the user `www-data`) can serve them.

The following setps were taken during the inital setup of `/var/www`. It is safe to run these commands at any time if permissions become problematic:

{% highlight bash %}
sudo chown -R www-data:www-data /var/www
sudo chmod -R 770 /var/www
find /var/www -type d -exec sudo chmod g+s {} +
sudo setfacl -R -m default:g:www-data:rwx /var/www
{% endhighlight %}

Here's an explanation of each line:

* `chown -R www-data:www-data` sets the owner and group of the files to `www-data`. When files are copied in, they will likely have a different owner; this is okay, as long as the group is correct.
* `chmod -R 770` sets the permissions to be `rwxrwx---`. The owner and group can do everything. Others can't do anything.
* `find ... chmod g+s` sets the "set GID" bit on every directory. This is supposed to make files automatically inherit the correct group when they are copied or created.
* `setfacl` sets a special Access Control List that, if nothing else, should ensure that the `www-data` group can access the files.

---

### Using chmod, chown, and chgrp

There are three commands to know. Here is a reduced version of the manual (required parts are in {}, optional parts in []).

{% highlight bash %}
chmod [-R] {permission codes} {/path}
chown [-R] {new owner}[:new group] {/path}
chgrp [-R] {new group} {/path}
{% endhighlight %}

* `chmod` changes the permissions of a given file.
* `chown` changes the user / owner of the file. It can also change the group.
* `chgrp` changes the group membership of the file.
* `-R` sets the changes to be recursive: all subfolders and subfiles will be affected.
* `{/path}` sets the file or directory to be changed.

Examples:

{% highlight bash %}
chmod -R 770 /var/www
chown -R www-data:www-data /var/www
{% endhighlight %}

---

### Cautionary Notes

Messing with file permissions can ruin a lot of things. Please don't ever mess with permissions outside of `/var/www` unless you're sure of what you're doing. Double-check your commands before you run them, because it is very easy to make mistakes. Trust me, I've done it.

If you do accidentally make permission changes where you don't mean to, don't log out. If you change the permissions or `/var`, for example, you probably won't be able ot log in again. Compare the permissions of the affected files with those on the Development server and fix them as necessary.