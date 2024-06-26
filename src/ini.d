/// @file
/// @brief .ini & legaScript grammar & processing

module ini;

import vm : proc;

import std.stdio;
import std.file : readText;

import pegged.grammar;

mixin(grammar(`
    INI:
        syntax  <  (comment/id/any)*
        comment <~ '#'(!'\n'.)*
        id      <~ identifier
        any     <  .
`));

/// process script in @ref proc context
void ini(proc vm, string filename) {
    writeln(INI(readText(filename)));
}
