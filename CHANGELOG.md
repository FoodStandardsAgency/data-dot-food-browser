# data-dot-food catalog browser change history

## In preparation

- (Ian) Rubygem and JS dependency updates
- (Ian) Change sort order for date-sort data elemnents (GH-112)

## 1.3.0 - 2021-02-22

- (Ian) change feedback email address to go direct to FSA
- (Ian) Rubygem and JS dependency updates

## 1.2.2 - 2020-09-17 (Bogdan)

- Added automatic lighthouse check for every commit/PR; this check
  should fail if accessibility is affected by the commit/PR

## 1.2.1 - 2020-09-16 (Ian)

- fix for GH-100, regression in remove-filter link

## 1.2.0 - 2020-09-16 (Ian)

- Update minor release to mark that this is the WCAG compliance release,
  September 2020
- added link to client-supplied accessibility statement

## 1.1.18 - 2020-09-10 (Ian)

- Updated JS and Ruby dependencies to resolve reported CVE vulnerabilities

## 1.1.17 - 2020-09-09 (Ian)

- Change autocomplete attribute to `email` to resolve warning from Silktide

## 1.1.16 - 2020-09-09 (Ian)

- Added `main` landmark to 404 page, to resolve warnings from Axe and Silktide

## 1.1.15 - 2020-09-97 (Ian)

- Various WCAG fixes on the feedback form
- Removed question on user-research participation from feedback form
- Added a lighthouse target to the scripts in `package.json`

## 1.1.14 - 2020-09-07 (Ian)

- Fix for GH-96 (skip to main content not working on feedback form)
- temporarily using a forked version of `fsastyles` due to Webpack issues

## 1.1.13 - 2020-08-27 (Bogdan)

- Fixed focus reset issue when clicking "more years..."

## 1.1.12 - 2020-08-26 (Bogdan)

- added automated testing via github actions;
  the API url for the tests is set to staging

## 1.1.11 - 2020-08-26 (Bogdan)

- changed Sentry configuration so it will only report errors in production

## 1.1.10 - 2020-08-20 (Bogdan)

- added landmarks that are unique and include the whole website's content

## 1.1.9 - 2020-08-20 (Bogdan)

- added "skip to main content" link at the top left of the page

## 1.1.8 - 2020-08-17 (Bogdan)

- Kaminari (the pagination library) was using bold tags to show the datasets numbers;
  this bold tags have now been replaced with strong tags to fix WCAG error

## 1.1.7 - 2020-08-08 (Bogdan)

- Fix colour contrast issue on the hero region (white text on technically a white background);
  visually this was not present, but detected by accessibility tools as a CSS issue
- Remove residual uses of inline styles

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
