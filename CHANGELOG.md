# data-dot-food catalog browser change history

## 1.0.1 - 2020-04-27
## 0.2.0 - 2020-03-11

- Fix for GH-42, in which we isolate context-dependent config
  state, such as the hostname of the API to use, in environment
  variables to make it easier to configure the app in a docker
  container. In addition, the app will now error if the API
  host env var is not set.

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
