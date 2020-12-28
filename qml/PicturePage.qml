import QtQuick 2.7
import Ubuntu.Components 1.3

Page {
  id: root

  //Public properties

  property alias headerText: imagePageHeader.title
  property alias image: nasaImage
  signal showAdditionalInfoPage
  function collapsAdditionalInfoPage(){
    bottomEdge.collapse()
    checkActivity()
  }
  function checkActivity(){
    if (nasaImage.status == Image.Ready) {
      activity.running = false
    }
    else{
      activity.running = true
    }
  }

  header: PageHeader {
    id: imagePageHeader
  }

  ActivityIndicator {
    id: activity
    anchors.top: imagePageHeader.bottom;
    anchors.centerIn : parent
  }


  BottomEdge {
    id: bottomEdge
    height: parent.height
    onCommitStarted:{
      root.showAdditionalInfoPage()
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
            activity.running = false
          }
          else{
            activity.running = true
          }
        }


        PinchArea {
          anchors.fill: parent
          pinch.target: nasaImage
          pinch.minimumScale: 0.1
          pinch.maximumScale: 10
          //pinch.dragAxis: Pinch.NoPinch
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
