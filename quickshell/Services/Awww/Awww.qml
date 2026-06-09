pragma Singleton
import Quickshell.Io
import qs.Config
import qs.Services

// https://man.archlinux.org/man/extra/awww/awww.1.en
// https://man.archlinux.org/man/awww-img.1.en
// https://man.archlinux.org/man/awww-query.1.en

Service {
  id: service
  name: "Awww"
  onStart: init.running = true

  property var wallpapers: []
  property bool busy: setter.running
  signal wallpaperChanged(w: string)
  

  function setImage(img: string, opts) {
    if (!service.ready || service.busy) {
      service.error("awww-daemon is not running or is busy")
      return
    }

    setter.command = [
      "awww", 
      "img",                   img,
      "--resize",              opts["resizeMode"] ?? "crop",
      "--fill-color",          opts["fillColor"]  ?? "000000",
      "--outputs",             opts["outputs"],
      "--transition-step",     Config.wallpapers.transitionStep,
      "--transition-duration", Config.wallpapers.transitionDuration,
      "--transition-fps",      Config.wallpapers.transitionFps,
      "--transition-type",     Config.wallpapers.transitionType
    ]
    service.log(`setImage(): img: ${img}  opts: ${JSON.stringify(opts)}`)
    service.wallpaperChanged(img)
    setter.running = true
  }

  function wallpaperOf(name: string): string {
    return wallpapers.find(w => w.name === name)["displaying"]["image"] ?? ""
  }

  function refresh() {
    if (!service.ready) {
      service.error("awww-daemon is not running")
      return
    }

    query.command = ["awww", "query", "-j"]
    query.running = true
  }

  Process {
    id: setter

    onExited: (code) => { if (code == 0) service.refresh() }
    
    stderr: StdioCollector {
      onStreamFinished: {
        if (text) {
          service.error(text)
        }
      }
    }
  }

  Process {
    id: query

    stdout: StdioCollector {
      onStreamFinished: {
        service.wallpapers = JSON.parse(text)[""]
        service.log("Wallpaper data has been updated")
      }
    }

    stderr: StdioCollector {
      onStreamFinished: {
        if (text) {
          service.error(text)
        }
      }
    }
  }

  Process {
    id: init
    command: ["awww", "query"]
    onExited: (code) => { 
      if (code == 0) 
        service.ready = true
        service.refresh()
    }
  }
}
