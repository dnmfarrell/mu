use v6;
use Test;

plan 11;

# As a function :
is( flip('Pugs'), 'sguP', "as a function");

# As a method :
is( "".flip, "", "empty string" );
is( 'Hello World !'.flip, '! dlroW olleH', "literal" );

# On a variable ?
my Str $a = 'Hello World !';
is( $a.flip, '! dlroW olleH', "with a Str variable" );
is( $a, 'Hello World !', "flip should not be in-place" );
is( $a .= flip, '! dlroW olleH', "after a .=reverse" );

# Multiple iterations (don't work in 6.2.12) :
is( 'Hello World !'.flip.flip, 'Hello World !',
        "two flip in a row." );

# flip with unicode :
is( 'ä€»«'.flip,   '«»€ä', "some unicode characters" );

is 234.flip, '432', '.flip on non-string';
is flip(123), '321', 'flip() on non-strings';
{
    my $x = 'abc';
    $x.=flip;
    is $x, 'cba', 'in-place flip';
}


# vim: ft=perl6