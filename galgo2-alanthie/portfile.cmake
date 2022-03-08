#header-only library
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO alanthie/GALGO-2.0
    REF 9a37c327e42d22cdc3b8d232af65ea842a8c3259
    SHA512 d259b1a94117edc99b9dc184948b1137a17b6ce83efd7f4fe538ad8689cd43b8065115e5e49825ac834a71f6eedf851a09ca9802236332c47e63afb1324f0ae4
    HEAD_REF master
	PATCHES 
		"001-patch_build.patch"
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()
 
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug)
file(INSTALL ${SOURCE_PATH}/LICENSE.md DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)

