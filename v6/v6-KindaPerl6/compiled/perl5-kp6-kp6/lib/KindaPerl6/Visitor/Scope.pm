{ package KindaPerl6::Visitor::Scope; 
# Do not edit this file - Perl 5 generated by HASH(0x1b09380)
# AUTHORS, COPYRIGHT: Please look at the source file.
use v5;
use strict;
no strict "vars";
use constant KP6_DISABLE_INSECURE_CODE => 0;
use KindaPerl6::Runtime::Perl5::Runtime;
my $_MODIFIED; INIT { $_MODIFIED = {} }
INIT { $_ = ::DISPATCH($::Scalar, "new", { modified => $_MODIFIED, name => "$_" } ); }
do {do { if (::DISPATCH(::DISPATCH(::DISPATCH(  ( $GLOBAL::Code_VAR_defined = $GLOBAL::Code_VAR_defined || ::DISPATCH( $::Routine, "new", )  ) 
, 'APPLY', $::KindaPerl6::Visitor::Scope )
,"true"),"p5landish") ) { do {} }  else { do {do {::MODIFIED($::KindaPerl6::Visitor::Scope);
$::KindaPerl6::Visitor::Scope = ::DISPATCH( ::DISPATCH( $::Class, 'new', ::DISPATCH( $::Str, 'new', 'KindaPerl6::Visitor::Scope' )
 )
, 'PROTOTYPE',  )
}} } }
; ::DISPATCH( ::DISPATCH( $::KindaPerl6::Visitor::Scope, 'HOW',  )
, 'add_method', ::DISPATCH( $::Str, 'new', 'visit' )
, ::DISPATCH( $::Code, 'new', { code => sub { 
# emit_declarations
my  $List__ = ::DISPATCH( $::ArrayContainer, 'new', { modified => $_MODIFIED, name => '$List__' } ) ; 
;
my $node; $node = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$node' } )  unless defined $node; INIT { $node = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$node' } ) }
;
my $node_name; $node_name = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$node_name' } )  unless defined $node_name; INIT { $node_name = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$node_name' } ) }
;

# get $self
$self = shift; 
# emit_arguments
my $CAPTURE; $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } )  unless defined $CAPTURE; INIT { $CAPTURE = ::DISPATCH( $::Scalar, 'new', { modified => $_MODIFIED, name => '$CAPTURE' } ) }
my  $List__ = ::DISPATCH( $::ArrayContainer, 'new', { modified => $_MODIFIED, name => '$List__' } ) ; 
::DISPATCH_VAR($CAPTURE,"STORE",::CAPTURIZE(\@_));::DISPATCH_VAR( $List__, 'STORE', ::DISPATCH( $CAPTURE, 'array',  )
 )
;do {::MODIFIED($Hash__);
$Hash__ = ::DISPATCH( $CAPTURE, 'hash',  )
};{ my $_param_index = 0;  if ( ::DISPATCH( $GLOBAL::Code_exists,  'APPLY',  ::DISPATCH(  $Hash__, 'LOOKUP',  ::DISPATCH( $::Str, 'new', 'node' )  ) )->{_value}  )  { do {::MODIFIED($node);
$node = ::DISPATCH( $Hash__, 'LOOKUP', ::DISPATCH( $::Str, 'new', 'node' )
 )
} }  elsif ( ::DISPATCH( $GLOBAL::Code_exists,  'APPLY',  ::DISPATCH(  $List__, 'INDEX',  ::DISPATCH( $::Int, 'new', $_param_index )  ) )->{_value}  )  { $node = ::DISPATCH(  $List__, 'INDEX',  ::DISPATCH( $::Int, 'new', $_param_index++ )  );  }  if ( ::DISPATCH( $GLOBAL::Code_exists,  'APPLY',  ::DISPATCH(  $Hash__, 'LOOKUP',  ::DISPATCH( $::Str, 'new', 'node_name' )  ) )->{_value}  )  { do {::MODIFIED($node_name);
$node_name = ::DISPATCH( $Hash__, 'LOOKUP', ::DISPATCH( $::Str, 'new', 'node_name' )
 )
} }  elsif ( ::DISPATCH( $GLOBAL::Code_exists,  'APPLY',  ::DISPATCH(  $List__, 'INDEX',  ::DISPATCH( $::Int, 'new', $_param_index )  ) )->{_value}  )  { $node_name = ::DISPATCH(  $List__, 'INDEX',  ::DISPATCH( $::Int, 'new', $_param_index++ )  );  } } 
# emit_body
do { if (::DISPATCH(::DISPATCH(::DISPATCH(  ( $GLOBAL::Code_infix_58__60_eq_62_ = $GLOBAL::Code_infix_58__60_eq_62_ || ::DISPATCH( $::Routine, "new", )  ) 
, 'APPLY', $node_name, ::DISPATCH( $::Str, 'new', 'Lit::Code' )
 )
,"true"),"p5landish") ) { do {return(::DISPATCH( $::Lit::Code, 'new', ::DISPATCH( $::NamedArgument, 'new', { _argument_name_ => ::DISPATCH( $::Str, 'new', 'pad' )
, value => ::DISPATCH( $node, 'pad',  )
 } )
, ::DISPATCH( $::NamedArgument, 'new', { _argument_name_ => ::DISPATCH( $::Str, 'new', 'state' )
, value => ::DISPATCH( $node, 'state',  )
 } )
, ::DISPATCH( $::NamedArgument, 'new', { _argument_name_ => ::DISPATCH( $::Str, 'new', 'sig' )
, value => ::DISPATCH( $node, 'sig',  )
 } )
, ::DISPATCH( $::NamedArgument, 'new', { _argument_name_ => ::DISPATCH( $::Str, 'new', 'body' )
, value => ::DISPATCH( $::Array, 'new', { _array => [::DISPATCH( $::Assign, 'new', ::DISPATCH( $::NamedArgument, 'new', { _argument_name_ => ::DISPATCH( $::Str, 'new', 'parameters' )
, value => ::DISPATCH( $::Var, 'new', ::DISPATCH( $::NamedArgument, 'new', { _argument_name_ => ::DISPATCH( $::Str, 'new', 'namespace' )
, value => ::DISPATCH( $::Array, 'new', { _array => [] }
 )
 } )
, ::DISPATCH( $::NamedArgument, 'new', { _argument_name_ => ::DISPATCH( $::Str, 'new', 'name' )
, value => ::DISPATCH( $::Str, 'new', 'MY' )
 } )
, ::DISPATCH( $::NamedArgument, 'new', { _argument_name_ => ::DISPATCH( $::Str, 'new', 'twigil' )
, value => ::DISPATCH( $::Str, 'new', '' )
 } )
, ::DISPATCH( $::NamedArgument, 'new', { _argument_name_ => ::DISPATCH( $::Str, 'new', 'sigil' )
, value => ::DISPATCH( $::Str, 'new', '$' )
 } )
 )
 } )
, ::DISPATCH( $::NamedArgument, 'new', { _argument_name_ => ::DISPATCH( $::Str, 'new', 'arguments' )
, value => ::DISPATCH( $::Call, 'new', ::DISPATCH( $::NamedArgument, 'new', { _argument_name_ => ::DISPATCH( $::Str, 'new', 'hyper' )
, value => $::Undef } )
, ::DISPATCH( $::NamedArgument, 'new', { _argument_name_ => ::DISPATCH( $::Str, 'new', 'arguments' )
, value => $::Undef } )
, ::DISPATCH( $::NamedArgument, 'new', { _argument_name_ => ::DISPATCH( $::Str, 'new', 'method' )
, value => ::DISPATCH( $::Str, 'new', 'inner' )
 } )
, ::DISPATCH( $::NamedArgument, 'new', { _argument_name_ => ::DISPATCH( $::Str, 'new', 'invocant' )
, value => ::DISPATCH( $::Var, 'new', ::DISPATCH( $::NamedArgument, 'new', { _argument_name_ => ::DISPATCH( $::Str, 'new', 'namespace' )
, value => ::DISPATCH( $::Array, 'new', { _array => [] }
 )
 } )
, ::DISPATCH( $::NamedArgument, 'new', { _argument_name_ => ::DISPATCH( $::Str, 'new', 'name' )
, value => ::DISPATCH( $::Str, 'new', 'MY' )
 } )
, ::DISPATCH( $::NamedArgument, 'new', { _argument_name_ => ::DISPATCH( $::Str, 'new', 'twigil' )
, value => ::DISPATCH( $::Str, 'new', '' )
 } )
, ::DISPATCH( $::NamedArgument, 'new', { _argument_name_ => ::DISPATCH( $::Str, 'new', 'sigil' )
, value => ::DISPATCH( $::Str, 'new', '$' )
 } )
 )
 } )
 )
 } )
 )
, ::DISPATCH(  ( $GLOBAL::Code_prefix_58__60__64__62_ = $GLOBAL::Code_prefix_58__60__64__62_ || ::DISPATCH( $::Routine, "new", )  ) 
, 'APPLY', ::DISPATCH( $node, 'body',  )
 )
, ::DISPATCH( $::Assign, 'new', ::DISPATCH( $::NamedArgument, 'new', { _argument_name_ => ::DISPATCH( $::Str, 'new', 'parameters' )
, value => ::DISPATCH( $::Var, 'new', ::DISPATCH( $::NamedArgument, 'new', { _argument_name_ => ::DISPATCH( $::Str, 'new', 'namespace' )
, value => ::DISPATCH( $::Array, 'new', { _array => [] }
 )
 } )
, ::DISPATCH( $::NamedArgument, 'new', { _argument_name_ => ::DISPATCH( $::Str, 'new', 'name' )
, value => ::DISPATCH( $::Str, 'new', 'MY' )
 } )
, ::DISPATCH( $::NamedArgument, 'new', { _argument_name_ => ::DISPATCH( $::Str, 'new', 'twigil' )
, value => ::DISPATCH( $::Str, 'new', '' )
 } )
, ::DISPATCH( $::NamedArgument, 'new', { _argument_name_ => ::DISPATCH( $::Str, 'new', 'sigil' )
, value => ::DISPATCH( $::Str, 'new', '$' )
 } )
 )
 } )
, ::DISPATCH( $::NamedArgument, 'new', { _argument_name_ => ::DISPATCH( $::Str, 'new', 'arguments' )
, value => ::DISPATCH( $::Call, 'new', ::DISPATCH( $::NamedArgument, 'new', { _argument_name_ => ::DISPATCH( $::Str, 'new', 'hyper' )
, value => $::Undef } )
, ::DISPATCH( $::NamedArgument, 'new', { _argument_name_ => ::DISPATCH( $::Str, 'new', 'arguments' )
, value => $::Undef } )
, ::DISPATCH( $::NamedArgument, 'new', { _argument_name_ => ::DISPATCH( $::Str, 'new', 'method' )
, value => ::DISPATCH( $::Str, 'new', 'outer' )
 } )
, ::DISPATCH( $::NamedArgument, 'new', { _argument_name_ => ::DISPATCH( $::Str, 'new', 'invocant' )
, value => ::DISPATCH( $::Var, 'new', ::DISPATCH( $::NamedArgument, 'new', { _argument_name_ => ::DISPATCH( $::Str, 'new', 'namespace' )
, value => ::DISPATCH( $::Array, 'new', { _array => [] }
 )
 } )
, ::DISPATCH( $::NamedArgument, 'new', { _argument_name_ => ::DISPATCH( $::Str, 'new', 'name' )
, value => ::DISPATCH( $::Str, 'new', 'MY' )
 } )
, ::DISPATCH( $::NamedArgument, 'new', { _argument_name_ => ::DISPATCH( $::Str, 'new', 'twigil' )
, value => ::DISPATCH( $::Str, 'new', '' )
 } )
, ::DISPATCH( $::NamedArgument, 'new', { _argument_name_ => ::DISPATCH( $::Str, 'new', 'sigil' )
, value => ::DISPATCH( $::Str, 'new', '$' )
 } )
 )
 } )
 )
 } )
 )
] }
 )
 } )
 )
)
} }  else { ::DISPATCH($::Bit, "new", 0) } }
; return($::Undef)
 }, signature => ::DISPATCH( $::Signature, "new", { invocant => $::Undef, array    => ::DISPATCH( $::List, "new", { _array => [ ::DISPATCH( $::Signature::Item, 'new', { sigil  => '$', twigil => '', name   => 'node', value  => $::Undef, has_default    => ::DISPATCH( $::Bit, 'new', 0 )
, is_named_only  => ::DISPATCH( $::Bit, 'new', 0 )
, is_optional    => ::DISPATCH( $::Bit, 'new', 0 )
, is_slurpy      => ::DISPATCH( $::Bit, 'new', 0 )
, is_multidimensional  => ::DISPATCH( $::Bit, 'new', 0 )
, is_rw          => ::DISPATCH( $::Bit, 'new', 0 )
, is_copy        => ::DISPATCH( $::Bit, 'new', 0 )
,  } )
, ::DISPATCH( $::Signature::Item, 'new', { sigil  => '$', twigil => '', name   => 'node_name', value  => $::Undef, has_default    => ::DISPATCH( $::Bit, 'new', 0 )
, is_named_only  => ::DISPATCH( $::Bit, 'new', 0 )
, is_optional    => ::DISPATCH( $::Bit, 'new', 0 )
, is_slurpy      => ::DISPATCH( $::Bit, 'new', 0 )
, is_multidimensional  => ::DISPATCH( $::Bit, 'new', 0 )
, is_rw          => ::DISPATCH( $::Bit, 'new', 0 )
, is_copy        => ::DISPATCH( $::Bit, 'new', 0 )
,  } )
,  ] } ), return   => $::Undef, } )
,  } )
 )
}
; 1 }
