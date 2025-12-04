set(HEADERS
    "EnterKeyAction.hpp" "EnterKeyActionAttachedType.hpp" "InputPanelIface.hpp"
    "VirtualKeyboardInputContextPlugin.h" "VirtualKeyboardInputContext.h"
    "DeclarativeInputEngine.h")

set(SOURCES
    "EnterKeyAction.cpp" "EnterKeyActionAttachedType.cpp" "InputPanelIface.cpp"
    "VirtualKeyboardInputContextPlugin.cpp" "VirtualKeyboardInputContext.cpp"
    "DeclarativeInputEngine.cpp")

set(QML_FILES
    "qml/AlternativeKeysPopup.qml"
    "qml/BackspaceKey.qml"
    "qml/CsLayout.qml"
    "qml/CySrBsLayout.qml"
    "qml/DeLayout.qml"
    "qml/DigitsLayout.qml"
    "qml/ElLayout.qml"
    "qml/EnLayout.qml"
    "qml/EnterKey.qml"
    "qml/EsLayout.qml"
    "qml/FrLayout.qml"
    "qml/DaLayout.qml"
    "qml/FiLayout.qml"
    "qml/HideKey.qml"
    "qml/InputPanel.qml"
    "qml/ItLayout.qml"
    "qml/KeyModel.qml"
    "qml/KeyPopup.qml"
    "qml/Key.qml"
    "qml/LanguageKey.qml"
    "qml/LtSrHrBsLayout.qml"
    "qml/NlLayout.qml"
    "qml/PlLayout.qml"
    "qml/PtLayout.qml"
    "qml/QwertyLayout.qml"
    "qml/RuLayout.qml"
    "qml/ShiftKey.qml"
    "qml/SpaceKey.qml"
    "qml/SvLayout.qml"
    "qml/SymbolKey.qml"
    "qml/SymbolLayout.qml"
    "qml/UkLayout.qml")

foreach(_file IN_LISTS QML_FILES)
  cmake_path(GET _file FILENAME _fileName)
  set_source_files_properties(${_file} PROPERTIES QT_RESOURCE_ALIAS
                                                  ${_fileName})
endforeach()

qt_add_qml_module(
  ${PROJECT_NAME}
  URI
  "QtQuick.CuteKeyboard"
  VERSION
  1.0
  PLUGIN_TARGET
  ${PROJECT_NAME}
  OUTPUT_DIRECTORY
  "QtQuick/CuteKeyboard"
  RESOURCE_PREFIX
  "/"
  CLASS_NAME
  "VirtualKeyboardInputContextPlugin"
  SOURCES
  ${HEADERS}
  ${SOURCES}
  QML_FILES
  ${QML_FILES}
  NO_GENERATE_PLUGIN_SOURCE)

qt_add_resources(${PROJECT_NAME} "icons" PREFIX "/" FILES "resources.qrc")

target_link_libraries(
  ${PROJECT_NAME} PRIVATE Qt::Core Qt::Gui Qt::GuiPrivate Qt::Qml Qt::Quick
                          Qt::QuickPrivate)

set(INSTALL_PLUGINSDIR "" CACHE PATH "Installation directory for plugins")
if (NOT INSTALL_PLUGINSDIR)
  if(${PROJECT_NAME} STREQUAL ${CMAKE_PROJECT_NAME})
    set(INSTALL_PLUGINSDIR ${QT_DIR}/../../../plugins)
  else()
    set(INSTALL_PLUGINSDIR ${CMAKE_INSTALL_BINDIR})
    set_target_properties(
      ${PROJECT_NAME}
      PROPERTIES LIBRARY_OUTPUT_DIRECTORY
                "$<TARGET_FILE_DIR:${CMAKE_PROJECT_NAME}>/platforminputcontexts")
  endif()
endif()

install(TARGETS ${PROJECT_NAME} LIBRARY DESTINATION ${INSTALL_PLUGINSDIR}/platforminputcontexts)