IOU
===

A Rails web application to write down the money you owe people and what they owe you. Create bills with a friend's name, a descrition and an amount. Just write it once and forget about it.

A bit like Billmonk.com, only opensource.

* Author: [Sunny Ripert](http://sunfox.org)
* Licence: [GNU GPL v3](http://www.gnu.org/licenses/gpl.html)
* Try it out: <http://iou.heroku.com>

![Screenshot](http://github.com/sunny/iou/raw/master/public/images/screenshot.png)

Installation
------------

Requires Rails 3, which runs on Ruby 1.8.7 or 1.9.2. If you have none of these [RVM](http://rvm.beginrescueend.com/) will come handy. Then:

  $ gem install rails --pre
  $ git clone git@github.com:sunny/iou.git
  $ cd iou
  $ bundle install
  $ rake db:migrate
  $ rails server

Planned to do
-------------

* Better test coverage
* History of bills
* Shared bills with more than two participants
* Recurrent bills (e.g. rent)
* Charts and pies
* Support for a different currencies
* Support for different means of payments than money (he he.)
* Internationalisation, in French at least
* A CSS that doesn't break too much on IE (notice how it's not at the top of the list)

[Feel free to help](http://github.com/sunny/iou)!
