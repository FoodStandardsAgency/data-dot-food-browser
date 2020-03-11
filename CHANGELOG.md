# data-dot-food catalog browser change history

## 0.2.0 - 2020-03-11

- Fix for GH-42, in which we isolate context-dependent config
  state, such as the hostname of the API to use, in environment
  variables to make it easier to configure the app in a docker
  container. In addition, the app will now error if the API
  host env var is not set.

## 2019-11-19

- Merges cairn-catalog-browser assets and functionality with the data-catalog-browser
- Installs webpacker and relevant dependencies for utilising fsastyles node package
- Updates Ruby version to 2.6.3
