import QtQuick
import Quickshell
import qs.components
import qs.config

SButton {
  id: clock
  property string dateFormat: Config.panel.isVertical() ? Config.clock.verticalFormat : Config.clock.horizontalFormat
  
  SystemClock {
    id: sysClock
    precision: SystemClock.Seconds
  }
  text: Qt.formatDateTime(sysClock.date, dateFormat)
  textSize: Config.clock.fontSize
  font.bold: Config.clock.bold
  layoutDirection: Qt.RightToLeft
}
