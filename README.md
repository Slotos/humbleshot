What it is
-----------------

A solution to a problem that only exists in certain minds. Reddit loves screenshots and tends to push a lot of similar ones to the top in attempt to say "look, look, there's something different this time".

This simple app can hosts on heroku serving the cached version of a certain web page screenshot. When it sees that it's outdated it launches a re-generation job in background.

It was and is a deployment schema test application for me, thus there are no tests and it is generally quite crude. If you find it useful and want to extend it - grab it and call it your own.

How to use
-----------------

1. Create new heroku instance with:

        heroku create humbleshot --stack cedar --buildpack http://github.com/Slotos/heroku-buildpack-ruby.git

1. Install memcached addon for your app. Either with `heroku addons:add memcache:5mb` or through heroku web interface.

1. Clone this repository with `git clone git://github.com/Slotos/humbleshot.git`

1. Push to heroku

1. Run `heroku run rake db:migrate`

1. Scale worker app up with `heroku ps:scale worker=1`

How NOT to use it
-----------------

If you have your own server, VPS or whatever - do not use this app. Just grab phantomjs, rasterise.js example and extend it into a cropper. Then use that cropper with cron and server a static file. This solution is ridiculously complex for anything but heroku with additional challenge of not using S3.
