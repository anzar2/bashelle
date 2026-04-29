pragma Singleton
import Quickshell

Singleton {
  function p(title, body, type) {
    switch (type) {
      case "warning":
        console.warn(`[${title}]`, body)
        break;
      case "error":
        console.error(`[${title}]`, body)
        break;
      default:
        console.log(`[${title}]`, body)
    }
  }
}