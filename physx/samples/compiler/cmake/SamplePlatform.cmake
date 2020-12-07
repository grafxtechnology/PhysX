##
## Redistribution and use in source and binary forms, with or without
## modification, are permitted provided that the following conditions
## are met:
##  * Redistributions of source code must retain the above copyright
##    notice, this list of conditions and the following disclaimer.
##  * Redistributions in binary form must reproduce the above copyright
##    notice, this list of conditions and the following disclaimer in the
##    documentation and/or other materials provided with the distribution.
##  * Neither the name of NVIDIA CORPORATION nor the names of its
##    contributors may be used to endorse or promote products derived
##    from this software without specific prior written permission.
##
## THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY
## EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
## IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
## PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
## CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
## EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
## PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
## PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
## OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
## (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
## OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
##
## Copyright (c) 2018-2019 NVIDIA Corporation. All rights reserved.

#
# Build SamplePlatform common
#

SET(SAMPLEPLATFORM_DIR ${PHYSX_ROOT_DIR}/samples/sampleframework/platform)

# Include here after the directories are defined so that the platform specific file can use the variables.
INCLUDE(${PHYSX_ROOT_DIR}/samples/${PROJECT_CMAKE_FILES_DIR}/${TARGET_BUILD_PLATFORM}/SamplePlatform.cmake)

SET(SAMPLEPLATFORM_FILES
	${SAMPLEPLATFORM_DIR}/src/SamplePlatform.cpp
	${SAMPLEPLATFORM_DIR}/src/SampleUserInput.cpp
	${SAMPLEPLATFORM_DIR}/include/SampleUserInputIds.h
	${SAMPLEPLATFORM_DIR}/include/SampleUserInput.h
	${SAMPLEPLATFORM_DIR}/include/SamplePlatform.h
)

ADD_LIBRARY(SamplePlatform STATIC
	${SAMPLEPLATFORM_PLATFORM_SOURCES}
	
	${SAMPLEPLATFORM_FILES}
)

TARGET_INCLUDE_DIRECTORIES(SamplePlatform
	PRIVATE ${SAMPLEPLATFORM_PLATFORM_INCLUDES}
	
	PRIVATE ${SAMPLEPLATFORM_DIR}/include
	
	PRIVATE ${PHYSX_ROOT_DIR}/samples/sampleframework/renderer/include
	PRIVATE ${PHYSX_ROOT_DIR}/samples/sampleframework/framework/include

	PRIVATE ${PHYSX_ROOT_DIR}/include
	PRIVATE ${PHYSX_ROOT_DIR}/source/common/src
)

TARGET_COMPILE_DEFINITIONS(SamplePlatform 
	PRIVATE ${SAMPLEPLATFORM_COMPILE_DEFS}
)


IF(NV_USE_GAMEWORKS_OUTPUT_DIRS)
	SET_TARGET_PROPERTIES(SamplePlatform PROPERTIES 
		COMPILE_PDB_NAME_DEBUG "SamplePlatform_static_${CMAKE_DEBUG_POSTFIX}"
		COMPILE_PDB_NAME_CHECKED "SamplePlatform_static_${CMAKE_CHECKED_POSTFIX}"
		COMPILE_PDB_NAME_RELWITHDEBINFO "SamplePlatform_static_${CMAKE_RELWITHDEBINFO_POSTFIX}"
		COMPILE_PDB_NAME_RELEASE "SamplePlatform_static_${CMAKE_RELEASE_POSTFIX}"

		ARCHIVE_OUTPUT_NAME_DEBUG "SamplePlatform_static"
		ARCHIVE_OUTPUT_NAME_CHECKED "SamplePlatform_static"
		ARCHIVE_OUTPUT_NAME_RELWITHDEBINFO "SamplePlatform_static"
		ARCHIVE_OUTPUT_NAME_RELEASE "SamplePlatform_static"
	)
ELSE()
	SET_TARGET_PROPERTIES(SamplePlatform PROPERTIES 
		COMPILE_PDB_NAME_DEBUG "SamplePlatform${CMAKE_DEBUG_POSTFIX}"
		COMPILE_PDB_NAME_CHECKED "SamplePlatform${CMAKE_CHECKED_POSTFIX}"
		COMPILE_PDB_NAME_RELWITHDEBINFO "SamplePlatform${CMAKE_RELWITHDEBINFO_POSTFIX}"
		COMPILE_PDB_NAME_RELEASE "SamplePlatform${CMAKE_RELEASE_POSTFIX}"
	)
ENDIF()


TARGET_LINK_LIBRARIES(SamplePlatform 
	PUBLIC SampleToolkit
	PUBLIC ${SAMPLEPLATFORM_PLATFORM_LINKED_LIBS}
)

IF(PX_GENERATE_SOURCE_DISTRO)	
	LIST(APPEND SOURCE_DISTRO_FILE_LIST ${SAMPLEPLATFORM_PLATFORM_SOURCES})
	LIST(APPEND SOURCE_DISTRO_FILE_LIST ${SAMPLEPLATFORM_FILES})
ENDIF()