import QtQuick 2.7
import Ubuntu.Components 1.3
import Ubuntu.Content 1.1
import Ubuntu.DownloadManager 1.2
import Morph.Web 0.1
import QtWebEngine 1.10

Page {
  id: root

  //Public properties

  property alias headerText: videoPageHeader.title
  signal share


  header: PageHeader {
    id: videoPageHeader
    trailingActionBar.actions: [
    Action {
      iconName: "browser-tabs"
      onTriggered:{
        Qt.openUrlExternally(pictureOfTheDayInfos.urlInfo);
      }
    }//,
    //Action {
    //  iconName: "share"
    //  onTriggered:{

    //  }
    //}
    ]
  }

  BottomEdge {
    id: bottomEdge
    contentComponent: bottomEdgeContent
    Component {
      id: bottomEdgeContent
      AdditionalInfoPage{}
    }
  }

  WebView{
    id: webviewID


    anchors.fill: parent

    width: parent.width
    height: parent.height


    profile: WebEngineProfile {
      id: webContext
      persistentCookiesPolicy: WebEngineProfile.ForcePersistentCookies
      property alias dataPath: webContext.persistentStoragePath


      httpUserAgent: "Mozilla/5.0 (Linux; Android 10; Pixel 4 XL) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.79 Mobile Safari/537.36"

    }

    url: pictureOfTheDayInfos.urlInfo

    onLoadingChanged: {
      if (loadRequest.status === WebEngineLoadRequest.LoadSucceededStatus) {
        window.loaded = true
      }
    }
  }
}
