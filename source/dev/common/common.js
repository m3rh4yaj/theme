
/*
ユーザーエージェント判別(IE8~10,andoroid2x,ios)
 */
var equalHeight, modalPlan, nonScrollable, scrollAction, scrollable, smooth, socialCountApi, toTop, userAgentClass;

userAgentClass = function() {
  var appVersion, browser, userAgent, version;
  browser = null;
  userAgent = navigator.userAgent.toLowerCase();
  appVersion = window.navigator.appVersion.toLowerCase();
  if (userAgent.indexOf("msie") > -1) {
    if (appVersion.indexOf("msie 8.0") > -1) {
      browser = "ie8";
    } else if (appVersion.indexOf("msie 9.0") > -1) {
      browser = "ie9";
    } else if (appVersion.indexOf("msie 10.0") > -1) {
      browser = "ie10";
    }
  } else if (userAgent.indexOf("Android") > 0) {
    version = parseFloat(userAgent.slice(userAgent.indexOf("Android") + 8));
    if (version <= 6) {
      browser = "android2";
    }
  } else if (userAgent.indexOf("ipad") !== -1) {
    browser = "ios";
  } else if (userAgent.indexOf("iphone") !== -1) {
    browser = "ios";
  }
  if (browser) {
    return $("body").addClass(browser);
  }
};

userAgentClass();


/*
scroll
 */

scrollAction = function(target) {
  $('body,html').animate({
    scrollTop: target
  }, 500, 'easeInCirc');
  return false;
};

smooth = function() {
  $('.smooth').on('click', function() {
    var href, position;
    href = $(this).attr('href');
    position = $(href === "#" || href === "" ? "html" : href).offset().top - 50;
    return scrollAction(position);
  });
};

smooth();

nonScrollable = function() {
  $(window).on('touchmove.noScroll', function(e) {
    return e.preventDefault();
  });
};

scrollable = function() {
  return $(window).off('.noScroll');
};


/*
トップへ戻るボタン
 */

toTop = function() {
  var bottom, button, showFlag;
  showFlag = false;
  button = $('#totop');
  bottom = '30px';
  $(window).scroll(function() {
    if ($(this).scrollTop() > 250) {
      if (showFlag === false) {
        showFlag = true;
        button.stop().animate({
          "bottom": bottom
        }, 200, "easeInOutQuad");
      }
    } else {
      if (showFlag) {
        showFlag = false;
        button.stop().animate({
          "bottom": "-70px"
        }, 200, "easeInOutQuad");
      }
    }
  });
  button.on("click", function() {
    scrollAction(0);
    return false;
  });
};

toTop();


/*
modal
 */

modalPlan = function() {
  $("#plan-list .btn-modal a").on("click", function() {
    var content, modalPosition;
    content = $(this).attr("data-target");
    modalPosition = function() {
      var h, w, x, y;
      w = $(window).width();
      h = $(window).height();
      x = (w - $(content).outerWidth(true)) / 2;
      y = (h - $(content).outerHeight(true)) / 2;
      $(content).css({
        'left': x + 'px',
        'top': y + 'px'
      });
    };
    modalPosition();
    $("body").append("<div class='layer-overlay'></div>");
    $(".layer-overlay").css("display", "block");
    $(content).addClass("open");
    nonScrollable();
    $(".layer-overlay, .open").off().on("click", function() {
      $(content).removeClass("open");
      $(".layer-overlay").remove();
      scrollable();
    });
    $(window).on("resize", function() {
      return modalPosition();
    });
  });
};

modalPlan();


/*
SNS Count
 */

socialCountApi = function(url, element) {
  $.ajax({
    url: "https://graph.facebook.com/",
    dataType: "jsonp",
    data: {
      id: url
    },
    success: function(rss) {
      return $(".facebook-" + element).text(rss.shares || 0);
    },
    error: function() {
      return $(".facebook-" + element).text("0");
    }
  });
  RegExp("API廃止により、コメントアウト$.ajaxurl:\"http://urls.api.twitter.com/1/urls/count.json?url=\"+urldataType:\"jsonp\"data:url:urlsuccess:(res)->$\".twitter-" + element + "\".textres.count||0error:->$\".twitter-" + element + "\".text\"0\"");
  return $.ajax({
    url: "http://api.b.st-hatena.com/entry.count?callback=?",
    dataType: "jsonp",
    data: {
      url: url
    },
    success: function(res) {
      return $(".hatebu-" + element).text(res || 0);
    },
    error: function() {
      return $(".hatebu-" + element).text('0');
    }
  });
};


/*
equalHeight
 */

equalHeight = function(group) {
  $(window).on("load resize", function() {
    var mqTablet, tallest, w;
    w = $(window).width();
    mqTablet = 768;
    tallest = 0;
    if (mqTablet <= w) {
      group.each(function() {
        var thisHeight;
        thisHeight = $(this).height();
        if (thisHeight > tallest) {
          return tallest = thisHeight;
        }
      });
      return group.height(tallest);
    } else {
      return group.css("height", "auto");
    }
  });
};

equalHeight($(".l-plan-equalHeight"));
