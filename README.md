ios_yelp
========

Yelp iOS App

This is an iOS application, which shows restaruant search result using Yelp APIs.

## Walkthrough of all user stories

[![image](https://raw.githubusercontent.com/wiki/stanleyhlng/ios_yelp/assets/ios_yelp.gif)](https://raw.githubusercontent.com/wiki/stanleyhlng/ios_yelp/assets/ios_yelp.gif)

## Completed user stories

  * Search results page
    * [x] Custom cells should have the proper Auto Layout constraints
    * [x] Search bar should be in the navigation bar (doesn't have to expand to show location like the real Yelp app does).
  * Filter page. Unfortunately, not all the filters are supported in the Yelp API.
    * [x] The filters you should actually have are: category, sort (best match, distance, highest rated), radius (meters), deals (on/off).
    * [x] The filters table should be organized into sections as in the mock.
    * [x] You can use the default UISwitch for on/off states. 
    * [x] Radius filter should expand as in the real Yelp app
    * [x] Categories should show a subset of the full list with a "See All" row to expand. Category list is here: http://www.yelp.com/developers/documentation/category_list
    * [x] Clicking on the "Search" button should dismiss the filters page and trigger the search w/ the new filter settings.

## Time spent
15 hours spent in total

## Libraries
```
platform :ios, '7.0'

pod 'AFNetworking', '~> 2.2'
pod 'GSProgressHUD', '~> 0.2'
pod 'Reveal-iOS-SDK', '~> 1.0.4'
pod 'SDWebImage', '~> 3.6'
pod 'UIActivityIndicator-for-SDWebImage', '~> 1.0.5'
pod 'AVHexColor', '~> 1.2.0'
```
