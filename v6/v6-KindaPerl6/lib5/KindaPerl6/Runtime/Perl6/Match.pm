{

    package Match;

    # Do not edit this file - Perl 5 generated by KindaPerl6
    use v5;
    use strict;
    no strict 'vars';
    use KindaPerl6::Runtime::Perl5::Runtime;
    my $_MODIFIED;
    BEGIN { $_MODIFIED = {} }

    BEGIN {
        $_ =
          ::DISPATCH( $::Scalar, "new",
            { modified => $_MODIFIED, name => "$_" } );
    }
    do {
        if (
            ::DISPATCH(
                ::DISPATCH(
                    ::DISPATCH( $GLOBAL::Code_VAR_defined, 'APPLY', $::Match ),
                    "true"
                ),
                "p5landish"
            )
          )
        {
        }
        else {
            do {
                ::MODIFIED($::Match);
                $::Match = ::DISPATCH(
                    ::DISPATCH(
                        $::Class, 'new',
                        ::DISPATCH( $::Str, 'new', 'Match' )
                    ),
                    'PROTOTYPE',
                );
              }
        }
    };
    ::DISPATCH(
        ::DISPATCH( $::Match, 'HOW', ),
        'add_attribute',
        ::DISPATCH( $::Str, 'new', 'from' )
    );
    ::DISPATCH(
        ::DISPATCH( $::Match, 'HOW', ),
        'add_attribute',
        ::DISPATCH( $::Str, 'new', 'to' )
    );
    ::DISPATCH(
        ::DISPATCH( $::Match, 'HOW', ),
        'add_attribute',
        ::DISPATCH( $::Str, 'new', 'result' )
    );
    ::DISPATCH(
        ::DISPATCH( $::Match, 'HOW', ),
        'add_attribute',
        ::DISPATCH( $::Str, 'new', 'bool' )
    );
    ::DISPATCH(
        ::DISPATCH( $::Match, 'HOW', ),
        'add_attribute',
        ::DISPATCH( $::Str, 'new', 'match_str' )
    );
    ::DISPATCH(
        ::DISPATCH( $::Match, 'HOW', ),
        'add_attribute',
        ::DISPATCH( $::Str, 'new', 'array' )
    );
    ::DISPATCH(
        ::DISPATCH( $::Match, 'HOW', ),
        'add_attribute',
        ::DISPATCH( $::Str, 'new', 'hash' )
    );
    ::DISPATCH(
        ::DISPATCH( $::Match, 'HOW', ),
        'add_method',
        ::DISPATCH( $::Str, 'new', 'str' ),
        ::DISPATCH(
            $::Method,
            'new',
            sub {
                my $List__ =
                  ::DISPATCH( $::Array, 'new',
                    { modified => $_MODIFIED, name => '$List__' } );
                my $self;
                $self =
                  ::DISPATCH( $::Scalar, 'new',
                    { modified => $_MODIFIED, name => '$self' } )
                  unless defined $self;

                BEGIN {
                    $self =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$self' } );
                }
                $self = shift;
                $List__->{_value}{_array} = \@_;
                ::DISPATCH(
                    $GLOBAL::Code_ternary_58__60__63__63__32__33__33__62_,
                    'APPLY',
                    ::DISPATCH( $self, 'bool', ),
                    ::DISPATCH(
                        $GLOBAL::Code_substr,
                        'APPLY',
                        ::DISPATCH( $self, 'match_str', ),
                        ::DISPATCH( $self, 'from', ),
                        ::DISPATCH(
                            $GLOBAL::Code_infix_58__60__45__62_,
                            'APPLY',
                            ::DISPATCH( $self, 'to', ),
                            ::DISPATCH( $self, 'from', )
                        )
                    ),
                    $::Undef
                );
            }
        )
    );
    1
}

