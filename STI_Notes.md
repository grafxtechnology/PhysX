
### Building on Windows for starters with:

```
cmake .\physx\source\compiler\cmake\ -B build_windows -G "Visual Studio 16 2019" -Ax64 -DTARGET_BUILD_PLATFORM=windows -DPX_OUTPUT_ARCH=x86 --no-warn-unused-cli -DCMAKE_PREFIX_PATH="<repo_path>/physx/../externals/CMakeModules;<repo_path>/physx/../externals/targa" -DPHYSX_ROOT_DIR="<repo_path>/physx" -DPX_OUTPUT_LIB_DIR="<repo_path>/physx" -DPX_OUTPUT_BIN_DIR="<repo_path>/physx"  -DPX_BUILDSNIPPETS=FALSE -DPX_BUILDPUBLICSAMPLES=FALSE -DPX_GENERATE_STATIC_LIBRARIES=TRUE -DNV_USE_STATIC_WINCRT=FALSE -DNV_USE_DEBUG_WINCRT=TRUE -DPX_FLOAT_POINT_PRECISE_MATH=TRUE  -DCMAKE_INSTALL_PREFIX="<repo_path>/install"
```