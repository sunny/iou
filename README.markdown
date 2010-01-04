IOU
===

Track bills between you and your friends.

Install from git
----------------

    $ git clone git@github.com:sunny/iou.git
    $ cd iou
    $ git submodule init
    $ git submodule update

Configure
---------

    $ cp config/database.yml.example config/database.yml
    $ rake gems:install
    $ rake db:migrate
    $ script/server


