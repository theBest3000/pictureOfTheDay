function get_picture(dateStr)
{
  var url_base = "https://api.nasa.gov/planetary/apod"
  var apiKey = "97FZPTGaw3E9cPasSsG65rhjRKoRWjTWCUqai38k"
  var httpOK = 200

  var params = "date=" + dateStr + "&api_key=" + apiKey

  imageToShow.source = ""

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
    imageToShow.source = ""

    if (errorCode === 10)
    {
      errorText = i18n.tr("Video not supported yet.")
      PopupUtils.open(errorDialog)
      return
    }

    if (errorCode === 400)
    {
      errorText = i18n.tr("Picture does not exist. Did you set the proper date?")
      PopupUtils.open(errorDialog)
      return
    }

    errorText = i18n.tr("An error occured. Errorcode: ") + errorCode

    PopupUtils.open(errorDialog)
}

function requestSuccess(res_json)
{
    if (res_json && res_json !== {})
    {
      if (res_json.media_type === "image")
      {

        //reset Pinch
        imageToShow.scale = 1.0
        imageToShow.source = res_json.url
      }
      else if (res_json.media_type === "video")
      {
        requestError(10)
        //nasaVideo.loadVideo(youtube_parser(res_json.url),true)
        //nasaVideo.visible = true
      }

      if (res_json.copyright === undefined)
      {
        res_json.copyright = i18n.tr("Public Domain")
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
