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
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import Ubuntu.Components.Popups 1.3
import "Rest.js" as REST //first letter must be uppercase

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

    Component.onCompleted:{
      //When completed with loading, show current date on datePickerPage
      console.log("All loaded. APP is up and running.")
      datePickerPage.selectedDate = new Date();
    }

    //Instances of the pages

    DatePickerPage{
      id: datePickerPage
      onClickedGetImage:{
        REST.get_picture(Qt.formatDate(datePickerPage.selectedDate, "yyyy-MM-dd"))
        console.log("Mediatype: "+pictureOfTheDayInfos.mediaTypeInfo)
        if(pictureOfTheDayInfos.mediaTypeInfo === "image"){
          datePickerPage.pageStack.addPageToNextColumn(datePickerPage, picturePage)
          picturePage.headerText = Qt.formatDate(datePickerPage.selectedDate, i18n.tr("MM/dd/yyyy"))
        }
        else{
          datePickerPage.pageStack.addPageToNextColumn(datePickerPage, videoPage)
          videoPage.headerText = Qt.formatDate(datePickerPage.selectedDate, i18n.tr("MM/dd/yyyy"))
        }
      }
      onClickedAboutPage:{
        datePickerPage.pageStack.addPageToCurrentColumn(datePickerPage,aboutPage)
      }
    }

    PicturePage{
      id: picturePage
      onSaveAs:{
        saveImagePage.pathToSave = urlToImage
        picturePage.pageStack.addPageToCurrentColumn(picturePage, saveImagePage)
      }
      onShare:{
        shareImagePage.pathToSave = urlToImage
        picturePage.pageStack.addPageToCurrentColumn(picturePage, shareImagePage)
      }
    }

    VideoPage{
      id: videoPage
      onShare:{
        shareVideoPage.pathToShare = urlToVideo
        picturePage.pageStack.addPageToCurrentcolumn(videoPage, shareVideoPage)
      }
    }

    AboutPage{
      id: aboutPage
    }

    SaveImagePage{
      id: saveImagePage
    }

    ShareImagePage{
      id: shareImagePage
    }

    ShareVideoPage{
      id: shareVideoPage
    }

  }

Component {
  id: errorDialog
  Dialog {
    id: dialog
    title: i18n.tr("Error")
    text: errorText

    Button {
      text: i18n.tr("Close")
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

property string errorText: ""

property Image imageToShow: picturePage.image

property string urlToImage: ""

}
