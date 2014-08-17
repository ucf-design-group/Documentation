---
title: Managing CreativeQ
description: How to perform some common tasks with CreativeQ.
---

**Purpose**: To demonstrate some common tasks you might need to take when managing CreativeQ and give you a greater understanding of how the application is setup.

**Background**: [CreativeQ](http://osi.ucf.edu/creativeq) is the work order management system for OSI Creative Services (including Design Group). It was built with Ruby on Rails by AJ Foster, and replaces a similar system (DesignQ) that was built by Bill Columbia, another old web designer at OSI. CreativeQ adds Web and Video Production orders to the mix.

**Caveats**: You aren't expected to become an expert in Rails. Hopefully, the majority of the tasks you might perform during regular maintenance will be outlined here.

---

### The Basics

While you might expect to find CreativeQ's files in `/var/www/osi/creativeq`, this is not the case. Because CreativeQ is a separate application, it resides in its own directory: `/var/www/creativeq-app`. Phusion Passenger, and the configuration found in `/etc/apache2/sites-available/osi`, allow CreativeQ to be accessed by going to `http://osi.ucf.edu/creativeq`. An example of the necessary configuration can be found in the [Ruby on Rails Basics]({{ site.url }}/creativeq/rails.html) guide.

Passenger automatically starts and stops the server alongside Apache. The surefire way to restart CreativeQ, therefore, is to restart Apache on the live server:

{% highlight bash %}
sudo service apache2 restart
{% endhighlight %}

You probably shouldn't do this, if possible; if there are any errors in the Apache configuration files, or some other error occurs, you may have just cut off all web traffic to the server. If you want to restart **just CreativeQ**, you can use this:

{% highlight bash %}
cd /var/www/creativeq-app
touch tmp/restart.txt
{% endhighlight %}

Passenger looks at the file `/var/www/creativeq-app/tmp/restart.txt` periodically. By using `touch`, you update the file's "modified at" timestamp, and Passenger knows to restart the application.

---

### Using the Interface

Most common tasks can be done through the web interface (some advanced things have to be done using the Rails console or database editor). Here's a rundown of what you, as an administrator, can do with the supplied interface:

* See all orders.
* Edit basic fieds of the order, including Name, Event Information, Needs, and Description.
* Edit the due date. *Note: you, as an administrator, can set any due date you please. Other users can only select a due date > 2 weeks from today.*
* Claim an order. You have all the abilities of a Creative.
* Destroy an order.
* Approve new user accounts.
* Change a user's information, including Name, E-mail, Role, and Password.
* Assign a user to an organization and set their role (member, advisor).
* Add and remove Organizations.

Here are some things you cannot do using the interface:

* Change an order's flavor (Graphics, Web, or Production).
* Change an order's organization, unless you are a member of the organization to which it is currently assigned.
* Change an order's status, unless you have claimed it.
* See a user's current password.

---

### Using the Rails Console

Sometimes, you have to dig in and edit things manually. To access the Rails console, log in to the live server and run these commands:

{% highlight bash %}
cd /var/www/creativeq-app
rails console
{% endhighlight %}

You can also abbreviate the second command with `rails c`. The prompt will change. You are now in the Rails console for CreativeQ:

{% highlight ruby %}
Loading development environment (Rails 4.1.0)
2.1.0 :001 > 
{% endhighlight %}

Let's grab the very first order. The result may vary depending on whether this order has been automatically removed:

{% highlight ruby %}
2.1.0 :001 > Order.first
  Order Load (40.3ms)  SELECT  "orders".* FROM "orders"   ORDER BY "orders"."id" ASC LIMIT 1
 => #<Order id: 1, name: "The Cultured Knight Life", due: "2014-06-20", description: "I would like the background of the poster to featu...", event: {"name"=>"The Cultured Knight Life", "time"=>"7/9/2014", "location"=>"Recreation and Wellness Center"}, needs: {"poster"=>"8.5\" x 11\""}, status: "Complete", owner_id: 22, organization_id: 7, creative_id: 13, created_at: "2014-06-05 18:40:12", updated_at: "2014-06-24 17:25:33", flavor: "Graphics">
{% endhighlight %}

Here, the order has the following attributes:

* ID: 1
* Name: "The Cultured Knight Life"
* Due date: June 20th, 2014
* Flavor: Graphics
* Owner: MSC Marketing (ID: 22)
* Organization: MSC (ID: 7)
* Creative: Hebah (ID: 13)

Let's look at a few different ways of selecting the same order using these attributes, an assign the order to a variable in the process:

{% highlight ruby %}
# Select an order by ID
anOrder = Order.find(1)

# Select an order by attributes
anOrder = Order.where(name: "The Cultured Knight Life").first

# Select by owner and creative
anOrder = Order.where(owner: User.find(22), creative_id: 13).first
{% endhighlight %}

Conceptual note: when you make object selections like this, you have to think about how many objects might be returned. When you select an object by ID, you are guaranteed to have only one object as a result. When you select an object based on attributes, there could be multiple objects that result - there *could* be multiple objects with the same name - so you need to select the first result of the list.

Overall, `.find()` selects an object by ID, `.where()` allows you to list attributes and narrow down the list, and `.first` selects the first object of a list. When there are reference attributes (like a reference to the order's owner) you can either supply the object (owner: User.find(22)) or the object's ID (owner_id: 22).

Now that you have an object selected, you can make some changes:

{% highlight ruby %}
# Change the flavor of the order
anOrder.flavor = "Web"

# Change the order's owner
anOrder.owner = User.where(first_name: "James", last_name: "Bond").first
{% endhighlight %}

Check the order's attributes, and save them:

{% highlight ruby %}
anOrder
anOrder.save!
{% endhighlight %}

In general, I include the `!` on the `.save` command. This makes the process fail loudly; if the record fails to save for any reason, it will give you an error rather than simply not working.

Most often, I use the Rails console to change an order's owner or creative. Because you, as an admin, can edit the due date without restriction, it's easier to change the date using the web interface.

---

### Using the Database Editor

Editing the database directly is generally a bad idea. My advice to you is to use the Rails console to edit objects and their attributes. Teaching you how to use PostgreSQL raw syntax is slightly beyond the scope of this guide.

Nevertheless, if you wish to enter the database editor, run this on the live server:

{% highlight bash %}
cd /var/www/creativeq-app
rails db
{% endhighlight %}

---

### Changing Order Options

As time goes on, the types of things people request are likely to change. Luckily, the available "needs" are easy to edit. The desired file on the live server is `/var/www/creativeq-app/app/models/order.rb`.

Look for the section that begins `class << self`. The methods defined within this block are *class methods* rather than *instance methods*, meaning you access them using `Order.graphics_needs` rather than `@order.graphics_needs` for a specific order.

The available needs are defined as simple arrays. Adding or removing options from this array will affect the entire application. CreativeQ automatically creates the database-friendly (lowercase, no-space) versions of the needs to store. Note that existing orders will not change: if you remove a need from this list, it will still be stored in order records. You just won't see it anywhere.

Be careful to avoid clashes in names. The needs must differ by more than capitalization and spacing; as an example "FB Event Photo" and "fb event   photo" both map to "fb_event_photo" in the database.

After making changes to the application, you have to restart it. On the live server, run:

{% highlight bash %}
cd /var/www/creativeq-app
touch tmp/restart.txt
{% endhighlight %}

Please also commit changes that you make, using Git.

---

