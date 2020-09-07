NAME
====

Cuckoo - utime wrapped for 64bit Linux

SYNOPSIS
========

```raku
use Cuckoo;
utime( Str $filename );
utime( Str $filename, Instant $atime, Instant $mtime);
```

DESCRIPTION
===========

Cuckoo is a Raku wrapper for utime.

utime with a single argument sets the file's atime and mtime to
now or dies on failure.  This does not round to the second.

Three argument utime sets the atime and mtime of the file named to
the given Instants rounded to the second.

CAVEAT
======

Only tried on 64-bit Linux.

I have only written this because I could not find this functionality in
Raku, I release it with the hope feedback will improve it.

AUTHOR
======

Robert Ransbottom

SEE ALSO
========

joy / the clouds / ride the zephyr / warm they smile / die crying

COPYRIGHT AND LICENSE
=====================

Copyright 2020 Robert Ransbottom

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

