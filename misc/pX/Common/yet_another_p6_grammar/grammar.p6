# WARNING: This file was mechanically generated by generate_grammar.pl

# -- Arguments -------------------------------------------------------------

rule argument_list { <expr> }

term apply_sub_notFolded compete(rx{<sub_name_bare>}) { <sub_name_bare><?!before \(><missing_magic> }

# 
#  missing_magic
#         Completely kludge arity, which has become critical. :/
# 
#         optional_argument_list = ques(:argument_list)
#         optional_expr_above_comma = ques(:expr_above_comma)
#         acx = optional_argument_list
#         ac1 = seq(:expr_above_comma)
#         acq = optional_expr_above_comma
#         ac0 = seq()
# 
#         ac = {:ref=>1,:pi=>0,:shift=>1,:pop=>1,:try=>1}[n]
#         case ac
#         when nil; rest.push(*acx)
#         when :s;  rest.push(*acx)
#         when 1;   rest.push(*ac1)
#         when :q;  rest.push(*acq)
#         when 0;   rest.push(*ac0)
#         else fail("assert") end
#         args
#       }]]


term sub_name_term { <sub_name_bare><?before \(> }

rule method_args { [\:<argument_list>|\(optional_argument_list<?ws>\)]? }

rule implicit_invocant { <?before \.> }
term apply_method_term { <implicit_invocant>\.<qualified_identifier><method_args> }

# -- Declarations ------------------------------------------------

rule scope { <symbol state>|<symbol my>|<symbol our>|<symbol let>|<symbol temp>|<symbol env> }
rule type { [\w|\:\:]<[\w:&|?]>* }
# related to sr('type_var') and/or sr('type_literal')?
rule trait { <symbol is>|<symbol does>[\:\:]?<qualified_identifier>[\(<-[\)]>*\)]? }
rule block { <?ws>\{<statement_list><?ws>\} }
term code_block compete(rx{\{}) { <block>[<whiteSpaceLine>]? }
# 
rule sub_declaration { [<scope>[<identifier>]?]?<sub_head>[<symbol handles><expr>]?[<bare_trait <symbol returns>>]?[<sub_parameters__ParensMandatory>]?[<bare_trait <symbol returns>>]?[<trait>]*<block> }
rule sub_head { [<symbol multi>]?<symbol sub>|<symbol coro>|<symbol submethod>|<symbol method>|<symbol macro>|<symbol multi><sub_name_no_amp> }
rule sub_parameters__ParensMandatory { <symbol (>[<comma_list <formal_param>>]?<symbol )> }
rule sub_parameters__ParensOptional { [<comma_list <formal_param>>]? }
rule param_name { \&<sub_name_no_amp>|<[\$\@\%]>|\:\:<twigil_opt>\w+ }
rule formal_param { [<type><ws>]?[\\]?[<param_foretaste>]?<param_name>[<param_optness>]?[<trait>]*[<param_default>]?[<symbol -->><param_list__ParensOptional><formal_param>|<type>]? }
rule param_default { <symbol =><expr_above_comma> }
rule param_foretaste { \:|\* }
rule param_optness { \?|\! }
# 
rule trusts_declaration { <symbol trusts><qualified_identifier> }
rule trait_declaration { <trait><ws>$|<?before <[;}]>> }
rule member_declaration { <symbol has>[<qualified_identifier>]?<var_name>[<trait>]*[<symbol handles><expr>]?[<symbol =><expr>]? }
# 
rule rule_declaration { <symbol rule><identifier><adverb_hash><balanced \{> }
# 
rule var_declaration { <scope>[<qualified_identifier>]?<var_name>|\(<comma_list <var_name>|<undef_literal>>\)[<trait>]*[<symbol =>|<symbol .=>|<symbol :=>|<symbol ::=><?ws><var_declaration>|<expr>]? }
# 
rule package_block_declaration { <package_head><block> }
rule package_declaration { <package_head> }
rule package_head { [<scope>]?<symbol package>|<symbol module>|<symbol class>|<symbol role>|<symbol grammar><qualified_identifier>[<version_part>[<author_part>]?]?<ws>[<trait>]* }
# 
rule no_declaration { <symbol no><no_version>|<use_package> }
rule use_declaration { <symbol use><use_version>|<use_package> }
rule perl_version { [v|Perl\-]<[\d\.]>+[<author_part>]? }
rule use_version { <perl_version> }
rule no_version { <perl_version> }
rule use_package { jsan\:<?!before \:><use_JSAN_module>|jsperl5\:<?!before \:><use_JSPerl5_module>|[<identifier>\:<?!before \:>]?<use_perl_package> }
rule use_perl_package { <package_full_name>[\(<ws>\)|<expr>]? }
rule use_JSAN_module { <package_full_name>|<reassembled_delimited_identifier .>\(<ws>\)|[<expr>]? }
rule use_JSPerl5_module { <package_full_name>|<reassembled_delimited_identifier ::>\(<ws>\)|[<expr>]? }
rule package_full_name { <reassembled_delimited_identifier ::>[<version_part>]?[<author_part>]? }
rule version_part { \-<[\d\.\(\)]>+ }
rule author_part { \-<[\w\(\)]>+ }
# 
rule inline_declaration { <symbol inline><expr> }
rule require_declaration { <symbol require><package_full_name> }

# -- Expressions / Terms ------------------------------------------------

term fakestring compete(rx{\'}) { [\'[<-['\\]>|\\.]*\'] }
# '
term fakierstring compete(rx{\"}) { [\"[<-[\"\\]>|\\.]*\"] }
term fakeEND compete(rx{\<\<\'_END\'}) { [\<\<\'_END\'\ *\n(.+?)\n_END\ *\n] }
# 
rule dereference { <[\$\@\%\&]><dereference>|<sigiled_var>|<verbatimBraces <expr>> }
# 
rule angle_bracket_literal { [\<\<[<-[>\\]>|\\.|\><?!before \>>]*\>\>|\<<?!before \<>[<-[>\\]>|\\.]*\>|\xab[<-[\xbb\\]>|\\.]*\xbb] }
term angle_bracket_literal compete(rx{\<\<?|\xab}) { [\<\<[<-[>\\]>|\\.|\><?!before \>>]*\>\>|\<<?!before \<>[<-[>\\]>|\\.]*\>|\xab[<-[\xbb\\]>|\\.]*\xbb] }
rule hash_subscript_qw { <angle_bracket_literal> }
rule hash_subscript_braces { \{[<expr>]?\} }
rule hash_subscript { <hash_subscript_braces>|<hash_subscript_qw> }
rule fixity { [prefix\:|postfix\:|infix\:|circumfix\:|coerce\:|self\:|term\:|postcircumfix\:|rule_modifier\:|trait_verb\:|trait_auxiliary\:|scope_declarator\:|statement_control\:|infix_postfix_meta_operator\:|postfix_prefix_meta_operator\:|prefix_postfix_meta_operator\:|infix_circumfix_meta_operator\:] }
rule operator_name { <fixity><identifier>|<hash_subscript> }
rule sub_name_bare { <?!before <[A..Z]>><?!before [sub|coro|macro]\b><?!before [do]\b><operator_name>|<qualified_identifier> }
rule sub_name_no_amp { <twigil_opt><operator_name>|<qualified_identifier> }
rule sub_name_full { \&<sub_name_no_amp> }
rule identifier { <[a..zA..Z_]>\w* }
rule qualified_identifier { [:i <[a..z_]>\w*[\:\:<[a..z_]>\w*]*] }
rule twigil_opt { <[\^*?\.!+;]>? }
term var_symbolic_deref compete(rx{<[\$\@\%\&]>}) { <[\$\@\%\&]>[\:\:\!|\/|<twigil_opt>\w+]+ }
rule var_sub { \&<sub_name_no_amp> }
term var_sub { \&<sub_name_no_amp> }
# (nil) else prefix:& wins :/
rule var_simple { <[\$\@\%]><twigil_opt><qualified_identifier> }
term var_simple { <[\$\@\%]><twigil_opt><qualified_identifier> }
term var_error compete(rx{\$\!}) { \$\! }
term var_match_numbered compete(rx{\$\d+}) { \$\d+ }
term var_match_named compete(rx{\$\<}) { \$\<<-[>]>*\> }
term var_match compete(rx{\$\/}) { \$\/ }
rule var_name { <var_sub>|<var_simple> }
# 
# 
term do_block compete(rx{do\b}) { <symbol do><block>|<statement> }
# 
rule block_formal_pointy { \-\><?ws><sub_parameters__ParensOptional>[<trait>]*<block> }
term block_formal_pointy compete(rx{\-\>}) { \-\><?ws><sub_parameters__ParensOptional>[<trait>]*<block> }
rule block_formal_standard { <symbol <sub|coro|macro>>[<sub_parameters__ParensMandatory>]?[<trait>]*<block> }
term block_formal_standard compete(rx{[sub|coro|macro]\b}) { <symbol <sub|coro|macro>>[<sub_parameters__ParensMandatory>]?[<trait>]*<block> }
# 
# 
#   fraction = /\.[\d_]+/
#   expo = /[eE][-+]?\d+/
#   number_re = /0(?:b[0-1]+|o[0-7]+|d[0-9]+|x[0-9a-fA-F]+)
#               |[0-9][0-9_]*#{fraction}?#{expo}?
#               |[-+]?(?:Inf|NaN)\b /x  
term number compete(rx{number_re}) { number_re }
# 
term empty_list_literal { <verbatimParens <?ws>> }
# 
#   was r5('('), but that lost to postcircumfix_paren_empty(len 2),
#     which needs to be 2 to compete with postcircumfix:( )sr('0')(len 1).

# 
rule array_literal { <verbatimBrackets [<expr>]?> }
term array_literal compete(rx{\[}) { <verbatimBrackets [<expr>]?> }
# 
rule pair_adverb { \:<shortcut_pair>|<regular_pair> }
term pair_adverb { \:<shortcut_pair>|<regular_pair> }
rule shortcut_pair { <var_name> }
rule regular_pair_name { \w+ }
rule regular_pair { <regular_pair_name>[<valueDot>|<noValue>|<valueExp>]? }
rule valueDot { <ws><symbol .>[<valueExp>]? }
rule noValue { <ws> }
rule valueExp { <verbatimParens <expr>>|<array_literal>|<angle_bracket_literal> }
# 
rule undef_literal { undef\b }
# 
term yada_literal compete(rx{\.\.\.|\?\?\?|\!\!\!}) { <symbol ...>|<symbol ???>|<symbol !!!> }
# 
# 
rule adverb_hash { [<pair_adverb>]* }
rule rx_pattern { <?ws>[\/[<-[\/\\]>|\\.]*\/]|[\{[<-[\}\\]>|\\.]*\}] }
#   the \b_dot_ is to win against apply sub.
term rx_literal compete(rx{[[rx|m|rule]\b.]}) { <symbol rx|m|rule><adverb_hash><rx_pattern> }
term rx_literal_bare compete(rx{\/}) { <?before \/><rx_pattern> }
term subst_literal compete(rx{s\b}) { <symbol s><adverb_hash><rx_pattern><q_literal1> }
# 
# 
rule closure_trait { <symbol BEGIN|CHECK|INIT|FIRST|END><block> }
term closure_trait compete(rx{[BEGIN|CHECK|INIT|FIRST|END]\b}) { <symbol BEGIN|CHECK|INIT|FIRST|END><block> }
#   also stmt?!?
# 
term code_quotation compete(rx{q\:code}) { q\:code[<symbol (:COMPILING)>]?<block> }
# 
term type_var compete(rx{\:\:}) { [\:\:\(<expr>\)|<twigil_opt>\w+]+ }
# 
term type_literal { <?!before Inf\b|NaN\b><?!before [BEGIN|CHECK|INIT|FIRST|END]\b><[A..Z]>\w*[\:\:\w+]* }

# -- Constructs ------------------------------------------------

rule for_construct { <symbol for><maybeParens <expr>>[<symbol ,>]?<expr> }
rule loop_construct { <symbol loop><semi_loop_construct>|<post_loop_construct> }
rule semi_loop_construct { <maybeParens [<expr>]? <symbol ;> [<expr>]? <symbol ;> [<expr>]?><block> }
rule post_loop_construct { <block><symbol while|unitl><expr> }
# 
rule cond_construct { <symbol if|unless><cond_body> }
rule elsif_construct { <symbol elsif><cond_body> }
rule else_construct { <symbol else><block> }
rule cond_body { <cond_part><block>[<elsif_construct>|<else_construct>]? }
rule cond_part { <maybeParens <type_var>|<type_literal>|<expr>> }
# 
rule while_until_construct { <symbol while|until><cond_part><block> }
rule given_construct { <symbol given><cond_part><block> }
rule when_construct { <symbol when><cond_part><block> }
rule default_construct { <symbol default><block> }

# -- expr_statement ----------------------------------------

rule expr_statement { <expr>[<post_conditional>|<post_loop>|<post_iterate>]? }
rule post_conditional { <symbol if|unless><expr> }
rule post_loop { <symbol while|until><expr> }
rule post_iterate { <symbol for><expr> }

# -- Statements ----------------------------------------

rule prog { <statement_list><?ws> }
rule statement_list { [<?ws><statement>[<symbol ;>]*]* }

#   <statement> is a composite:

#   block_declaration
statement { <sub_declaration> }
statement { <closure_trait> }
statement { <rule_declaration> }
statement { <package_block_declaration> }
#   declaration
statement { <package_declaration> }
statement { <var_declaration> }
statement { <member_declaration> }
statement { <trait_declaration> }
statement { <use_declaration> }
statement { <no_declaration> }
statement { <inline_declaration> }
statement { <require_declaration> }
statement { <trusts_declaration> }
#   construct
statement { <for_construct> }
statement { <loop_construct> }
statement { <cond_construct> }
statement { <while_until_construct> }
statement { <given_construct> }
statement { <when_construct> }
statement { <default_construct> }
#   expr
statement { <expr_statement> }
