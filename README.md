Jekyll plugins
==============

Plugins for the [Jekyll](http://jekyllrb.com/) static site generator.

file_link tag
-------------

A tag that generates a link (in markdown format) to a local file
with its basename as link text. When the file cannot be found
the tag only generates the basename without a link.

Usage:

- `{% file_link path/to/file %}` generates `[file](path/to/file)`
- `{% file_link /path/to/file %}` generates `[file](/path/to/file)`
- `{% file_link no/such/file %}` generates `file`

The path can be given relative (to the current page)
or absolute, with the Jekyll source directory as root.

Installation
------------

Copy the files in the `_plugins` directory into the `_plugins` directory
of your site.

License
-------

Copyright &copy; 2012-2013 Marcus Stollsteimer

This is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License version 3 or later (GPLv3+),
see [www.gnu.org/licenses/gpl.html](http://www.gnu.org/licenses/gpl.html).
There is NO WARRANTY, to the extent permitted by law.

