fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

## Choose your installation method:

<table width="100%" >
<tr>
<th width="33%"><a href="http://brew.sh">Homebrew</a></td>
<th width="33%">Installer Script</td>
<th width="33%">Rubygems</td>
</tr>
<tr>
<td width="33%" align="center">macOS</td>
<td width="33%" align="center">macOS</td>
<td width="33%" align="center">macOS or Linux with Ruby 2.0.0 or above</td>
</tr>
<tr>
<td width="33%"><code>brew cask install fastlane</code></td>
<td width="33%"><a href="https://download.fastlane.tools">Download the zip file</a>. Then double click on the <code>install</code> script (or run it in a terminal window).</td>
<td width="33%"><code>sudo gem install fastlane -NV</code></td>
</tr>
</table>

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
### ios update_examples
```
fastlane ios update_examples
```
Updates the AirServiceKit and ASPayPalPayments pods in the example projects

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
