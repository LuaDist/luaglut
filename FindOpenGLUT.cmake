# Copyright (C) 2007-2009 LuaDist.
# Created by Peter Kapec <kapecp@gmail.com>
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
#	Note:
#		Searching headers and libraries is very simple and is NOT as powerful as scripts
#		distributed with CMake, because LuaDist defines directories to search for.
#		Everyone is encouraged to contact the author with improvements. Maybe this file
#		becomes part of CMake distribution sometimes.

# - Find OpenGLUT
# Find the native OpenGLUT headers and libraries.
#
#  OPENGLUT_INCLUDE_DIRS - where to find openglut.h, etc.
#  OPENGLUT_LIBRARIES    - List of libraries when using OpenGLUT.
#  OPENGLUT_FOUND        - True if OpenGLUT found.

# Look for the header file.
FIND_PATH(OPENGLUT_INCLUDE_DIR NAMES GL/openglut.h)

# Look for the library.
FIND_LIBRARY(OPENGLUT_LIBRARY NAMES openglut)

# Handle the QUIETLY and REQUIRED arguments and set OPENGLUT_FOUND to TRUE if all listed variables are TRUE.
INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(OPENGLUT DEFAULT_MSG OPENGLUT_LIBRARY OPENGLUT_INCLUDE_DIR)

# Copy the results to the output variables.
IF(OPENGLUT_FOUND)
	SET(OPENGLUT_LIBRARIES ${OPENGLUT_LIBRARY})
	SET(OPENGLUT_INCLUDE_DIRS ${OPENGLUT_INCLUDE_DIR})
ELSE(OPENGLUT_FOUND)
	SET(OPENGLUT_LIBRARIES)
	SET(OPENGLUT_INCLUDE_DIRS)
ENDIF(OPENGLUT_FOUND)

MARK_AS_ADVANCED(OPENGLUT_INCLUDE_DIRS OPENGLUT_LIBRARIES)
