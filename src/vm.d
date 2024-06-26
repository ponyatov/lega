module vm;

import std.stdio;
import std.format;

import std.array : split, join;
import std.range : repeat;
import std.uni : toLower;
import std.conv;

/// root object = generic attribute grammar AST node
class obj {

    string value;

    /// nested elements = ordered container
    obj[] nest;

    /// associative container = attributes
    obj[string] slot;

    /// async message queue
    obj[] queue;

    /// default empty constructor
    this() {
    }

    this(string V) {
        this();
        this.value = V;
    }

    /// `( -- o )` push element
    obj push(obj o) {
        nest ~= o;
        return this;
    }

    /// type/class tag (lowercased class name w/o module refs)
    string tag() {
        return this.classinfo.name.split('.')[$ - 1].toLower();
    }

    /// stringified @ref value
    string val() {
        return format("%s", value);
    }

    /// `<T:V>` header
    string head() {
        return format("<%s:%s> @%x", tag(), val(), cast(size_t) this);
    }

    string dump(size_t depth = 0) {
        string ret = "\n" ~ "\t".repeat(depth).join() ~ head();
        foreach (i; nest)
            ret = ret ~ i.dump(depth + 1);
        return ret;
    }

    void q() {
        writeln(dump());
    }
}

/// primitive
class prim : obj {
}

/// integer
class i : prim {
    int value;
    override string val() {
        return format("%s", value);
    }

    this(int n) {
        this.value = n;
    }
}

/// process
class proc : obj {
    // alias this = vm.obj.this;
    this(string name) {
        super(name);
    }
}

/// message
class msg : obj {
    obj from, to;
    size_t prio;
    obj data;
}

/// input/output
class io : obj {
}

/// file tree path
class path : io {
}

/// directory
class dir : io {
}

/// file
class file : io {
}
