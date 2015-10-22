###
ユーザーエージェント判別(IE8~10,andoroid2x,ios)
###
userAgentClass = ->
  browser = null
  userAgent = navigator.userAgent.toLowerCase()
  appVersion = window.navigator.appVersion.toLowerCase()
  #ie
  if userAgent.indexOf("msie") > -1
    if appVersion.indexOf("msie 8.0") > -1
      browser = "ie8"
    else if appVersion.indexOf("msie 9.0") > -1
      browser = "ie9"
    else if appVersion.indexOf("msie 10.0") > -1
      browser = "ie10"
  #android
  else if userAgent.indexOf("Android") > 0
    version = parseFloat(userAgent.slice(userAgent.indexOf("Android")+8))
    if version <= 6
      browser = "android2"
  #ipad
  else if userAgent.indexOf("ipad") isnt -1
    browser = "ios"
  #iphone
  else if userAgent.indexOf("iphone") isnt -1
    browser = "ios"

  #addClass
  if browser
    return $("body").addClass(browser)

userAgentClass()

###
scroll
###
scrollAction = (target) ->
  $ 'body,html'
    .animate
      scrollTop: target
      500
      'easeInCirc'
  return false

smooth = ->
  $ '.smooth'
    .on 'click', ->
      href = $(@).attr 'href'
      position = $ if href is "#" or href is "" then "html" else href
      .offset().top - 50
      scrollAction(position)
  return
smooth()

nonScrollable = ->
  $ window
    .on 'touchmove.noScroll', (e)->
      e.preventDefault()
  return

scrollable = ->
  $ window
    .off '.noScroll'

###
トップへ戻るボタン
###
toTop = ->
  showFlag = false
  button = $('#totop')
  bottom = '30px'

  $ window
    .scroll ->
      if $(@).scrollTop() > 250
        if showFlag is false
          showFlag = true
          button.stop().animate
            "bottom": bottom
            200
            "easeInOutQuad"
          return
      else
        if showFlag
          showFlag = false
          button.stop().animate
            "bottom": "-70px"
            200
            "easeInOutQuad"
          return

  button.on "click", ->
    scrollAction(0)
    return false
  return

toTop()

###
modal
###
modalPlan = ->
  $ "#plan-list .btn-modal a"
    .on "click", ->
      content = $(@).attr("data-target")

      modalPosition = ->
        w = $(window).width()
        h = $(window).height()
        x = (w - $(content).outerWidth(true)) / 2
        y = (h - $(content).outerHeight(true)) / 2
        $ content
          .css
            'left': x + 'px'
            'top': y + 'px'
        return

      modalPosition()
      $ "body"
        .append "<div class='layer-overlay'></div>"
      $ ".layer-overlay"
        .css "display", "block"
      $ content
        .addClass "open"
      nonScrollable()

      $ ".layer-overlay, .open"
        .off()
        .on "click", ->
          $ content
            .removeClass "open"
          $ ".layer-overlay"
            .remove()
          scrollable()
          return

      $ window
        .on "resize", ->
          modalPosition()
      return

  return

modalPlan()

###
SNS Count
###
socialCountApi = (url, element) ->
  #facebook
  $.ajax
    url: "https://graph.facebook.com/",
    dataType: "jsonp",
    data:
      id: url
    success: (rss) ->
      $ ".facebook-#{element}"
        .text rss.shares || 0
    error: ->
      $ ".facebook-#{element}"
        .text "0"
  #twitter
  ///API廃止により、コメントアウト
  $.ajax
    url: "http://urls.api.twitter.com/1/urls/count.json?url=" + url
    dataType: "jsonp"
    data:
      url:url
    success: (res) ->
      $ ".twitter-#{element}"
      .text res.count || 0
    error: ->
      $ ".twitter-#{element}"
      .text "0"
  ///
  #hatebu
  $.ajax
    url: "http://api.b.st-hatena.com/entry.count?callback=?"
    dataType: "jsonp"
    data:
      url: url
    success: (res) ->
      $ ".hatebu-#{element}"
      .text res || 0
    error: ->
      $ ".hatebu-#{element}"
      .text '0'

###
equalHeight
###

equalHeight = (group) ->
  $ window
    .on "load resize", ->
      w = $(window).width()
      mqTablet = 768
      tallest = 0
      if mqTablet <= w
        group.each ->
          thisHeight = $(@).height()
          if thisHeight > tallest
            tallest = thisHeight
        group.height(tallest)
      else
        group.css("height", "auto")
    return
equalHeight($ ".l-plan-equalHeight")