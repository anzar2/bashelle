WidgetController {
  id: _hub
  property int lastTabIndex: 0
  property string lastTabIdentifier: ""  
  property bool expanded: true
 

  function toggleExpanded() {
    expanded = !expanded
  }
}
