# data-dot-food catalog browser change history

## 1.1.7 - 2020-08-08 (Bogdan)

- Fix colour contrast issue on the hero region (white text on technically a white background);
  visually this was not present, but detected by accessibility tools as a CSS issue

## 1.1.6 - 2020-08-07 (Ian)

- added missing .rubocop.yml
- lots of fixes to resolve Rubocop warnings, most performed automatically

## 1.1.5 - 2020-08-07 (Bogdan)

- Fix for tab order issue, "more years..." link now sets the focus on the years
  area of the page instead of the results area

## 1.1.4 - 2020-07-31 (Ian)

- Fix for GH-82: Sentry error when HTTP Referer field is missing

## 1.1.3 - 2020-07-27

- Fix for GH-81: missing Sentry configuration on Rails application
- Fix for GH-80: change in configuration for `aws-sdk-rails`

## 1.1.2 - 2020-06-02

- Updated Gem dependecies to resolve various CVE warnings
- Added client-requested Google Search Console verification code

## 1.1.0 - 2020-03-11

- Fix for GH-42, in which we isolate context-dependent config
  state, such as the hostname of the API to use, in environment
  variables to make it easier to configure the app in a docker
  container. In addition, the app will now error if the API
  host env var is not set.

## 1.0.1 - 2020-04-27

## 2019-11-19

- Fixed GH-74: a regression in the `live-check` route used by
  the monitoring tools to check the health of the app

## 1.0.0 2020-04-17

### Major changes

- Changed the look and feel of the data catalog browser to match the current content
  of the Food Standards Agency's Pattern Library (FoodStandardsAgency/fsastyles).

## 0.1.0 2019-11-19

- Merged cairn-catalog-browser assets and functionality with the data-catalog-browser
- Installed webpacker and relevant dependencies for utilising fsastyles npm package
- Updated Ruby version to 2.6.3
