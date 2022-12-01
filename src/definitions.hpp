/*
definitions.hpp

Provides necessary definitions, encapsulating all the tools required furtherby
*/

/*
This header file is defined by this value. If this value is not defined, the
header is not included. 
*/
#ifndef _RTG_DEFINITIONS_HPP
#define _RTG_DEFINITIONS_HPP true 
#endif

/*
Only available on C++17 or above. For below, we must use dirent.h,
which comes with C library..
*/
#if __cplusplus >= 201703L

#ifndef _GLIBCXX_FILESYSTEM
#include <filesystem>
#endif

#endif

#ifndef _GLIBCXX_ARRAY
#include <array>
#endif


//rtg = rdr2_theme_grub
namespace rtg {

};