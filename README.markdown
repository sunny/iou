IOU
===

A Rails web application to write down the money you owe people and what they owe you. Create bills with a friend's name, a descrition and an amount. Just write it once and forget about it.

A bit like Billmonk.com only open source, RESTful, with HTML5 & SVG.

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

* Bills with more than two participants
* Recurrent bills (e.g. rent)
* Support for several currencies
* Support for other means of payments than money (he he.)
* Sharing debts between users
* Full test coverage
* Sexy charts and pies
* Internationalisation, in French at least
* iPhone stylesheet
* A CSS that doesn't break too much on IE (notice how it's not at the top of the list)

[Feel free to help](http://github.com/sunny/iou)!
