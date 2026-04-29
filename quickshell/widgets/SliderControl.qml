import qs.components
import QtQuick.Layouts
import qs.utils
import QtQuick
import qs.theme

SRectangle {
  id: root
  property real value: 0
  property bool hasConfig: true

  property alias button: _button
  property alias slider: _slider
  property alias configButton: _configButton

  showBorder: true
  implicitHeight: control.height + padding  * 2
  padding: 4

  RowLayout {
    id: control
    spacing: 4
    
    width: parent.width
    
    SButton {
      id: _button
    }
    
    SSlider {
      id: _slider
      value: root.value
      implicitHeight: 10
      Layout.fillWidth: true
    }

    SButton {
      id: _configButton
      visible: root.hasConfig
      enabled: root.hasConfig
      nerdIcon.text: NerdIcons.dots_v
    }
    Item {}
  }
}
