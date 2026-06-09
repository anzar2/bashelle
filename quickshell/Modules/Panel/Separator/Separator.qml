import QtQuick.Layouts
import QtQuick

import qs.Modules.Panel
import qs.Config
import qs.Theme

PanelModule {
  roleValue: "separator"

  Rectangle {
    property real size: 2
    implicitWidth: size; implicitHeight: size;

    color: Theme.colors.surface_container
    
    Layout.margins: 6
    Layout.fillHeight: Config.panel.isHorizontal()
    Layout.fillWidth:  Config.panel.isVertical()
  }
}
