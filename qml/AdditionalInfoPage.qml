import QtQuick 2.7
import Ubuntu.Components 1.3

Page {
  id: root

  signal clickedBack



  header: PageHeader {
    id: additionalInfoHeader
    title: i18n.tr("Additional infos")
    leadingActionBar.actions: [
    Action {
      iconName: "back"
      onTriggered:{
        root.clickedBack()
      }
    }
    ]
  }

  ScrollView{
    anchors.top:additionalInfoHeader.bottom
    anchors.topMargin:units.gu(2)
    anchors.leftMargin:units.gu(2)
    id: additionalInfoScrollView
    width: root.width
    height: root.height

    Item{
      id: itemScrollView
      width: root.width

      Button{
        anchors.top:itemScrollView.bottom
        anchors.topMargin: units.gu(2)
        id: openHighResImage
        text: i18n.tr("Open High Resolution Image")

        onClicked: {
          Qt.openUrlExternally(pictureOfTheDayInfos.hdurlInfo);
        }
      }

      Label{
        anchors.top:openHighResImage.bottom
        anchors.topMargin: units.gu(2)
        id: titelLabel
        font.bold: true
        text: i18n.tr("Titel:")
      }

      Label{
        anchors.top:titelLabel.bottom
        anchors.topMargin: units.gu(2)
        id: titelText
        text: pictureOfTheDayInfos.titleInfo
      }

      Label{
        anchors.top:titelText.bottom
        anchors.topMargin: units.gu(2)
        id: copyrightLabel
        font.bold: true
        text: i18n.tr("Copyright:")
      }

      Label{
        anchors.top:copyrightLabel.bottom
        anchors.topMargin: units.gu(2)
        id: copyrightText
        text: pictureOfTheDayInfos.copyrightInfo
      }

      Label{
        anchors.top:copyrightText.bottom
        anchors.topMargin: units.gu(2)
        id: descriptionLabel
        font.bold: true
        text: i18n.tr("Description:")
      }

      Text{
        anchors.top:descriptionLabel.bottom
        anchors.topMargin:units.gu(2)

        width: root.width
        wrapMode:Text.WordWrap
        id: descriptionText
        text: pictureOfTheDayInfos.explanationInfo
      }

    }
  }
}
