import QtQuick

QtObject {
  property bool active
  signal hide()
  signal show()

  onShow: active = true

  function toggle() {
    active ? hide() : show()
  }
}
