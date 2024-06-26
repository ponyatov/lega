/// @file
/// @brief C++ generated code sample

#include "main.hpp"

int main(int argc, char *argv[]) {
    arg(0, argv[0]);
    for (int i = 1; i < argc; i++) {  //
        arg(i, argv[i]);
    }
    return 0;
}

void arg(int argc, char *argv) {  //
    printf("argv[%i] = <%s>\n", argc, argv);
}

Object *Object::pool = nullptr;
Object::Object() {
    rc = 0;
    next = pool;
    pool = this;
    fprintf(stderr, "+ %s:%x\n", tag().c_str(), this);
}
Object::Object(std::string V) : Object() { value = V; }
Object::~Object() {
    fprintf(stderr, "~ %s:%x\n", tag().c_str(), this);
    for (Object *p : nest)
        if (--(p->rc) <= 0) delete p;
}

std::string Object ::tag() { return typeid(this).name(); }
std::string Object::val() { return value; }

Active::Active(std::string V) : Object(V) {}
Process::Process(std::string V) : Active(V) {}

auto init = Process("init");
