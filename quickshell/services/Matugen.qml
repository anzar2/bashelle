pragma Singleton
import Quickshell.Io
import qs.config

// https://github.com/InioX/matugen/wiki/Usage

Service {
  id: service
  name: "Matugen"
  onStart: ready = true
  property bool busy: daemon.running

  function image(img: string, theme: string) {
    if (service.busy) return
    daemon.command = [
      "matugen",
      "image", img,
      "-m", theme,
      "--source-color-index", 0
    ]
    service.log(`image(): img: ${img} theme: ${theme}`)
    daemon.running = true
  }

  function color(color: string, theme) {
    if (service.busy) return
    daemon.command = [
      "matugen", 
      "color", "hex", color,
      "-m", theme
    ]

    service.log(`color(): color: ${color} theme: ${theme}`)
    daemon.running = true
  }

  Process {
    id: daemon

    stdout: StdioCollector {
      onStreamFinished:  {
        if (text) {
          service.log(text)
        }
      }   
    }

    stderr: StdioCollector {
      onStreamFinished:  {
        if (text) {
          service.log(text)
        }
      }   
    }
  }
}
