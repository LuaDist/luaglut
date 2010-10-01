# Copyright (C) 2007-2009 LuaDist.
# Created by Peter Kapec
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

PROJECT(luaglut C)
CMAKE_MINIMUM_REQUIRED(VERSION 2.8)
INCLUDE(dist.cmake)

# We need OpenGL
FIND_PACKAGE (OpenGL REQUIRED)
INCLUDE_DIRECTORIES (${OPENGL_INCLUDE_DIR})

# Find OpenGLUT, FreeGLUT, GLUT
INCLUDE(FindOpenGLUT.cmake)
INCLUDE(FindFreeGLUT.cmake)
FIND_PACKAGE(GLUT REQUIRED)

# Create luagl module
ADD_LUA_MODULE(luagl luagl.c)
TARGET_LINK_LIBRARIES(luagl ${OPENGL_LIBRARIES})

# Create memarray module
ADD_DEFINITIONS(-DMEMARRAY_USE_OPENGL)
ADD_LUA_MODULE(memarray memarray.c)

# Try OpenGLUT, then FreeGLUT and finaly GLUT
IF(OPENGLUT_FOUND)
	INCLUDE_DIRECTORIES (${OPENGLUT_INCLUDE_DIRS})
	ADD_DEFINITIONS(-DUSE_OPENGLUT)
	SET(GLUT_LIB ${OPENGLUT_LIBRARIES})

ELSEIF(FREEGLUT_FOUND)
	INCLUDE_DIRECTORIES (${FREEGLUT_INCLUDE_DIR})
	ADD_DEFINITIONS(-DUSE_FREEGLUT)
	SET(GLUT_LIB ${FREEGLUT_LIBRARIES})

ELSEIF(GLUT_FOUND)
	INCLUDE_DIRECTORIES (${GLUT_INCLUDE_DIR})
	SET(GLUT_LIB ${GLUT_LIBRARY})
ENDIF ()

ADD_LUA_MODULE(luaglut luaglut.c)
TARGET_LINK_LIBRARIES(luaglut ${GLUT_LIB} ${OPENGL_LIBRARIES})

# Install
INSTALL(TARGETS memarray luaglut luagl DESTINATION ${INSTALL_CMOD})

# LuaGLUT Documentation
INSTALL(FILES LICENSE README DESTINATION ${INSTALL_DATA})

# LuaGLUT Tests
INSTALL(FILES glut_test1.lua glut_test2.lua lua.ppm DESTINATION ${INSTALL_TEST})
