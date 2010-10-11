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

Here are the environment variables you might need to fill, for example in your `~/.bashrc`:

    export IOU_HOST='localhost:3000'
    export IOU_TOKEN='your_app_token_here_should_be_a_long_string_of_random_characters'
    export IOU_EMAIL='email@example.org'
    export IOU_PEPPER='your_pepper_string_should_also_be_a_long_string_of_random_characters'
    export IOU_RPX_APP_NAME='your_janrain_engage_app_name_that_you_setup_on_rpxnow_dot_com'
    export IOU_RPX_KEY='the_corresponding_rpx_key'

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
