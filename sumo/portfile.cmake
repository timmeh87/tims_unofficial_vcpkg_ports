vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO eclipse/sumo
    REF 800cb422fa4b9107a1d799d73fc19dbdd7f2cdab
    SHA512 175b1f2fdac230ccdfd78fba1c8147f870db4fda05194521dcc95f0c97d9815b63b956c2347a218acefbf2af1e6558690104fde1a41d2a1a17971941b3cdb5a3
    HEAD_REF master
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH cmake)

vcpkg_copy_tools(
    TOOL_NAMES sumo activitygen dfrouter duarouter emissionsDrivingCycle emissionsMap jtrrouter marouter netconvert netgenerate od2trips polyconvert
    AUTO_CLEAN
)

#vcpkg policy: no duplicate /include folder inside debug folder
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

#following above policy, do not duplicate anything else either
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/tools")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/data")
file(GLOB DBG_EXEs ${CURRENT_PACKAGES_DIR}/debug/bin/*.exe)
file(REMOVE ${DBG_EXEs})
file(REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/start-command-line.bat)

#unfortunately, sumo provides a folder with the same name as "lib" that contains "site packages". im not sure the best way to do this,
#but the lib folder is where import libraries should be
file(RENAME "${CURRENT_PACKAGES_DIR}/Lib/site-packages" "${CURRENT_PACKAGES_DIR}/site-packages")
file(RENAME "${CURRENT_PACKAGES_DIR}/Lib" "${CURRENT_PACKAGES_DIR}/lib")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/Lib")
file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/debug/lib/")

#move libs to the lib folder
file(RENAME "${CURRENT_PACKAGES_DIR}/bin/libsumocpp.lib" "${CURRENT_PACKAGES_DIR}/lib/libsumocpp.lib")
file(RENAME "${CURRENT_PACKAGES_DIR}/bin/libtracicpp.lib" "${CURRENT_PACKAGES_DIR}/lib/libtracicpp.lib")
file(RENAME "${CURRENT_PACKAGES_DIR}/bin/start-command-line.bat" "${CURRENT_PACKAGES_DIR}/tools/sumo/start-command-line.bat")
file(RENAME "${CURRENT_PACKAGES_DIR}/debug/bin/libsumocppD.lib" "${CURRENT_PACKAGES_DIR}/debug/lib/libsumocppD.lib")
file(RENAME "${CURRENT_PACKAGES_DIR}/debug/bin/libtracicppD.lib" "${CURRENT_PACKAGES_DIR}/debug/lib/libtracicppD.lib")

#empty
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/tools/contributed/saga" "${CURRENT_PACKAGES_DIR}/tools/contributed/traci4matlab")

# # Handle copyright
file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/sumo" RENAME copyright)

