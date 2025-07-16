qt_add_executable(example WIN32 MACOSX_BUNDLE main.cpp)
target_compile_definitions(example PRIVATE QT_DEPRECATED_WARNINGS)

target_link_libraries(example PRIVATE Qt::Core Qt::Gui Qt::Quick)

set(qml_resource_files "main.qml")

qt_add_resources(example "qml" PREFIX "/" FILES ${qml_resource_files})

install(
  TARGETS example
  BUNDLE DESTINATION .
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})

qt_generate_deploy_app_script(TARGET example OUTPUT_SCRIPT deploy_script
                              NO_UNSUPPORTED_PLATFORM_ERROR)
install(SCRIPT ${deploy_script})
