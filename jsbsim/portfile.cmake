
vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO JSBSim-Team/jsbsim
    REF v1.1.11 
    SHA512 b773a6cb481cc22044cf57fb7ada9aa456cea21aa750bba96ec33d65d5270df70bdb560f5b329f9decca19bc4a8cf48ab4fce8f64f4029f28ac1dc5ade146f3b
    HEAD_REF master
)

vcpkg_cmake_configure(
    SOURCE_PATH ${SOURCE_PATH} 
    OPTIONS
		-DBUILD_DOCS=OFF
		-DBUILD_PYTHON_MODULE=OFF
)


vcpkg_cmake_install()

vcpkg_copy_tools(
    TOOL_NAMES aeromatic JSBSim
    AUTO_CLEAN
)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(COPY "${SOURCE_PATH}/aircraft" DESTINATION "${CURRENT_PACKAGES_DIR}/tools/jsbsim")
file(COPY "${SOURCE_PATH}/scripts" DESTINATION "${CURRENT_PACKAGES_DIR}/tools/jsbsim")
file(COPY "${SOURCE_PATH}/tests" DESTINATION "${CURRENT_PACKAGES_DIR}/tools/jsbsim")
file(COPY "${SOURCE_PATH}/systems" DESTINATION "${CURRENT_PACKAGES_DIR}/tools/jsbsim")
file(COPY "${SOURCE_PATH}/matlab" DESTINATION "${CURRENT_PACKAGES_DIR}/tools/jsbsim")
file(COPY "${SOURCE_PATH}/julia" DESTINATION "${CURRENT_PACKAGES_DIR}/tools/jsbsim")
file(COPY "${SOURCE_PATH}/python" DESTINATION "${CURRENT_PACKAGES_DIR}/tools/jsbsim")
file(COPY "${SOURCE_PATH}/examples" DESTINATION "${CURRENT_PACKAGES_DIR}/tools/jsbsim")
file(COPY "${SOURCE_PATH}/data_plot" DESTINATION "${CURRENT_PACKAGES_DIR}/tools/jsbsim")
file(COPY "${SOURCE_PATH}/data_output" DESTINATION "${CURRENT_PACKAGES_DIR}/tools/jsbsim")
file(COPY "${SOURCE_PATH}/check_cases" DESTINATION "${CURRENT_PACKAGES_DIR}/tools/jsbsim")
file(COPY "${SOURCE_PATH}/admin" DESTINATION "${CURRENT_PACKAGES_DIR}/tools/jsbsim")
file(COPY "${SOURCE_PATH}/engine" DESTINATION "${CURRENT_PACKAGES_DIR}/tools/jsbsim")
configure_file("${SOURCE_PATH}/COPYING" "${CURRENT_PACKAGES_DIR}/share/jsbsim/copyright" COPYONLY)
	
