import QtQuick 2.7
import Ubuntu.Components 1.3

Page{
  id: root
  header: PageHeader {
    id: aboutPageHeader
    title: i18n.tr("About")

  }
  ScrollView{
    id: aboutPageScrollView
    anchors{
      top: aboutPageHeader.bottom
      bottom: parent.bottom
      left: parent.left
      right: parent.right
      leftMargin: units.gu(2)
      rightMargin: units.gu(2)
      topMargin: units.gu(2)
    }

    clip: true

    Column {
      id: aboutPageColumn
      spacing: units.gu(2)
      width: aboutPageScrollView.width


      Label {
        horizontalAlignment: Text.AlignHCenter
        id: appNameLabel
        width: parent.width
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        fontSize: "large"
        text: "<b>Astronomy Picture Of The Day</b>"
      }

      UbuntuShape {
        width: units.gu(12); height: units.gu(12)
        anchors.horizontalCenter: parent.horizontalCenter
        radius: "medium"
        image: Image {
          source: Qt.resolvedUrl("../assets/logo.svg")
        }
      }

      Label {
        horizontalAlignment: Text.AlignHCenter
        id: appCopyrightLabel
        width: parent.width
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        text: "(c) 2020 Wolfgang Eder"
      }

      Label {
        horizontalAlignment: Text.AlignHCenter
        id: appCopyrightLogo
        width: parent.width
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        text: i18n.tr("Icon and Splashscreen from <a href=\"https://pixabay.com/de/users/openclipart-vectors-30363/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=148300\">Pixerbay</a>.")
        onLinkActivated: Qt.openUrlExternally(link)
      }


      Label {
        horizontalAlignment: Text.AlignHCenter
        id: appFelgoReference
        width: parent.width
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        text: i18n.tr("Code based on an online <a href=\"https://blog.felgo.com/guest-post/nasa-astronomy-picture-app\">tutorial.</a>")
        onLinkActivated: Qt.openUrlExternally(link)
      }

      Label {
        horizontalAlignment: Text.AlignHCenter
        id: bouncingReference
        width: parent.width
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        text: i18n.tr("Bouncing Progress Bar from the app <a href=\"https://github.com/turanmahmudov/Wallpapers\">Wallpapers</a> from Turan Mahmudov.")
        onLinkActivated: Qt.openUrlExternally(link)
      }
    }
  }
}
