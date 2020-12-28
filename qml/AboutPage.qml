import QtQuick 2.7
import Ubuntu.Components 1.3

Page{
  id: root
  header: PageHeader {
    id: aboutPageHeader
    title: i18n.tr("About")

  }

  Label {
    anchors.top: aboutPageHeader.bottom;
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.topMargin: units.gu(2)
    id: appNameLabel
    font.bold: true
    text: "Astronomy Picture Of The Day"

  }

  Label {
    anchors.top: appNameLabel.bottom;
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.topMargin: units.gu(2)
    id: appCopyrightLabel
    text: "(c) 2020 Wolfgang Eder"

  }

  Label {
    anchors.top: appCopyrightLabel.bottom;
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.topMargin: units.gu(2)
    id: appCopyrightLogo
    text: i18n.tr("Icon and Splashscreen from Pixabay.")

  }
  Button{
    anchors.top: appCopyrightLogo.bottom;
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.topMargin: units.gu(2)
    id: appPixabayButton
    text: "Pixabay"
    onClicked: {
      //Qt.openUrlExternally("https://pixabay.com/de/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=148300");
      Qt.openUrlExternally("https://pixabay.com/de/users/openclipart-vectors-30363/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=148300");

    }
  }

  Label {
    anchors.top: appPixabayButton.bottom;
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.topMargin: units.gu(2)
    id: appFelgoReference
    text: i18n.tr("Code based on an online tutorial:")

  }

  Button{
    anchors.top: appFelgoReference.bottom;
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.topMargin: units.gu(2)
    id: appFelgoButton
    text: "Tutorial"
    onClicked: {
      Qt.openUrlExternally("https://blog.felgo.com/guest-post/nasa-astronomy-picture-app");

    }
  }
}
