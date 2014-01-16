# Gificiency

Become more GIF-efficient.
[http://drewbarontini.com/articles/reinvigorate](http://drewbarontini.com/articles/reinvigorate)

## Requirements

- Server running PHP/Apache

## Installation

- Download the ZIP of all the files
- Open up `config.php` and edit the `$url` and `$dir` directories (see below)
- Upload the `assets`, `lib`, `config.php`, and `index.php` files to your server
- You can remove each `src` directory in the `assets/stylesheets` and `assets/javascripts`

The `$url` variable is the URL to your media files, and the `$dir` variable is a
relative path (from the directory you uploaded the files to) to where you are storing
the media (GIFs, images).

## Making Changes

If you so choose, you can change the design/functionality by compiling the Sass/CoffeeScript
files in the `src` directory of each of the `assets/stylesheets`, `assets/javascripts` directories,
respectively. You can use something like [CodeKit](http://incident57.com/codekit/) to compile your
files. If you do this, there's a `codekit-config.json` file in the root of the directory that will
use the same settings. Once you're done, upload the compiled CSS/JS files to their correct locations.
