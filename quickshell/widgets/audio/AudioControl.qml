import qs.components
import QtQuick.Layouts


RowLayout {
  spacing: 8
  property alias button: _button
  property alias slider: _slider
  property alias label: _text

  SButton { id: _button }
  SSlider { id: _slider; Layout.fillWidth: true }
  SText   { id: _text;   size: 8; visible: text != "" }
}
