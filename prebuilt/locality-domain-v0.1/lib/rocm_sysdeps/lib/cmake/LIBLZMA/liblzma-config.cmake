# Traverse from lib/cmake/FOO -> the directory holding lib
get_filename_component(_IMPORT_PREFIX "${CMAKE_CURRENT_LIST_DIR}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)
if(_IMPORT_PREFIX STREQUAL "/")
  set(_IMPORT_PREFIX "")
endif()

if(NOT TARGET LibLZMA::LibLZMA)
  add_library(LibLZMA::LibLZMA "SHARED" IMPORTED)
  set_target_properties(LibLZMA::LibLZMA PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES "${_IMPORT_PREFIX}/include"
    IMPORTED_LOCATION "${_IMPORT_PREFIX}/lib/liblzma.so"
  )
  set(LIBLZMA_LIBRARY LibLZMA::LibLZMA)
  set(LIBLZMA_INCLUDE_DIRS "${_IMPORT_PREFIX}/include")
endif()

set(LIBLZMA_FOUND TRUE)

set(_IMPORT_PREFIX)
