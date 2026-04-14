import qs.components
import QtQuick
import Quickshell
import qs.config

PathView {
  id: carousel
  property string currentWallpaper: currentItem?.fileUrl.toString().replace("file://", "") ?? ""
  clip: true

  MouseArea {
    anchors.fill: parent
    onWheel: (event) => {
      if (event.angleDelta.y > 0) {
        carousel.incrementCurrentIndex()
      } else  carousel.decrementCurrentIndex()   
    }
  }

  preferredHighlightBegin: 0.5
  preferredHighlightEnd: 0.5
  highlightRangeMode: PathView.StrictlyEnforceRange
  pathItemCount: 3
  
  delegate: WallpaperThumbnail {
    required property url fileUrl
    required property int index
    url: fileUrl
    scale: PathView.isCurrentItem ? 1.3 : 0.8
    onClicked: PathView.view.currentIndex = index
  }

  path: Path {
    startX: 0
    startY: carousel.height / 2

    PathLine {
      x: carousel.width
      y: carousel.height / 2
    }
  }
}
