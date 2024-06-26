import config;

import std.stdio;
import std.range : enumerate;
import std.file : readText;

import ini;

void main(string[] args) {
    arg(0, args[0]);
    foreach (argc, argv; args[1 .. $].enumerate(1)) {
        arg(argc, argv);
        writeln(INI(readText(argv)));
    }
}

void arg(int argc, string argv) { //
    writefln("argv[%s] = <%s>", argc, argv);
}
