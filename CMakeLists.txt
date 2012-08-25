# Copyright (C) 2007-2012 LuaDist.
# Created by Peter Kapec
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( luaglut C )
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )
include ( lua )

# We need OpenGL
find_package ( OpenGL REQUIRED )
include_directories ( ${OPENGL_INCLUDE_DIR} )

# Find OpenGLUT, FreeGLUT, GLUT
find_package ( OpenGLUT )
find_package ( FreeGLUT )
find_package ( GLUT )

# Create luagl module
install_lua_module ( luagl luagl.c LINK ${OPENGL_LIBRARIES} )

# Create memarray module
add_definitions ( -DMEMARRAY_USE_OPENGL )
install_lua_module ( memarray memarray.c )

# Try OpenGLUT, then FreeGLUT and finaly GLUT
if ( OPENGLUT_FOUND )
  include_directories ( ${OPENGLUT_INCLUDE_DIRS} )
  add_definitions ( -DUSE_OPENGLUT )
  set ( GLUT_LIB ${OPENGLUT_LIBRARIES} )
elseif ( FREEGLUT_FOUND )
  include_directories ( ${FREEGLUT_INCLUDE_DIR} )
  add_definitions ( -DUSE_FREEGLUT )
  set ( GLUT_LIB ${FREEGLUT_LIBRARIES} )
elseif ( GLUT_FOUND )
  include_directories ( ${GLUT_INCLUDE_DIR} )
  set ( GLUT_LIB ${GLUT_LIBRARY} )
endif ( )

install_lua_module ( luaglut luaglut.c LINK ${GLUT_LIB} ${OPENGL_LIBRARIES} )
install_data ( LICENSE README )
install_example ( glut_test1.lua glut_test2.lua lua.ppm )
