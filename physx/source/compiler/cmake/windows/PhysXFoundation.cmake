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
# Build PhysXFoundation
#

IF(PX_GENERATE_STATIC_LIBRARIES)
	SET(PHYSXFOUNDATION_LIBTYPE STATIC)
ELSE()
	SET(PHYSXFOUNDATION_LIBTYPE SHARED)
	SET(PXFOUNDATION_LIBTYPE_DEFS	PX_PHYSX_FOUNDATION_EXPORTS)
ENDIF()

SET(PXSHARED_PLATFORM_HEADERS
	${PXSHARED_PATH}/include/foundation/windows/PxWindowsIntrinsics.h
)
SOURCE_GROUP(shared\\include\\windows FILES ${PXSHARED_PLATFORM_HEADERS})
SET(PXSHARED_UNIXPLATFORM_HEADERS
	${PXSHARED_PATH}/include/foundation/unix/PxUnixIntrinsics.h
)
SOURCE_GROUP(shared\\include\\unix FILES ${PXSHARED_UNIXPLATFORM_HEADERS})

SET(PHYSXFOUNDATION_RESOURCE_FILE
	${PHYSX_SOURCE_DIR}/compiler/resource_${RESOURCE_LIBPATH_SUFFIX}/PhysXFoundation.rc
)
SOURCE_GROUP(resource FILES ${PHYSXFOUNDATION_RESOURCE_FILE})

SET(PHYSXFOUNDATION_PLATFORM_SOURCE
	${LL_SOURCE_DIR}/src/windows/PsWindowsAtomic.cpp
	${LL_SOURCE_DIR}/src/windows/PsWindowsCpu.cpp
	${LL_SOURCE_DIR}/src/windows/PsWindowsFPU.cpp
	${LL_SOURCE_DIR}/src/windows/PsWindowsMutex.cpp
	${LL_SOURCE_DIR}/src/windows/PsWindowsPrintString.cpp
	${LL_SOURCE_DIR}/src/windows/PsWindowsSList.cpp
	${LL_SOURCE_DIR}/src/windows/PsWindowsSocket.cpp
	${LL_SOURCE_DIR}/src/windows/PsWindowsSync.cpp
	${LL_SOURCE_DIR}/src/windows/PsWindowsThread.cpp
	${LL_SOURCE_DIR}/src/windows/PsWindowsTime.cpp
)
SOURCE_GROUP("src\\src\\windows" FILES ${PHYSXFOUNDATION_PLATFORM_SOURCE})

SET(PHYSXFOUNDATION_PLATFORM_SOURCE_HEADERS
	${LL_SOURCE_DIR}/include/windows/PsWindowsAoS.h
	${LL_SOURCE_DIR}/include/windows/PsWindowsFPU.h
	${LL_SOURCE_DIR}/include/windows/PsWindowsInclude.h
	${LL_SOURCE_DIR}/include/windows/PsWindowsInlineAoS.h
	${LL_SOURCE_DIR}/include/windows/PsWindowsIntrinsics.h
	${LL_SOURCE_DIR}/include/windows/PsWindowsTrigConstants.h
)
SOURCE_GROUP("src\\include\\windows" FILES ${PHYSXFOUNDATION_PLATFORM_SOURCE_HEADERS})

INSTALL(FILES ${PHYSXFOUNDATION_PLATFORM_SOURCE_HEADERS} DESTINATION source/foundation/include/windows)
INSTALL(FILES ${PXSHARED_PLATFORM_HEADERS} DESTINATION ${PXSHARED_INSTALL_PREFIX}/include/foundation/windows)
INSTALL(FILES ${PXSHARED_UNIXPLATFORM_HEADERS} DESTINATION ${PXSHARED_INSTALL_PREFIX}/include/foundation/unix)

SET(PHYSXFOUNDATION_PLATFORM_FILES
	${PHYSXFOUNDATION_PLATFORM_HEADERS}
	${PHYSXFOUNDATION_PLATFORM_SOURCE}
	${PHYSXFOUNDATION_PLATFORM_SOURCE_HEADERS}
	${PHYSXFOUNDATION_RESOURCE_FILE}
)

SET(PHYSXFOUNDATION_PLATFORM_INCLUDES
	${LL_SOURCE_DIR}/include/windows
)

SET(PHYSXFOUNDATION_COMPILE_DEFS
	# Common to all configurations
	${PHYSX_WINDOWS_COMPILE_DEFS};_WINSOCK_DEPRECATED_NO_WARNINGS;${PXFOUNDATION_LIBTYPE_DEFS};${PHYSX_LIBTYPE_DEFS};

	$<$<CONFIG:debug>:${PHYSX_WINDOWS_DEBUG_COMPILE_DEFS};>
	$<$<CONFIG:asan>:${PHYSX_WINDOWS_ASAN_COMPILE_DEFS};>
	$<$<CONFIG:relwithdebinfo>:${PHYSX_WINDOWS_RELWITHDEBINFO_COMPILE_DEFS};>
	$<$<CONFIG:release>:${PHYSX_WINDOWS_RELEASE_COMPILE_DEFS};>
)

IF(NV_USE_GAMEWORKS_OUTPUT_DIRS AND PHYSXFOUNDATION_LIBTYPE STREQUAL "STATIC")	
	SET(PHYSXFOUNDATION_COMPILE_PDB_NAME_DEBUG "PhysXFoundation_static${CMAKE_DEBUG_POSTFIX}")
	SET(PHYSXFOUNDATION_COMPILE_PDB_NAME_ASAN "PhysXFoundation_static${CMAKE_ASAN_POSTFIX}")
	SET(PHYSXFOUNDATION_COMPILE_PDB_NAME_RELWITHDEBINFO "PhysXFoundation_static${CMAKE_RELWITHDEBINFO_POSTFIX}")
	SET(PHYSXFOUNDATION_COMPILE_PDB_NAME_RELEASE "PhysXFoundation_static${CMAKE_RELEASE_POSTFIX}")
ELSE()
	SET(PHYSXFOUNDATION_COMPILE_PDB_NAME_DEBUG "PhysXFoundation${CMAKE_DEBUG_POSTFIX}")
	SET(PHYSXFOUNDATION_COMPILE_PDB_NAME_ASAN "PhysXFoundation${CMAKE_ASAN_POSTFIX}")
	SET(PHYSXFOUNDATION_COMPILE_PDB_NAME_RELWITHDEBINFO "PhysXFoundation${CMAKE_RELWITHDEBINFO_POSTFIX}")
	SET(PHYSXFOUNDATION_COMPILE_PDB_NAME_RELEASE "PhysXFoundation${CMAKE_RELEASE_POSTFIX}")
ENDIF()

IF(PHYSXFOUNDATION_LIBTYPE STREQUAL "SHARED")
	INSTALL(FILES $<TARGET_PDB_FILE:PhysXFoundation> 
		DESTINATION $<$<CONFIG:debug>:${PX_ROOT_LIB_DIR}/debug>$<$<CONFIG:release>:${PX_ROOT_LIB_DIR}/release>$<$<CONFIG:asan>:${PX_ROOT_LIB_DIR}/asan>$<$<CONFIG:relwithdebinfo>:${PX_ROOT_LIB_DIR}/relwithdebinfo> OPTIONAL)
ELSE()
	INSTALL(FILES ${PHYSX_ROOT_DIR}/$<$<CONFIG:debug>:${PX_ROOT_LIB_DIR}/debug>$<$<CONFIG:release>:${PX_ROOT_LIB_DIR}/release>$<$<CONFIG:asan>:${PX_ROOT_LIB_DIR}/asan>$<$<CONFIG:relwithdebinfo>:${PX_ROOT_LIB_DIR}/relwithdebinfo>/$<$<CONFIG:debug>:${PHYSXFOUNDATION_COMPILE_PDB_NAME_DEBUG}>$<$<CONFIG:asan>:${PHYSXFOUNDATION_COMPILE_PDB_NAME_ASAN}>$<$<CONFIG:relwithdebinfo>:${PHYSXFOUNDATION_COMPILE_PDB_NAME_RELWITHDEBINFO}>$<$<CONFIG:release>:${PHYSXFOUNDATION_COMPILE_PDB_NAME_RELEASE}>.pdb
		DESTINATION $<$<CONFIG:debug>:${PX_ROOT_LIB_DIR}/debug>$<$<CONFIG:release>:${PX_ROOT_LIB_DIR}/release>$<$<CONFIG:asan>:${PX_ROOT_LIB_DIR}/asan>$<$<CONFIG:relwithdebinfo>:${PX_ROOT_LIB_DIR}/relwithdebinfo> OPTIONAL)	
ENDIF()