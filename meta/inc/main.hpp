/// @file
/// @brief C++ generated code sample

#pragma once

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#include <string>
#include <vector>
#include <map>

#include <typeinfo>

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
    size_t rc = 0;        ///< reference counter
    static Object *pool;  ///< global object pool
    Object *next;         ///< @ref pool linked list

    std::string value;                     ///< scalar number/value
    std::vector<Object *> nest;            ///< nested elements
    std::map<std::string, Object *> slot;  ///< attributes

   public:
    Object();
    Object(std::string V);
    virtual ~Object();

    virtual std::string tag();  ///< class/type tag
    virtual std::string val();  ///< stringified @ref value
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

class Active : public Object {
   public:
    Active(std::string V);
};
class Module : public Active {};
class Process : public Active {
   public:
    Process(std::string V);
};
class Function : public Active {};

class IO : public Object {};
class Path : public IO {};
class Dir : public IO {};
class File : public IO {};
/// @}

/// @}
