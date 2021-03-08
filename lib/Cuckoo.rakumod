
use v6;
unit module Cuckoo:ver<0.0.1>;
# vim: ft=perl6 expandtab sw=4
use NativeCall;

=begin pod

=head1 NAME

Cuckoo - utime wrapped for 64bit Linux

=head1 SYNOPSIS

=begin code :lang<raku>

use Cuckoo;

utime( Str $filename);
utime( Str $filename, Instant $atime, Instant $mtime);

=end code

=head1 DESCRIPTION

Cuckoo is a Raku wrapper for utime.  

utime with a single argument sets the file's atime and mtime to
now or dies on failure.

Three argument utime sets the atime and mtime of the file named to
the given Instants rounded to the second.

=head1 CAVEAT

Only tried on 64-bit Linux.

I have only written this because I could not find this functionality in
Raku, I release it with the hope feedback will improve it.

=head1 AUTHOR

Robert Ransbottom

=head1 SEE ALSO

joy / the clouds / ride the zephyr / warm they smile / die crying

=head1 COPYRIGHT AND LICENSE

Copyright 2020 rir

This library is free software; you can redistribute it and/or modify
it under the Artistic License 2.0.

=end pod

class Utimbuf is repr('CStruct') {
    has long  $.atime;
    has long  $.mtime;

    submethod BUILD(Numeric:D :$atime, Numeric:D :$mtime ) {
        $!atime = $atime.round;
        $!mtime = $mtime.round;
    }
}

multi sub utime(Str, Utimbuf --> int32) is native is symbol('utime') {*}

multi sub utime( Str $f) is export {
    die "utime failed" if 0 ≠ utime( $f, (Utimbuf) );
}

multi sub utime( Str $f, Instant $atime, Instant $mtime) is export {
    die "utime failed." if 0 ≠ utime( $f,
           Utimbuf.new(
                :atime( Int($atime.to-posix[0].round)),
                :mtime(Int($mtime.to-posix[0].round)) ));
}
