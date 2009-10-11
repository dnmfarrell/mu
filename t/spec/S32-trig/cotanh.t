# WARNING:
# This is a generated file and should not be edited directly.
# look into generate-tests.pl instead
use v6;
use Test;
plan *;

# This class, designed to help simplify the tests, is very much in a transitional
# state.  But it works as well as the previous version at the moment.  I'm checking
# it in just to clean up my local build (and save a remote copy as I take my
# the machine it lives on vacation).  Should have more updates to this over the 
# next several days.  --colomon, Sept 3rd 2009.

class AngleAndResult
{
    has $.angle_in_degrees;
    has $.result;
    
    multi method new(Int $angle_in_degrees is copy, Num $result is copy) {
        self.bless(*, :$angle_in_degrees, :$result);
    }
    
    method complex($imaginary_part_in_radians, $base) {
        my $z_in_radians = $.angle_in_degrees.Num / 180.0 * pi + ($imaginary_part_in_radians)i; 
        given $base {
            when "degrees"     { $z_in_radians * 180.0 / pi; }
            when "radians"     { $z_in_radians; }
            when "gradians"    { $z_in_radians * 200.0 / pi; }
            when "revolutions" { $z_in_radians / (2.0 * pi); }
        }
    }
    
    method num($base) {
        given $base {
            when "degrees"     { $.angle_in_degrees.Num }
            when "radians"     { $.angle_in_degrees.Num / 180.0 * pi }
            when "gradians"    { $.angle_in_degrees.Num / 180.0 * 200.0 }
            when "revolutions" { $.angle_in_degrees.Num / 360.0 }
        }
    }
    
    method rat($base) {
        given $base {
            when "degrees"     { $.angle_in_degrees / 1 }
            when "radians"     { $.angle_in_degrees / 180 * (314159265 / 100000000) }
            when "gradians"    { $.angle_in_degrees * (200 / 180) }
            when "revolutions" { $.angle_in_degrees / 360 }
        }
    }
    
    method int($base) {
        given $base {
            when "degrees"     { $.angle_in_degrees }
        }
    }
}

my @sines = ( 
    AngleAndResult.new(-360, 0),
    AngleAndResult.new(135 - 360, 1/2*sqrt(2)),
    AngleAndResult.new(330 - 360, -0.5),
    AngleAndResult.new(0, 0),
    AngleAndResult.new(30, 0.5),
    AngleAndResult.new(45, 1/2*sqrt(2)),
    AngleAndResult.new(90, 1),
    AngleAndResult.new(135, 1/2*sqrt(2)),
    AngleAndResult.new(180, 0),
    AngleAndResult.new(225, -1/2*sqrt(2)),
    AngleAndResult.new(270, -1),
    AngleAndResult.new(315, -1/2*sqrt(2)),
    AngleAndResult.new(360, 0),
    AngleAndResult.new(30 + 360, 0.5),
    AngleAndResult.new(225 + 360, -1/2*sqrt(2)),
    AngleAndResult.new(720, 0)
);

my @cosines = @sines.map({ AngleAndResult.new($_.angle_in_degrees - 90, $_.result) });

my @sinhes = @sines.grep({ $_.angle_in_degrees < 500 }).map({ AngleAndResult.new($_.angle_in_degrees, 
                                             (exp($_.num('radians')) - exp(-$_.num('radians'))) / 2.0)});

my @coshes = @sines.grep({ $_.angle_in_degrees < 500 }).map({ AngleAndResult.new($_.angle_in_degrees, 
                                             (exp($_.num('radians')) + exp(-$_.num('radians'))) / 2.0)});


my %official_base = (
    "radians" => "radians",
    "gradians" => "gradians", 
    "degrees" => "degrees",
    "revolutions" => 1
);

# cotanh tests

for @sines -> $angle
{
    	next if abs(sinh($angle.num('radians'))) < 1e-6; 	my $desired_result = cosh($angle.num('radians')) / sinh($angle.num('radians'));

    # cotanh(Num)
    is_approx(cotanh($angle.num("radians")), $desired_result, 
              "cotanh(Num) - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        is_approx(cotanh($angle.num($base), %official_base{$base}), $desired_result, 
                  "cotanh(Num) - {$angle.num($base)} $base");
    }
    
    # cotanh(:x(Num))
    #?rakudo skip 'named args'
    is_approx(cotanh(:x($angle.num("radians"))), $desired_result, 
              "cotanh(:x(Num)) - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        #?rakudo skip 'named args'
        is_approx(cotanh(:x($angle.num($base)), :base(%official_base{$base})), $desired_result, 
                  "cotanh(:x(Num)) - {$angle.num($base)} $base");
    }

    # Num.cotanh tests
    is_approx($angle.num("radians").cotanh, $desired_result, 
              "Num.cotanh - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        is_approx($angle.num($base).cotanh(%official_base{$base}), $desired_result, 
                  "Num.cotanh - {$angle.num($base)} $base");
    }

    # cotanh(Rat)
    is_approx(cotanh($angle.rat("radians")), $desired_result, 
              "cotanh(Rat) - {$angle.rat('radians')} default");
    for %official_base.keys -> $base {
        is_approx(cotanh($angle.rat($base), %official_base{$base}), $desired_result, 
                  "cotanh(Rat) - {$angle.rat($base)} $base");
    }

    # cotanh(:x(Rat))
    #?rakudo skip 'named args'
    is_approx(cotanh(:x($angle.rat("radians"))), $desired_result, 
              "cotanh(:x(Rat)) - {$angle.rat('radians')} default");
    for %official_base.keys -> $base {
        #?rakudo skip 'named args'
        is_approx(cotanh(:x($angle.rat($base)), :base(%official_base{$base})), $desired_result, 
                  "cotanh(:x(Rat)) - {$angle.rat($base)} $base");
    }

    # Rat.cotanh tests
    is_approx($angle.rat("radians").cotanh, $desired_result, 
              "Rat.cotanh - {$angle.rat('radians')} default");
    for %official_base.keys -> $base {
        is_approx($angle.rat($base).cotanh(%official_base{$base}), $desired_result, 
                  "Rat.cotanh - {$angle.rat($base)} $base");
    }

    # cotanh(Int)
    is_approx(cotanh($angle.int("degrees"), %official_base{"degrees"}), $desired_result, 
              "cotanh(Int) - {$angle.int('degrees')} degrees");
    is_approx($angle.int('degrees').cotanh(%official_base{'degrees'}), $desired_result, 
              "Int.cotanh - {$angle.int('degrees')} degrees");

    # Complex tests
    my Complex $zp0 = $angle.complex(0.0, "radians");
    my Complex $sz0 = $desired_result + 0i;
    my Complex $zp1 = $angle.complex(1.0, "radians");
    my Complex $sz1 = { cosh($_) / sinh ($_) }($zp1);
    my Complex $zp2 = $angle.complex(2.0, "radians");
    my Complex $sz2 = { cosh($_) / sinh ($_) }($zp2);
    
    # cotanh(Complex) tests
    is_approx(cotanh($zp0), $sz0, "cotanh(Complex) - $zp0 default");
    is_approx(cotanh($zp1), $sz1, "cotanh(Complex) - $zp1 default");
    is_approx(cotanh($zp2), $sz2, "cotanh(Complex) - $zp2 default");
    
    for %official_base.keys -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        is_approx(cotanh($z, %official_base{$base}), $sz0, "cotanh(Complex) - $z $base");
    
        $z = $angle.complex(1.0, $base);
        is_approx(cotanh($z, %official_base{$base}), $sz1, "cotanh(Complex) - $z $base");
                        
        $z = $angle.complex(2.0, $base);
        is_approx(cotanh($z, %official_base{$base}), $sz2, "cotanh(Complex) - $z $base");
    }
    
    # Complex.cotanh tests
    is_approx($zp0.cotanh, $sz0, "Complex.cotanh - $zp0 default");
    is_approx($zp1.cotanh, $sz1, "Complex.cotanh - $zp1 default");
    is_approx($zp2.cotanh, $sz2, "Complex.cotanh - $zp2 default");
    
    for %official_base.keys -> $base {
        my Complex $z = $angle.complex(0.0, $base);
        #?rakudo skip "Complex.cotanh plus base doesn't work yet"
        is_approx($z.cotanh(%official_base{$base}), $sz0, "Complex.cotanh - $z $base");
    
        $z = $angle.complex(1.0, $base);
        #?rakudo skip "Complex.cotanh plus base doesn't work yet"
        is_approx($z.cotanh(%official_base{$base}), $sz1, "Complex.cotanh - $z $base");
    
        $z = $angle.complex(2.0, $base);
        #?rakudo skip "Complex.cotanh plus base doesn't work yet"
        is_approx($z.cotanh(%official_base{$base}), $sz2, "Complex.cotanh - $z $base");
    }
}

is(cotanh(Inf), 1, "cotanh(Inf) - default");
is(cotanh(-Inf), -1, "cotanh(-Inf) - default");
for %official_base.keys -> $base
{
    is(cotanh(Inf,  %official_base{$base}), 1, "cotanh(Inf) - $base");
    is(cotanh(-Inf, %official_base{$base}), -1, "cotanh(-Inf) - $base");
}
        

# acotanh tests

for @sines -> $angle
{
    	next if abs(sinh($angle.num('radians'))) < 1e-6; 	my $desired_result = cosh($angle.num('radians')) / sinh($angle.num('radians'));

    # acotanh(Num) tests
    is_approx(cotanh(acotanh($desired_result)), $desired_result, 
              "acotanh(Num) - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        is_approx(cotanh(acotanh($desired_result, %official_base{$base}), %official_base{$base}), $desired_result, 
                  "acotanh(Num) - {$angle.num($base)} $base");
    }
    
    # acotanh(:x(Num))
    #?rakudo skip 'named args'
    is_approx(cotanh(acotanh(:x($desired_result))), $desired_result, 
              "acotanh(:x(Num)) - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        #?rakudo skip 'named args'
        is_approx(cotanh(acotanh(:x($desired_result), 
                                                           :base(%official_base{$base})), 
                                  %official_base{$base}), $desired_result, 
                  "acotanh(:x(Num)) - {$angle.num($base)} $base");
    }
    
    # Num.acotanh tests
    is_approx($desired_result.Num.acotanh.cotanh, $desired_result, 
              "acotanh(Num) - {$angle.num('radians')} default");
    for %official_base.keys -> $base {
        is_approx($desired_result.Num.acotanh(%official_base{$base}).cotanh(%official_base{$base}), $desired_result,
                  "acotanh(Num) - {$angle.num($base)} $base");
    }
    
    # acotanh(Complex) tests
    for ($desired_result + 0i, $desired_result + .5i, $desired_result + 2i) -> $z {
        is_approx(cotanh(acotanh($z)), $z, 
                  "acotanh(Complex) - {$angle.num('radians')} default");
        for %official_base.keys -> $base {
            is_approx(cotanh(acotanh($z, %official_base{$base}), %official_base{$base}), $z, 
                      "acotanh(Complex) - {$angle.num($base)} $base");
        }
        is_approx($z.acotanh.cotanh, $z, 
                  "Complex.acotanh - {$angle.num('radians')} default");
        for %official_base.keys -> $base {
            is_approx($z.acotanh(%official_base{$base}).cotanh(%official_base{$base}), $z, 
                      "Complex.acotanh - {$angle.num($base)} $base");
        }
    }
}

for (-4/2, -3/2, 3/2, 4/2) -> $desired_result
{
    # acotanh(Rat) tests
    is_approx(cotanh(acotanh($desired_result)), $desired_result, 
              "acotanh(Rat) - $desired_result default");
    for %official_base.keys -> $base {
        is_approx(cotanh(acotanh($desired_result, %official_base{$base}), %official_base{$base}), $desired_result, 
                  "acotanh(Rat) - $desired_result $base");
    }
    
    # Rat.acotanh tests
    is_approx($desired_result.acotanh.cotanh, $desired_result, 
              "acotanh(Rat) - $desired_result default");
    for %official_base.keys -> $base {
        is_approx($desired_result.acotanh(%official_base{$base}).cotanh(%official_base{$base}), $desired_result,
                  "acotanh(Rat) - $desired_result $base");
    }
    
    next unless $desired_result.denominator == 1;
    
    # acotanh(Int) tests
    is_approx(cotanh(acotanh($desired_result.numerator)), $desired_result, 
              "acotanh(Int) - $desired_result default");
    for %official_base.keys -> $base {
        is_approx(cotanh(acotanh($desired_result.numerator, %official_base{$base}), %official_base{$base}), $desired_result, 
                  "acotanh(Int) - $desired_result $base");
    }
    
    # Int.acotanh tests
    is_approx($desired_result.numerator.acotanh.cotanh, $desired_result, 
              "acotanh(Int) - $desired_result default");
    for %official_base.keys -> $base {
        is_approx($desired_result.numerator.acotanh(%official_base{$base}).cotanh(%official_base{$base}), $desired_result,
                  "acotanh(Int) - $desired_result $base");
    }
}
        
done_testing;

# vim: ft=perl6 nomodifiable