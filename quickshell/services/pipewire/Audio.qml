pragma Singleton
import Quickshell.Services.Pipewire
import QtQuick
import qs.services

Service {
  id: root
  name: "Pipewire"
  property AudioSink sink: AudioSink {}
  property AudioSource source: AudioSource {}
  property var outputDevices: Pipewire.nodes.values.filter(device => device.isSink && !device.isStream)
  property var inputDevices: Pipewire.nodes.values.filter(device => !device.isSink && !device.isStream && device.type === 9)
  property alias sourceTracker: _sourceTracker
  property alias sinkTracker: _sinkTracker
  property alias objectTracker: _objectTracker

  PwNodeLinkTracker {
    id: _sourceTracker
    property var targets: linkGroups.map(g => g.target)
    node: root.source.device
  }

  PwNodeLinkTracker {
    id: _sinkTracker
    property var sources: linkGroups.map(g => g.source)
    node: root.sink.device
  }

  PwObjectTracker {
    id: _objectTracker
    objects: [
      root.sink.device, 
      root.source.device,
      ..._sinkTracker.sources,
      ..._sourceTracker.targets
    ]
  }         
}
