import '../src/cookie.js'
import '../src/feedback.js'
import '../src/help.js'
import '../src/live_check.js'
import {} from 'jquery-ujs'

import 'babel-polyfill'
import 'mutationobserver-shim'
import 'wicg-inert'
import 'custom-event-polyfill'

import 'fsastyles/helper/polyfill/classList'
import 'fsastyles/helper/polyfill/closest'
import 'fsastyles/helper/polyfill/matches'
import 'fsastyles/helper/polyfill/pointerEvents'
import svg4everybody from 'svg4everybody'
import responsiveTables from 'fsastyles/helper/responsiveTables'
import stickyElement from 'fsastyles/helper/stickyElement'
// import cssCustomPropertySupport from './helper/cssCustomPropertySupport'

// TODO Work out why this doesn't work if called on line 37 as in the pattern library
// Require application style
require('../stylesheets/style.css')

const { navigation } = require('fsastyles/component/navigation/navigation')
const { addHeading } = require('fsastyles/component/content/content')
const { toggle } = require('fsastyles/component/toggle/toggle')
const { peek } = require('fsastyles/component/peek/peek')
const { fhrs } = require('fsastyles/component/fhrs/fhrs')
const { toc } = require('fsastyles/component/toc/toc')
const { changeAriaRoleOnToggle, autoOpenFormError, scrollToMultiStepForm } = require('fsastyles/component/form/form')
const { autoOpenFirstSearchFilter } = require('fsastyles/component/search/search')

const { toggleSidebarDocumentMenu } = require('fsastyles/component/document-menu-side-bar/document-menu-side-bar')

// Require every image asset inside of img folder
require.context('fsastyles/img/', true, /\.(gif|png|svg|jpe?g)$/)

document.addEventListener('DOMContentLoaded', () => {
  // Polyfill svgs
  svg4everybody({ polyfill: true })

  // Add heading
  addHeading()

  // peek
  peek()

  // Navigation
  navigation()

  // Toggle content
  toggle()

  // FHRS
  fhrs()

  // Toc
  toc()

  // Responsive tables
  responsiveTables()

  // Forms
  changeAriaRoleOnToggle()
  autoOpenFormError()
  scrollToMultiStepForm()

  // Auto-open first search filter (on desktop only)
  autoOpenFirstSearchFilter()

  // Add the toggle to the document menu.
  toggleSidebarDocumentMenu()
})

// Sticky element
const container = [...document.querySelectorAll('.js-sticky-container')]
const stickyElem = [...document.querySelectorAll('.js-sticky-element')]
if (container != null || stickyElem != null) {
  stickyElement(container, stickyElem)
}

// Add class if touch device
document.addEventListener('touchstart', function addtouchclass (e) {
  document.documentElement.classList.add('is-touch')
  document.removeEventListener('touchstart', addtouchclass, false)
}, false)

// // Add class if css custom properties are supported
// if (cssCustomPropertySupport()) {
//   document.documentElement.classList.add('is-modern')
// }
