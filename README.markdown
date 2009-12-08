IOU
===

Track bills between you and your friends.

Install from git
----------------

    $ git clone git clone git@github.com:sunny/iou.git
    $ cd iou
    $ git submodule init
    $ git submodule update
    $ rake gems:install

Configure
---------

    $ cp config/database.yml.example config/database.yml
    $ rake db:migrate
    $ script/server


