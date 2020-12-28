import QtQuick 2.7
import Ubuntu.Components 1.3
import Ubuntu.Components.Pickers 1.3

  Page {
    id: root

    //Public properties
    property alias selectedDate: datePicker.date
    signal clickedGetImage
    signal clickedAboutPage



    header: PageHeader {
      id: datePickerPageheader
      title: i18n.tr("Picture Of The Day")
      leadingActionBar.actions: [
      Action {
        iconName: "info"
        onTriggered:{
          root.clickedAboutPage()
        }
      }
      ]
    }

    DatePicker {

      id: datePicker
      anchors.top: datePickerPageheader.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.topMargin: units.gu(2)

      minimum: {
        var d = new Date();
        d.setFullYear(d.getFullYear() - 15);
        return d;
      }
      maximum: {
        var today = new Date();
        return today;
      }

    }



    Button {
      id: getImageButton
      anchors.top: datePicker.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.topMargin: units.gu(2)
      text: i18n.tr("Get picture of that day!")

      onClicked: {
        root.clickedGetImage()
      }
    }
  }
