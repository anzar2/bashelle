pragma Singleton
import Quickshell.Services.Pipewire
import QtQuick
import Quickshell

Singleton {
  id: root
  
  property AudioSink sink: AudioSink {}
  property AudioSource source: AudioSource {}
  property var outputDevices: Pipewire.nodes.values.filter(device => device.isSink && !device.isStream)
  property var inputDevices: Pipewire.nodes.values.filter(device => !device.isSink && !device.isStream && device.type === 9)

  PwObjectTracker {
    objects: [root.sink.device, root.source.device]
  }

}
