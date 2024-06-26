/// @file
/// @brief C++ generated code sample

#pragma once

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

/// @defgroup genc generated C++
/// @brief sample code
/// @{

/// @brief program entry point
/// @param argc number of cmdline arguments
/// @param argv cmdline arguments array
/// @return error code = 0  on success
/// @ingroup genc
extern int main(int argc, char *argv[]);

/// @brief print cmdline argument
/// @param argc index
/// @param argv value
extern void arg(int argc, char *argv);

/// defgroup obj Object graph
/// @{

/// @brief root object
class Object {
    size_t ref = 0;
};

class Primitive : public Object {};
class Int : public Primitive {};
class Num : public Primitive {};
class Str : public Primitive {};
class Ptr : public Primitive {};

class Container : public Object {};
class Var : public Container {};
class Vector : public Container {};
class List : public Container {};
class Stack : public Container {};
class Map : public Container {};
class Queue : public Container {};

class Active : public Object {};
class Module : public Active {};
class Process : public Active {};
class Function : public Active {};

class IO : public Object {};
class Path : public IO {};
class Dir : public IO {};
class File : public IO {};
/// @}

/// @}
