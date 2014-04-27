photo_copy
==========

A ruby script I use to copy photos off my phone or camera and into directories organized by year and date

  Usage: ./photo_copy.rb <source dir> <target dir>

The script will copy all files from <source dir> (not recursive) and into a directory underneath <target dir> such that the copied file's path is <target dir>/<year>/<year> <month> <day>/<filename>, where year month and day all come from the file's modification timestamp.

The script will not copy duplicate files.
