knowhow RoleHOW {
    my sub compose_role($dst,$src) {
        my $keys = $src.^!methods.keys;
        my $i = 0;
        loop {
            if $i == $keys.elems {
                return;
            } else {
                my $key = $keys.[$i.FETCH];
                $dst.^!methods.{$key.FETCH} = $src.^!methods.{$key.FETCH};
                $i = &infix:<+>:(int,int)($i.FETCH,1);
            }
        }
    }
    method add_attribute($object, $privname, $attribute) {
        $object.^!attributes.{$privname.FETCH} = $attribute;
    }
    method add_method($object, $name, $code) {
        $object.^!methods.{$name.FETCH} = $code
    }
    method dispatch($object, $identifier, \$capture) {
        if PRIMITIVES::idconst_eq($identifier.FETCH,'FETCH') {
            # in item context, returns itself.
            return $object;
        } else {
            # Roles are not classes! so we're going to delegate this to a
            # punned class that does this role. For now, we're going to pun a
            # new class every time, then we'll think in some sort of caching.
            my $class = ::p6opaque.^!CREATE;
            $class.^!how = ::PrototypeHOW;
#            $class.^compose_role(::LowObject);
#            $class.^compose_role($object);
            compose_role($class,$object);
            my $delegated = ::Scalar.new($capture.delegate($class.FETCH));
            return $class.^dispatch($identifier.FETCH, (|$delegated));
        }
    }
}

#role LowObject {
#    method new {
#        return self.^clone;
#    }
#}

$LexicalPrelude.{'RoleHOW'} := ::RoleHOW;

