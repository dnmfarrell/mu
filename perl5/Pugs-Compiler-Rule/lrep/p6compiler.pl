# pX/Common/p6compiler.pl - fglock
#
# experimental implementation of a p6 compiler
# 

# ***************
# This version of lrep only compiles Grammar sections
# The full version is on misc/pX/Common/lrep*
# ***************

use strict;
use warnings;
no warnings 'redefine';

use FindBin '$Bin';
use lib "$Bin/../lib";
use Pugs::Grammar::LrepBase;

require 'p6rule.pl';
require 'emit.pl';
require 'interface.pm';

my @OLD_ARGV = @ARGV;

RESTART:
    @ARGV = @OLD_ARGV;
    undef $interface::got_options;
    interface->import;

# TODO: see TASKS file


{
    package grammar1;

    no warnings 'once';
    use vars qw( @statements @terms @ops );

    *immediate_statement_exec = sub {
        my $match = immediate_statement_rule( @_ );
        # print "immediate_statement_exec: BEGIN AST: \n", Dumper( $match->{capture} );
        return $match unless $match->{bool};
        # print "immediate_statement_exec: BEGIN AST: \n", Dumper( $match->{capture} );
        my $program = Perl6Grammar::emit( $match->{capture} );
        #print "immediate_statement_exec: matching ###$_[0]###\n";
        #print "immediate_statement_exec: eval'ing code:\n###$program###\n";
        no strict 'refs';
        my $code = eval($program);
        warn "Error in statement:\n", $program if $@;
        die "error in immediate_statement_exec: " . $@
            if $@;
        # print "immediate_statement_exec: CODE[ $code ]\n";
        return {
            %$match,
            capture => [ { perl5 => $program } ],
        }
    };

    # load/precompile Prelude(s)

    my $recompile;
    for my $prelude_file ( 
        'p6prelude',
        # 'p6primitives',
    ) {

      # loading the prelude is always required, even if it is out of date!
      warn "* loading Prelude: $prelude_file-cached.pl\n";
      require "$prelude_file-cached.pl";

      if ( -f "$prelude_file-cached.pl" ) {
        $recompile = 
            -M "$prelude_file-cached.pl" > 
            -M "$prelude_file.pl";
      }
      else {
        $recompile = 1;
      }
      if ( 0 ) {   # $recompile ) {
        local $/ = undef; 
        warn "* precompiling Prelude: $prelude_file.pl\n";
        open( FILE, "<", "$prelude_file.pl" ) or 
            die "can't open prelude file: $prelude_file.pl - $!";
        my $prelude = <FILE>;
        # print "Prelude:$prelude\n";
        my $perl5;
        {
            no warnings 'redefine';
            $perl5 = Perl6Grammar::compile( $prelude );
        }
        # print "MATCH\n", Dumper($match), "END MATCH\n";
        warn "* caching Prelude: $prelude_file-cached.pl\n";
        open( FILE, ">", "$prelude_file-cached.pl" ) or
            die "can't open prelude file: $prelude_file-cached.pl - $!";
        print FILE "# Generated file - do not edit!\n" . $perl5;
        close FILE;
        warn "*** restarting the compilation to use the new prelude...\n";
        goto RESTART;
      }
      else {
        ## print "* loading Prelude: $prelude_file-cached.pl\n";
        ## require "$prelude_file-cached.pl";
      }
    }


    {
        my $filename = shift || die "no filename";
        if ($filename eq '-') {
            warn "* compiling source from STDIN\n";
            *FILE = *STDIN
        } else {
            warn "* compiling: $filename\n";
            open( FILE, "<", $filename ) or 
              die "can't open file: $filename - $!";
        }
        local $/ = undef;
        my $source = <FILE>;
        my $perl5 = Perl6Grammar::compile( $source,{
		print_ast => $interface::print_ast,
		print_program => $interface::print_program,
		print_match => $interface::print_match
	}); 
    }

    exit;

}

# ------ emitter

my $namespace = 'grammar1::';

{
  package Perl6Grammar;
  use p6dump;

sub header {
    return <<EOT;
#!perl
#
# grammar file
# perl5 code generated by p6grammar.pl - fglock

use strict;
use warnings;
use lib '.';
use interface;
require 'iterator_engine.pl';
require 'p6rule_lib.pl';

EOT
}

# compile( $source, {flag=>value} );
#
# flags:
#   print_program=>1 - prints the generated program
#
sub compile {
    #print "compile: matching: \n$_[0]\n";
    my $match = grammar1::grammar->( $_[0] );
    #print "compile: matched.\n";
    my $flags = $_[1];
    die "compile: syntax error in program '$_[0]' at '" . $match->{tail} . "'\n"
        if $match->{tail};
    die "compile: syntax error in program '$_[0]'\n"
        unless $match->{bool};
    if ($flags->{print_match}) {
        print dump_tree($match,'match');
    }
    if ($flags->{print_ast}) {
        print dump_tree($match->{capture},'ast');
    }
    my $program = emit( $match->{capture} );
    
    if ($flags->{print_program}) {
        my $sum = sprintf('%08X', unpack('%32N*', $_[0]));
        print "# Generated file - do not edit!\n";
        print << "...";
##################((( 32-bit Checksum Validator )))##################
BEGIN { use 5.006; local (*F, \$/); (\$F = __FILE__) =~ s!c\$!!; open(F)
or die "Cannot open \$F: \$!"; binmode(F, ':crlf'); unpack('%32N*',<F>)
== 0x$sum or die "Checksum failed for outdated .pmc file: \${F}c"}
#####################################################################
...
        print $program;
    }
    return $program;

}

sub get_data {
    match::get( { capture => $_[0] }, $_[1] ) 
}
sub get_str {
    match::str( get_data( @_ ) )
}

# XXX not used - intended to bind variables in a macro, when it returns an AST
#     instead of string
sub bind_variable {
    my $n = $_[0];
    my ( $var_name, $value ) = @_;
    #print ref($n),"\n";
    if ( ref( $n ) eq 'ARRAY' ) {
        bind_variable( $_, @_[1,2] ) for @$n;
    }
    elsif ( ref( $n ) eq 'HASH' ) 
    {
        #print Dumper($n);
        my ( $k ) = keys %$n;
        my $v = $n->{$k};
        #print "*** $k, $v \n";
        #return unless defined $k;
        return bind_variable( $v, @_[1,2] ) if ref( $v );
        if ( $k eq 'variable' && $v eq $_[1] ) {
            #print "subst $k $v @_[1,2] ",$_[0]->{$k}, "\n";
            $_[0]->{$k} = $_[2];
        }
    }
}

} # /package

1;

