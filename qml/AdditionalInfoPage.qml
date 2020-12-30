import QtQuick 2.7
import Ubuntu.Components 1.3

Page {
  id: root
  height: bottomEdge.height
  header: PageHeader {
    id: additionalInfoHeader
    title: i18n.tr("Additional infos")
  }

  ScrollView{
    anchors.top:additionalInfoHeader.bottom
    anchors.topMargin:units.gu(2)
    anchors.leftMargin:units.gu(2)
    id: additionalInfoScrollView
    width: additionalInfoHeader.width
    height: root.height

    Item{
      id: itemScrollView
      width: root.width

      Column {
        id: additionalInfoColum
        spacing: units.gu(2)
        anchors.margins: units.gu(2)
        width: scrollView.width

        Label{
          id: titelLabel
          font.bold: true
          text: i18n.tr("Titel:")
        }

        Label{
          id: titelText
          text: pictureOfTheDayInfos.titleInfo
        }

        Label{
          id: copyrightLabel
          font.bold: true
          text: i18n.tr("Copyright:")
        }

        Label{
          id: copyrightText
          text: pictureOfTheDayInfos.copyrightInfo
        }

        Label{
          id: descriptionLabel
          font.bold: true
          text: i18n.tr("Description:")
        }

        Text{
          width: root.width
          wrapMode:Text.WordWrap
          id: descriptionText
          text: pictureOfTheDayInfos.explanationInfo
        }
      }
    }
  }
}
