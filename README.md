photo_copy
==========

A ruby script I use to copy photos off my phone or camera and into directories organized by year and date

  Usage: ./photo_copy.rb &lt;source dir&gt; &lt;target dir&gt;

The script will copy all files from &lt;source dir&gt; (not recursive) and into a directory underneath &lt;target dir&gt; such that the copied file's path is &lt;target dir&gt;/&lt;year&gt;/&lt;year&gt; &lt;month&gt; &lt;day&gt;/&lt;filename&gt;, where year month and day all come from the file's modification timestamp.

The script will not copy duplicate files.
