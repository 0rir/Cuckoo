use v6;
use lib 'lib';
use Test;
plan 1;

constant AUTHOR = ?%*ENV<TEST_TEST_SKIP>;

if AUTHOR {
    require Test::META <&meta-ok>;
    meta-ok;
    done-testing;
}
else {
     skip-rest "Skipping author's tests";
     exit;
}

# vim: ft=perl6 expandtab sw=4
