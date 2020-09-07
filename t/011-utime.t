use v6;
use Test;
use lib $?FILE.IO.parent(2).add('lib');
use Cuckoo;

plan 10;

my constant VARIANCE = 0.5;  # XXX Loose magic.

my $file = $?FILE.IO.parent(2).add('resources/testfile').path;

my $init_mod = $file.IO.modified.Instant;
my $init_acc = $file.IO.accessed.Instant;

my $zed = $init_mod - $init_mod.Rat;


my @test-utime = [
    {   a => $zed + 9 + 0.9,
        m => $zed - 10,
        expected => {   a => $zed + 10,
                        m => $zed - 10,},
    },
    {   a => $zed + 9999,
        m => $zed - 5555,
        expected => {   a => $zed + 9999,
                        m => $zed - 5555,},
    },
    {   a => $zed + 5555 + 0.5,
        m => $zed -  5555 - 0.5,
        expected => {   a => $zed + 5556 ,
                        m => $zed -  5555 , },
    },
    {   a => $init_acc,
        m => $init_mod,
        expected => {   a => $init_acc,
                        m => $init_mod, },
    },
];

utime( $file);
my $now = now.Instant;

is-approx $file.IO.accessed.Instant, $now, VARIANCE,    # XXX ~no rounding
        "utime atime change to now $now";
is-approx $file.IO.modified.Instant, $now, VARIANCE,
        "utime mtime change to now $now";

for @test-utime -> %t {
    utime( $file, %t<a>, %t<m>);
    is-approx $file.IO.accessed.Instant, %t<expected><a>, VARIANCE,
        "utime atime change to %t<expected><a>";
    is-approx $file.IO.modified.Instant, %t<expected><m>, VARIANCE,
        "utime mtime change to %t<expected><m>";
}

# vim: ft=perl6 expandtab sw=4
