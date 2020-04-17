(function () {
  'use strict'

  var cookie = function (name, value, options) {
    if (typeof value !== 'undefined') {
      if (value === false || value === null) {
        return setCookie(name, '', { days: -1 })
      } else {
        return setCookie(name, value, options)
      }
    } else {
      return getCookie(name)
    }
  }

  var setCookie = function (name, value, options) {
    options = options || {}

    var cookieString = name + '=' + value + '; path=/'
    if (options.days) {
      var date = new Date()
      date.setTime(date.getTime() + options.days * 24 * 60 * 60 * 1000)
      cookieString = cookieString + '; expires=' + date.toGMTString()
    }
    if (document.location.protocol === 'https:') {
      cookieString = cookieString + '; Secure'
    }
    document.cookie = cookieString
  }

  var getCookie = function (name) {
    var nameEQ = name + '='
    var cookies = document.cookie.split(';')
    for (var i = 0, len = cookies.length; i < len; i++) {
      var cookie = cookies[i]
      while (cookie.charAt(0) === ' ') {
        cookie = cookie.substring(1, cookie.length)
      }
      if (cookie.indexOf(nameEQ) === 0) {
        return decodeURIComponent(cookie.substring(nameEQ.length))
      }
    }
    return null
  }

  var clickToAcceptCookieMessage = function () {
    var button = document.querySelector('.cc_btn_accept_all')
    button.addEventListener('click', function () {
      var message = document.getElementById('global-cookie-message')
      message.style.display = 'none'
    })
  }

  var addCookieMessage = function () {
    var message = document.getElementById('global-cookie-message')
    var hasCookieMessage = message && cookie('seen_cookie_message') === null

    if (hasCookieMessage) {
      message.style.display = 'block'
      cookie('seen_cookie_message', 'yes', { days: 28 })
    }
  }

  /** Necessary in case Modernizr is not present */
  var addJavaScriptAvailable = function () {
    var root = document.documentElement
    var cls = root.className
    root.className = cls ? cls + ' js' : 'js'
  }

  var isIE = function () {
    return !(
      !document.attachEvent || typeof document.attachEvent === 'undefined'
    )
  }

  var domReady = function (callback) {
    if (isIE()) {
      document.attachEvent('onreadystatechange', function () {
        if (document.readyState === 'complete') {
          return callback()
        }
      })
    } else {
      document.addEventListener('DOMContentLoaded', function () {
        return callback()
      })
    }
  }

  // show the cookie message when the document is ready
  domReady(function () {
    addJavaScriptAvailable()
    addCookieMessage()
    clickToAcceptCookieMessage()
  })
}.call(window))
