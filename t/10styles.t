#!/usr/bin/perl -w
use strict;

use Test::More  tests => 7;
use CSS::Tiny::Styles;
use CSS::Tiny::Style;

my $test_file = './t/10styles.css';

{
    my $css;
    eval { $css = CSS::Tiny::Styles->read($test_file); };
    is($@,'','.. no object creation errors');
    isa_ok($css,'CSS::Tiny');

    is(scalar($css->selectors),11);
    is(scalar($css->styles),11);
}

{
    my $css;
    eval { $css = CSS::Tiny::Style->new('p.myclass',{color => '#f0f'}); };
    is($@,'','.. no object creation errors');
    isa_ok($css,'CSS::Tiny::Style');

    my $style = 'color:#f0f';
    is("$css",$style);
}
