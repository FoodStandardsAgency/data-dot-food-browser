import '../src/cookie.js'
import '../src/feedback.js'
import '../src/help.js'
import '../src/live_check.js'
import {} from 'jquery-ujs'

import 'babel-polyfill'
import 'mutationobserver-shim'
import 'wicg-inert'
import 'custom-event-polyfill'

import '../../../node_modules/fsastyles/helper/polyfill/classList'
import '../../../node_modules/fsastyles/helper/polyfill/closest'
import '../../../node_modules/fsastyles/helper/polyfill/matches'
import '../../../node_modules/fsastyles/helper/polyfill/pointerEvents'
import svg4everybody from 'svg4everybody'
import responsiveTables from '../../../node_modules/fsastyles/helper/responsiveTables'
import stickyElement from '../../../node_modules/fsastyles/helper/stickyElement'
// import cssCustomPropertySupport from './helper/cssCustomPropertySupport'

// TODO Work out why this doesn't work if called on line 37 as in the pattern library
// Require application style
require('../stylesheets/style.css')

const { navigation } = require('../../../node_modules/fsastyles/component/navigation/navigation')
const { addHeading } = require('../../../node_modules/fsastyles/component/content/content')
const { toggle } = require('../../../node_modules/fsastyles/component/toggle/toggle')
const { peek } = require('../../../node_modules/fsastyles/component/peek/peek')
const { fhrs } = require('../../../node_modules/fsastyles/component/fhrs/fhrs')
const { toc } = require('../../../node_modules/fsastyles/component/toc/toc')
const { changeAriaRoleOnToggle, autoOpenFormError, scrollToMultiStepForm } = require('../../../node_modules/fsastyles/component/form/form')
const { autoOpenFirstSearchFilter } = require('../../../node_modules/fsastyles/component/search/search')

const { toggleSidebarDocumentMenu } = require('../../../node_modules/fsastyles/component/document-menu-side-bar/document-menu-side-bar')

// Require every image asset inside of img folder
require.context('../../../node_modules/fsastyles/img/', true, /\.(gif|png|svg|jpe?g)$/)

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
