import Quickshell

PersistentProperties {
  property bool active: false
  signal hide()

  function show() {
    active =  true
  }

  function toggle() {
    active ? hide() : show()
  }
}
