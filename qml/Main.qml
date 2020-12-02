/*
 * Copyright (C) 2020  Wolfgang Eder
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * potd is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.7
import Ubuntu.Components 1.3
import Ubuntu.Components.Pickers 1.3
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import Ubuntu.Components.Popups 1.3

  MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'potd.potd'
    automaticOrientation: true
      width: units.gu(100)
      height: units.gu(60)

      AdaptivePageLayout {
          anchors.fill: parent
          primaryPage: datePickerPage

          Page {
              id: datePickerPage
              header: PageHeader {
                  id: datePickerPageheader
                  title: i18n.tr("Picture Of The Day")
                  leadingActionBar.actions: [
                    Action {
                      iconName: "info"
                      text: i18n.tr("About")
                      onTriggered:{
                        datePickerPage.pageStack.addPageToCurrentColumn(datePickerPage,aboutPage)
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
                        datePickerPage.pageStack.addPageToNextColumn(datePickerPage, imagePage)
                        activity.running = true
                        get_picture(Qt.formatDate(datePicker.date, "yyyy-MM-dd"))

                      }
                  }


          }




          Page {
              id: imagePage
              header: PageHeader {
                id: imagePageHeader
                  title: "Picture Of Day "+Qt.formatDate(datePicker.date, "dd. MMMM yyyy")
              }

              ActivityIndicator {
                      id: activity
                      anchors.top: imagePageHeader.bottom;
                      anchors.centerIn : parent
                  }


          BottomEdge {
            id: bottomEdge
            height: parent.height

            contentComponent: Rectangle {
              width: bottomEdge.width
              height: descriptionText.height + units.gu(100)
              anchors.leftMargin: units.gu(2)

              PageHeader {
                id: additionalInfoHeader
                title: i18n.tr("Additional infos")
              }
              Button{
                anchors.top:additionalInfoHeader.bottom
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

              Flickable{
                anchors.top:descriptionLabel.bottom
                anchors.topMargin: units.gu(2)
                width: bottomEdge.width
                height: units.gu(50)
                contentHeight: descriptionText.height
                id: textFlick
                Text{
                  width: bottomEdge.width
                  wrapMode:Text.WordWrap
                  id: descriptionText
                  text: pictureOfTheDayInfos.explanationInfo
                }
              }



            }
          }

          Image {
            anchors.top: imagePageHeader.bottom;
            anchors.topMargin: units.gu(1)
            anchors.leftMargin: units.gu(1)
            id: nasaImage
               visible: nasaImage.status === Image.Ready
               fillMode: Image.PreserveAspectFit
               width: parent.width
               height: parent.height - units.gu(10)
               onStatusChanged: if (nasaImage.status == Image.Ready) activity.running = false


               PinchArea {
                    anchors.fill: parent
                    pinch.target: nasaImage
                    pinch.minimumScale: 0.1
                    pinch.maximumScale: 10
                    pinch.dragAxis: Pinch.XAndYAxis
                    onPinchFinished: nasaImage.returnToBounds()
                }
          }

          }

          Page{
            id: aboutPage
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
              text: i18n.tr("Icon from OpenClipart-Vectors at Pixabay.")

            }
            Button{
              anchors.top: appCopyrightLogo.bottom;
              anchors.horizontalCenter: parent.horizontalCenter
              anchors.topMargin: units.gu(2)
              id: appPixabayButton
              text: "Pixabay"
              onClicked: {
                Qt.openUrlExternally("https://pixabay.com/de/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=148300");
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

      }



      Component {
              id: errorDialog
              Dialog {
                  id: dialog
                  title: i18n.tr("Error")
                  text: i18n.tr("An error occured.")

                  Button {
                      text: "Close"
                      onClicked: PopupUtils.close(dialog)
                  }
              }
          }


property var pictureOfTheDayInfos:{
  "copyrightInfo":"",
  "dateInfo":"",
  "explanationInfo":"",
  "hdurlInfo":"",
  "mediaTypeInfo":"",
  "serviceVersionInfo":"",
  "titleInfo":"",
  "urlInfo":""
}


    function get_picture(dateStr)
    {
      const url_base = "https://api.nasa.gov/planetary/apod"
      const apiKey = "97FZPTGaw3E9cPasSsG65rhjRKoRWjTWCUqai38k"
      const httpOK = 200

      var params = "date=" + dateStr + "&api_key=" + apiKey

      nasaImage.source = ""

      get_request(url_base,params,
        function(http)
        {
          if(http.status === httpOK)
          {
            var resJason = JSON.parse(http.responseText)
            if(requestSuccess(resJason))return
          }
          requestError(http.status)
        })

    }

    function get_request(url, params, callback)
    {
      var http = new XMLHttpRequest()

      http.onreadystatechange = function(myhttp)
      {
        return function(){
          if (myhttp.readyState === XMLHttpRequest.DONE)
          callback(myhttp)

        }
      }(http)
      http.open("GET", url + "?" + params, true)
      http.send()
    }

    function requestError(errorCode)
    {
      activity.running = false
      nasaImage.source = ""
      PopupUtils.open(errorDialog)
    }

    function requestSuccess(res_json)
    {
        if (res_json && res_json !== {})
        {
            if (res_json.media_type === "image")
            {
              //reset Pinch
              nasaImage.anchors.topMargin = units.gu(1)
              nasaImage.anchors.leftMargin = units.gu(1)
              nasaImage.source = res_json.url

            }
            else if (res_json.media_type === "video")
            {
              requestError(10)
                 //nasaVideo.loadVideo(youtube_parser(res_json.url),true)
                 //nasaVideo.visible = true
            }

            if (res_json.copyright !== undefined)
            {
                //copyrightLabel.visible = true
                //copyrightLabel.text = "Copyright " + res_json.copyright
            }
            else
            {
                //copyrightLabel.visible = false
              }

              //put everyting in the property var pictureOfTheDayInfos
            pictureOfTheDayInfos = {
              "copyrightInfo":res_json.copyright,
              "dateInfo":res_json.date,
              "explanationInfo":res_json.explanation,
              "hdurlInfo":res_json.hdurl,
              "mediaTypeInfo":res_json.media_type,
              "serviceVersionInfo":res_json.service_version,
              "titleInfo":res_json.title,
              "urlInfo":res_json.url
            }

             return true
        }
        return false
    }

    function updateAdditionalInfos(){
      longtext.text = "This is a longtext"
    }


}
