/*
main.cpp

interacts with the user, taking inputs, and creating necessary files.
*/

#ifndef _GLIBCXX_IOSTREAM
#include <iostream>
#endif

#ifndef _GLIBCXX_STRING
#include <string>
#endif

#ifndef _GLIBCXX_ARRAY
#include <array>
#endif

#ifndef _RTG_DEFINITIONS_HPP
#include "definitions.hpp"
#endif

/*
filsystem is Only available on C++17 or above. For below, we must use dirent.h, which
comes with C std.
*/

#if __cplusplus >= 201703L

#ifndef _GLIBCXX_FILESYSTEM
#include <filesystem>
#endif

#endif


/*

*/
bool driver() {
    return true;
}

int main() {
    std::cout << "Initial.\n";
}