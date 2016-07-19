fastlane documentation
================
# Installation
```
sudo gem install fastlane
```
# Available Actions
## iOS
### ios deploy
```
fastlane ios deploy
```
Deploys a new release of AirServiceKit

Version will be taken from the the AirServiceKit.framework version unless specified

Optionally, provide a version using version_number:1.2.3
### ios documentation
```
fastlane ios documentation
```
Generates the latest AirServiceKit documentation at iOS/Docs
### ios publish_docs
```
fastlane ios publish_docs
```
Publishes the AirServiceKit docs to github pages

Accessible from http://airservice.github.io/Open-API-and-SDKs/iOS/Docs

----

This README.md is auto-generated and will be re-generated every time to run [fastlane](https://fastlane.tools).
More information about fastlane can be found on [https://fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [GitHub](https://github.com/fastlane/fastlane/tree/master/fastlane).