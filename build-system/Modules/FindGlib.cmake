﻿#
# Find the 'glib' includes and library
#
# This module defines
# GLIB_INCLUDE_DIR, where to find headers,
# GLIB_LIBRARIES, the libraries to link against to use glib.
# GLIB_FOUND, If false, do not try to use glib.
 
arccon_return_if_package_found(Glib)

find_package(PkgConfig)
pkg_check_modules(PKG_GLIB glib-2.0 gthread-2.0 gmodule-2.0)

message(STATUS "Infos from pkg_check_modules")
message(STATUS "PKG_GLIB_INCLUDE_DIRS       = ${PKG_GLIB_INCLUDE_DIRS}")
message(STATUS "PKG_GLIB_LIBRARIES          = ${PKG_GLIB_LIBRARIES}")
message(STATUS "PKG_GLIB_LIBRARY_DIRS       = ${PKG_GLIB_LIBRARY_DIRS}")

find_library(GLIB_GLIB_LIBRARIES NAMES glib-2.0 HINTS ${PKG_GLIB_LIBDIR} ${PKG_GLIB_LIBRARY_DIRS})
find_library(GLIB_GTHREAD_LIBRARIES NAMES gthread-2.0 HINTS ${PKG_GLIB_LIBDIR} ${PKG_GLIB_LIBRARY_DIRS})
find_library(GLIB_GMODULE_LIBRARIES NAMES gmodule-2.0 HINTS ${PKG_GLIB_LIBDIR} ${PKG_GLIB_LIBRARY_DIRS})

# On a besoin de 'glib.h' et 'glibconfig.h' qui peuvent être dans des répertoires différents

#get_filename_component(_GLIB_LIBRARY_DIR ${GLIB_GLIB_LIBRARIES} PATH)
find_path(GLIBCONFIG_INCLUDE_DIR
    NAMES glibconfig.h
    HINTS ${PKG_GLIB_LIBDIR} ${PKG_GLIB_LIBRARY_DIRS} ${PKG_GLIB_INCLUDE_DIRS}
    PATH_SUFFIXES glib-2.0/include
)
find_path(GLIB_INCLUDE_DIR
    NAMES glib.h
    HINTS ${PKG_GLIB_INCLUDEDIR}
          ${PKG_GLIB_INCLUDE_DIRS}
    PATH_SUFFIXES glib-2.0
)
set(Glib_INCLUDE_DIRS ${GLIB_INCLUDE_DIR} ${GLIBCONFIG_INCLUDE_DIR})

#if(PKG_GLIB_INCLUDE_DIRS)
#  set(Glib_INCLUDE_DIRS ${PKG_GLIB_INCLUDE_DIRS})
#else()
#  find_path(Glib_INCLUDE_DIRS NAMES glib.h PATH_SUFFIXES include HINTS ${PKG_GLIB_INCLUDE_DIRS})
#endif()
#set(GLIB_FOUND ${PKG_GLIB_FOUND})
set(Glib_LIBRARIES ${GLIB_GLIB_LIBRARIES} ${GLIB_GTHREAD_LIBRARIES} ${GLIB_GMODULE_LIBRARIES})

message(STATUS "Glib_LIBRARIES          = ${Glib_LIBRARIES}")
message(STATUS "Glib_INCLUDE_DIRS       = ${Glib_INCLUDE_DIRS}")

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Glib REQUIRED_VARS Glib_INCLUDE_DIRS Glib_LIBRARIES)
if (Glib_FOUND)
  # Create target interface
  arccon_register_package_library(Glib Glib)
endif()

# ----------------------------------------------------------------------------
# Local Variables:
# tab-width: 2
# indent-tabs-mode: nil
# coding: utf-8-with-signature
# End:
