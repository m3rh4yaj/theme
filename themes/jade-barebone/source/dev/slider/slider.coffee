###
loading
###
loading = (parent) ->
  $(parent)
  .find ".layer-loading"
  .fadeOut("500")
  return

###
mainvisual (carouFredSel)
###
mainVisualPc = ->
  $ "#main-visual .slides"
  .carouFredSel
    width: "100%"
    height: "auto"
    auto: true
    items:
      width: 920
      visible: 3
      start: -1
    scroll:
      items: 1
      duration: 700
      timeoutDuration: 3000
    prev: "#main-visual-prev"
    next: "#main-visual-next"
    pagination:
      container: "#main-visual-pager"
      deviation: 1
    onCreate: loading("#main-visual")
  return

mainVisualSp = ->
  $ "#main-visual .slides"
  .carouFredSel
    responsive: true
    width: "100%"
    height: "auto"
    items:
      width: 768
      visible: 1
      start: 6
    scroll:
      duration: 700
      timeoutDuration: 3000
    auto: true
    onCreate: loading("#main-visual")
  return

mainVisual = ->
  $ window
  .on "load resize", ->
    w = $(window).width()
    mqTablet = 768
    if w <= mqTablet
      mainVisualSp()
      return
    else
      mainVisualPc()
      return
mainVisual()

###
carousel (carouFredSel)
###
carouselPlay = ->
  $ "#carousel .slides"
  .carouFredSel
    width: "100%"
    circular: true,
    items:
      start: -1
      visible: "odd+2"
    scroll:
      pauseOnHover: true
    auto:
      items: 1
      easing: "linear"
      duration: 6000
      timeoutDuration: 0
    onCreate: loading("#carousel")
  return

carousel = ->
  carouselPlay()
  timer = false
  $ window
  .on "resize", ->
    clearTimeout(timer)
  carouselPlay()
carousel()

###
movie slider (carouFredSel)
###
sliderPlayer = ->
  $ "#query-movie .slides"
  .carouFredSel
    responsive: true
    width: "100%"
    height: "variable",
    auto: false
    items:
      height: "variable"
      start: 0,
      visible: 1
    scroll:
      fx: "fade",
      items: 1,
      duration: 500
    prev: "#query-movie-prev"
    next: "#query-movie-next"
    pagination:
      container: "#query-movie-pager"
      deviation: 0
  return
sliderPlayer()