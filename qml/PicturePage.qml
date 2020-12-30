import QtQuick 2.7
import Ubuntu.Components 1.3
import Ubuntu.Content 1.1
import Ubuntu.DownloadManager 1.2

Page {
  id: root

  //Public properties

  property alias headerText: imagePageHeader.title
  property alias image: nasaImage
  property string urlToImage
  signal share
  signal saveAs


  header: PageHeader {
    id: imagePageHeader
    trailingActionBar.actions: [
    Action {
      iconName: "browser-tabs"
      onTriggered:{
        Qt.openUrlExternally(pictureOfTheDayInfos.hdurlInfo);
      }
    },
    Action {
      iconName: "share"
      onTriggered:{
        if(nasaImage.status == Image.Ready){
          //save image to local directory
          downloadingProgressBar.visible = true
          singleImageHighResDownload.download(pictureOfTheDayInfos.urlInfo)
        }
      }
    },
    Action {
      iconName: "save-as"
      onTriggered:{
        if(nasaImage.status == Image.Ready){
          //save image to local directory
          downloadingProgressBar.visible = true
          singleImageHighResDownload.download(pictureOfTheDayInfos.hdurlInfo)
        }
      }
    }
    ]
  }

  SingleDownload{
    id: singleImageHighResDownload
    onFinished: {
        urlToImage = path
        downloadingProgressBar.visible = false
        root.saveAs()
    }
  }

  SingleDownload{
    id: singleImageLowResDownload
    onFinished: {
        urlToImage = path
        downloadingProgressBar.visible = false
        root.share()
    }
  }

  BouncingProgressBar {
      id: downloadingProgressBar
      z: 10
      anchors.top: imagePageHeader.bottom
      visible: false
  }

  BottomEdge {
    id: bottomEdge
    contentComponent: bottomEdgeContent
    Component {
      id: bottomEdgeContent
      AdditionalInfoPage{}
    }
  }

  ScrollView{
    anchors.top:imagePageHeader.bottom
    id: imageScrollView
    width: root.width
    height: root.height

    Item{
      id: itemScrollViewOfImage


      Image {
        id: nasaImage
        visible: nasaImage.status === Image.Ready
        fillMode: Image.PreserveAspectFit
        width: root.width
        height: root.height
        onStatusChanged: {
          if (nasaImage.status == Image.Ready) {
            downloadingProgressBar.visible = false
          }
          else{
            downloadingProgressBar.visible = true
          }
        }


        PinchArea {
          anchors.fill: parent
          pinch.target: nasaImage
          pinch.minimumScale: 0.1
          pinch.maximumScale: 10
          pinch.dragAxis: Pinch.NoPinch
        }

        /*MouseArea{
        anchors.fill: parent
        onWheel:{
        nasaImage.scale += nasaImage.scale * wheel.angleDelta.y /120 /10
      }
    }
    */
  }
}
}
}
