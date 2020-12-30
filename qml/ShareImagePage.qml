import QtQuick 2.7
import Ubuntu.Components 1.3
import Ubuntu.Content 1.3

Page {
  id: root


  header: PageHeader {
    id: shareImageHeader
    title: i18n.tr("Share image")
  }

  ContentPeerPicker{
    anchors { fill: parent; topMargin: root.header.height }
    visible: parent.visible
    showTitle: false
    contentType: ContentType.Pictures
    handler: ContentHandler.Destination

    onPeerSelected: {
        root.activeTransfer = peer.request()
        root.activeTransfer.stateChanged.connect(function(){
          if(root.activeTransfer.state === ContentTransfer.InProgress){
            root.activeTransfer.items = [resultComponent.createObject(root, {"url": pathToSave})]
            root.activeTransfer.state = ContentTransfer.Charged
            //pageStack.pop()
          }

        })
    }
  }


  Component {
    id: resultComponent
    ContentItem {}
  }

}
