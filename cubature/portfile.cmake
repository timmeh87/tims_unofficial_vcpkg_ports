
vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO stevengj/cubature
    REF 6bda3b267b5f5d644baac09565af661487b9a0da
    SHA512 5523c51278c1e8d0e657e6e09aa39eba60b3a9d388660d31745545d02b41c0e316c71b2c7a047fc49f69f38ced1fdc621b12e2886aa6a2b7a67bf21f2e181196
    HEAD_REF master
	PATCHES 
		"001-remove_tests.patch"
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    DISABLE_PARALLEL_CONFIGURE
    DISABLE_PARALLEL_BUILD
)

vcpkg_install_cmake()
 
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(INSTALL ${SOURCE_PATH}/COPYING.md DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)