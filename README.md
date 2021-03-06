Gificiency
==========

Become more GIF-efficient.
[http://drewbarontini.com/articles/reinvigorate](http://drewbarontini.com/articles/reinvigorate)

Requirements
------------

- Server running PHP/Apache

Installation
------------

- Download the ZIP of all the files
- Open up `config.php` and edit the `$url` and `$dir` directories (see below)
- Upload the `assets`, `lib`, `config.php`, and `index.php` files to your server
- You can remove each `src` directory in `assets/stylesheets` and `assets/javascripts`

The `$url` variable is the URL to your media files, and the `$dir` variable is a
relative path (from the directory you uploaded the files to) to where you are storing
the media (GIFs, images). Once these variables are set up: 

- Add the directory that you pointed it to
- Add your GIFs
- Start becoming more gificient

If you want to become even more gificient, look at the **Alfred** and **Hazel** workflows below
that I use to prevent myself from ever having to manually upload my GIFs via FTP.

Filter
------

By default, the filter functionality will populate with all of the categories you have specified
in the filename. I use the convention `category-descriptor.gif`, so `angry-batman.gif`, for example.
If you want to change the hyphen (`-`) delimiter, change the `Gificiency` instantiation call in `index.php`:

```javascript
$(function() {
  new Gificiency({
    delimiter: '_' // Use an underscore instead  
  });
});
```

"API"
-----

When looping through the directory of GIFs, Gificiency will also go ahead and create a `/gifs.json` file for you to parse in an API. There is an `api/gificiency.rb` wrapper written in Ruby, as well as a `assets/javascripts/src/gificiency_api.coffee` CoffeeScript/JavaScript wrapper.

Making Changes
--------------

If you so choose, you can change the design/functionality by compiling the Sass/CoffeeScript
files in the `src` directory of each of the `assets/stylesheets`, `assets/javascripts` directories,
respectively. You'll need to set up Grunt to do this, so run the following:

```bash
# Make sure you install Sass
sudo gem install sass

# Install grunt cli globally
npm install -g grunt-cli

# Install dependencies
npm install
 
# Run Grunt to watch your Sass/CoffeeScript files
grunt
```

To minify the Sass/CoffeeScript files:

```bash
grunt min
```

Alfred Search
-------------

To set up the [Alfred](http://alfredapp.com) custom search, go to `Settings > Features > Web Search`
and click `Add Custom Search` at the bottom right. Then, enter the following details (adding your
site-specific information):

![Screenshot](http://cl.drewb.io/image/3a3h0S231l01/Screenshot%202014-01-16%2017-09-09.png)

Hazel Script
------------

To get the custom [Hazel](http://www.noodlesoft.com/hazel.php) script working, create a folder somewhere
that you will drop your GIFs into. Next, add a new script in that folder, and enter the following (adding 
your FTP server credentials):

![Screenshot](http://cl.drewb.io/image/2O0r1D2D2R1h/Screenshot%202014-01-16%2017-12-36.png)

Now, whenever you drop a GIF (named how you want)
