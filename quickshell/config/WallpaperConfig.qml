import Quickshell.Io
import QtQuick

/*
  https://man.archlinux.org/man/awww-img.1.en.txt
  Possible values:
  no:       Do not resize the image
  crop:     Resize the image to fill the whole screen,
            cropping out parts that don't fit

  fit:      Resize the image to fit inside the screen,
            preserving the original aspect ratio
  
  stretch:  Resize the image to fit inside the screen,
            without preserving the original aspect ratio
*/
JsonObject {
  property string folder: "~/.config/wallpapers"
  property color fallbackColor: "#000000"
  property string resizeMode: "fit"
}