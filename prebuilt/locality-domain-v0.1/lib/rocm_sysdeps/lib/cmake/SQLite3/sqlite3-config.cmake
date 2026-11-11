# Traverse from lib/cmake/FOO -> the directory holding lib
get_filename_component(_IMPORT_PREFIX "${CMAKE_CURRENT_LIST_DIR}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)
if(_IMPORT_PREFIX STREQUAL "/")
  set(_IMPORT_PREFIX "")
endif()

if(NOT TARGET SQLite::SQLite3)
  if(ON)
    add_library(SQLite::SQLite3 SHARED IMPORTED)
    set_target_properties(SQLite::SQLite3 PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${_IMPORT_PREFIX}/include"
      IMPORTED_LOCATION "${_IMPORT_PREFIX}/lib/librocm_sysdeps_sqlite3.so"
    )
  else()
    add_library(SQLite::SQLite3 STATIC IMPORTED)
    set_target_properties(SQLite::SQLite3 PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${_IMPORT_PREFIX}/include"
      IMPORTED_LOCATION "${_IMPORT_PREFIX}/lib/librocm_sysdeps_sqlite3.a"
    )
  endif()
endif()

set(_IMPORT_PREFIX)
