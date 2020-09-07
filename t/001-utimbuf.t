
use v6;
use Test;
use lib $?FILE.IO.parent(2).add('lib');
use Cuckoo;

my constant $file = $?FILE.IO.parent(2).add('resources/testfile').path;

plan 8;

my @buf = [
    { gave => {:a(0),     :m(-1),   }, sought => {:a(0),   :m(-1),  },},
    { gave => {:a(-9.9),  :m(9.9),  }, sought => {:a(-10), :m(10),  },},
    { gave => {:a(-10),   :m(10),   }, sought => {:a(-10), :m(10),  },},
    { gave => {:a(10.2),  :m(-10.2),}, sought => {:a(10),  :m(-10), },},
    { gave => {:a(-5.4),  :m(5.4),  }, sought => {:a(-5),  :m(5),   },},
    { gave => {:a(-0.1),  :m(0.1),  }, sought => {:a(0),   :m(0),   },},
    { gave => {:a(-0.9),  :m(0.9),  }, sought => {:a(-1),  :m(1),   },},
    { gave => {:a(-20.9), :m(20.9), }, sought => {:a(-21), :m(21),  },},
];

for @buf -> %b {
    my $tb = Cuckoo::Utimbuf.new(
            atime => %b<gave><a>, mtime => %b<gave><m> );
    is $tb.gist, 
       "Cuckoo::Utimbuf.new(atime => %b<sought><a>, mtime => %b<sought><m>)",
       'Utimbuf initialized';
}

#vim: ft=perl6 expandtab sw=4

