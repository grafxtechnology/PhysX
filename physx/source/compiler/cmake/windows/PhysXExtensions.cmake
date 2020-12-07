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
# Build PhysXExtensions
#


SET(PHYSXEXTENSIONS_PLATFORM_INCLUDES
	PRIVATE ${PHYSX_SOURCE_DIR}/Common/src/windows
)

SET(PHYSXEXTENSIONS_PLATFORM_OBJECT_FILES
	$<TARGET_OBJECTS:FastXml>
)

SET(PHYSXEXTENSIONS_PLATFORM_SRC_FILES
	${PHYSXEXTENSIONS_PLATFORM_OBJECT_FILES}
)

# Use generator expressions to set config specific preprocessor definitions
SET(PHYSXEXTENSIONS_COMPILE_DEFS

	# Common to all configurations
	${PHYSX_WINDOWS_COMPILE_DEFS};${PHYSX_LIBTYPE_DEFS};${PHYSXGPU_LIBTYPE_DEFS}

	$<$<CONFIG:debug>:${PHYSX_WINDOWS_DEBUG_COMPILE_DEFS};>
	$<$<CONFIG:checked>:${PHYSX_WINDOWS_CHECKED_COMPILE_DEFS};>
	$<$<CONFIG:relwithdebinfo>:${PHYSX_WINDOWS_RELWITHDEBINFO_COMPILE_DEFS};>
	$<$<CONFIG:release>:${PHYSX_WINDOWS_RELEASE_COMPILE_DEFS};>
)

SET(PHYSXEXTENSIONS_PRIVATE_PLATFORM_LINKED_LIBS

)

SET(PHYSXEXTENSIONS_LIBTYPE STATIC)

IF(NV_USE_GAMEWORKS_OUTPUT_DIRS AND PHYSXEXTENSIONS_LIBTYPE STREQUAL "STATIC")
	SET(PHYSXEXTENSIONS_COMPILE_PDB_NAME_DEBUG "PhysXExtensions_static${CMAKE_DEBUG_POSTFIX}")
	SET(PHYSXEXTENSIONS_COMPILE_PDB_NAME_CHECKED "PhysXExtensions_static${CMAKE_CHECKED_POSTFIX}")
	SET(PHYSXEXTENSIONS_COMPILE_PDB_NAME_RELWITHDEBINFO "PhysXExtensions_static${CMAKE_RELWITHDEBINFO_POSTFIX}")
	SET(PHYSXEXTENSIONS_COMPILE_PDB_NAME_RELEASE "PhysXExtensions_static${CMAKE_RELEASE_POSTFIX}")
ELSE()
	SET(PHYSXEXTENSIONS_COMPILE_PDB_NAME_DEBUG "PhysXExtensions${CMAKE_DEBUG_POSTFIX}")
	SET(PHYSXEXTENSIONS_COMPILE_PDB_NAME_CHECKED "PhysXExtensions${CMAKE_CHECKED_POSTFIX}")
	SET(PHYSXEXTENSIONS_COMPILE_PDB_NAME_RELWITHDEBINFO "PhysXExtensions${CMAKE_RELWITHDEBINFO_POSTFIX}")
	SET(PHYSXEXTENSIONS_COMPILE_PDB_NAME_RELEASE "PhysXExtensions${CMAKE_RELEASE_POSTFIX}")
ENDIF()

IF(PHYSXEXTENSIONS_LIBTYPE STREQUAL "SHARED")
	INSTALL(FILES $<TARGET_PDB_FILE:PhysXExtensions> 
		DESTINATION $<$<CONFIG:debug>:${PX_ROOT_LIB_DIR}/debug>$<$<CONFIG:release>:${PX_ROOT_LIB_DIR}/release>$<$<CONFIG:checked>:${PX_ROOT_LIB_DIR}/checked>$<$<CONFIG:relwithdebinfo>:${PX_ROOT_LIB_DIR}/relwithdebinfo> OPTIONAL)
ELSE()	
	INSTALL(FILES ${PHYSX_ROOT_DIR}/$<$<CONFIG:debug>:${PX_ROOT_LIB_DIR}/debug>$<$<CONFIG:release>:${PX_ROOT_LIB_DIR}/release>$<$<CONFIG:checked>:${PX_ROOT_LIB_DIR}/checked>$<$<CONFIG:relwithdebinfo>:${PX_ROOT_LIB_DIR}/relwithdebinfo>/$<$<CONFIG:debug>:${PHYSXEXTENSIONS_COMPILE_PDB_NAME_DEBUG}>$<$<CONFIG:checked>:${PHYSXEXTENSIONS_COMPILE_PDB_NAME_CHECKED}>$<$<CONFIG:relwithdebinfo>:${PHYSXEXTENSIONS_COMPILE_PDB_NAME_RELWITHDEBINFO}>$<$<CONFIG:release>:${PHYSXEXTENSIONS_COMPILE_PDB_NAME_RELEASE}>.pdb
		DESTINATION $<$<CONFIG:debug>:${PX_ROOT_LIB_DIR}/debug>$<$<CONFIG:release>:${PX_ROOT_LIB_DIR}/release>$<$<CONFIG:checked>:${PX_ROOT_LIB_DIR}/checked>$<$<CONFIG:relwithdebinfo>:${PX_ROOT_LIB_DIR}/relwithdebinfo> OPTIONAL)
ENDIF()
