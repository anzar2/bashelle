pragma Singleton
import Quickshell

import qs.Services


Service {
  name: "Time"
  
  property alias systemClock: sysClock
  property date now: sysClock.date

  
  SystemClock { 
    id: sysClock 
    precision: SystemClock.Seconds 
  }

}
