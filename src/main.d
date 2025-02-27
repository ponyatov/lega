/// @file
/// @brief `legaScript` engine

/// @defgroup legas legaScript
/// @brief homoiconic script language for source code generation and analysis

import config;

import std.stdio;
import std.range : enumerate;
import std.file : readText;

import ini;
import vm;

/// @brief program entry point
/// @param [in] args command line arguments
/// @ingroup legas
void main(string[] args) {
    /// init process
    auto init = new proc("init");
    arg(0, args[0]);
    foreach (argc, argv; args[1 .. $].enumerate(1)) {
        arg(argc, argv);
        ini.ini(init, argv);
        init.push(new i(1));
        init.push(new i(3));
        init.push(new i(3));
        init.q();
    }
}

/// @brief print cmdline argument
/// @param [in] argc index
/// @param [in] argv value
/// @ingroup legas
void arg(int argc, string argv) {
    writefln("argv[%s] = <%s>", argc, argv);
}
