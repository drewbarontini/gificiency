# Gificiency

Become more GIF-efficient.

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
