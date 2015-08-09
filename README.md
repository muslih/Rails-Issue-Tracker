Rails Issue Tracker
===================

App Info
----------

* Ruby 2.2.0
* Rails 4.2.0
* Devise for authentication
* Styled with bootstrap

Features
--------

Tickets can be created and assigned to user groups. Tickets have the properties:

* Title - The title of the issue
* Issue Type - Determines the user group the ticket gets assigned to
* Status - What the current status of the ticket is (open, closed, in progress, contact customer, etc.)
* Priority - How important this ticket is on a scale of 1 to 5 (5 being the highest). 5 are highligted and moved to the top of the dashboard
* Issues - These are the descriptions of each update of the ticket, and are required to be filled out to update the ticket.
    * Has a user foreign key to keep track of who updated the ticket
* User - A foreign key to the user that created the ticket.

Tickets can be searched from the nav if the user is an admin or technician. They can be searched by the title, creator, or status.

Users are authenticated via devise. Users have the properties:

* First name
* Last name
* Email
* Password
* Role - currently split into three roles, admin, technician, and customer.
    * Admins can look at, search for, and edit any ticket in the system. Look at and modify the role of any user in the system. And manage the user groups, as well as search and view the user directory.
    * Technicians can look at, search for, and edit any ticket in the system. View any user as well as their ticket history, and search users in the users directory,
    * Customers can view their ticket history, create new tickets, and edit their user info.

All abilities of the user roles are inherited as the move up the chain, with admin's having the most access.

Users can be searched by name, email, and role.

Screenshots
-----------

This is what the Admin or Technicians will see when they first log in.
![Admin/Technician Dashboard](http://i.imgur.com/UdsX4V9.png)

A customer will see their ticket history when they log in.
![Customer home page](http://i.imgur.com/6Wgzxc0.png).

The show page for a ticket.
![Ticket show page](http://i.imgur.com/PCsJg3W.png)

The ticket edit page.
![Ticket edit page](http://i.imgur.com/LVw2X9m.png)

All the issues are displayed under the edit form.
![Ticket edit issues](http://i.imgur.com/yQXpxfF.png)

The new ticket page.
![New ticket page](http://i.imgur.com/TGoqrnX.png)

Searching for a ticket.
![Ticket search](http://i.imgur.com/TGoqrnX.png)

Users directory.
![Users directory](http://i.imgur.com/4B7OeNA.png)

Users search results.
![Users search results](http://i.imgur.com/dqxJXvD.png)

The admin's user group manager.
![Admin group manage](http://i.imgur.com/k2QBiSA.png)

License
-------

MIT

Copyright (c) 2015 Nick Hurst

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.