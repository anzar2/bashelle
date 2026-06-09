pragma Singleton
import Quickshell.Services.Pipewire
import QtQuick

import qs.Services

Service {
  id: service
  name: "Pipewire"
  
  onStart: ready = true

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
    node: service.source.device
  }

  PwNodeLinkTracker {
    id: _sinkTracker
    property var sources: linkGroups.map(g => g.source)
    node: service.sink.device
  }

  PwObjectTracker {
    id: _objectTracker
    objects: [
      service.sink.device, 
      service.source.device,
      ..._sinkTracker.sources,
      ..._sourceTracker.targets
    ]
  }         
}
