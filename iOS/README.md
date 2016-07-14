# AirServiceKit

AirServiceKit SDK allows you to include the AirService ordering platform right within your own iOS application.

AirServiceKitViewController can be used directly, or subclassed, and is simple to integrate anywhere you would typically use a `UIViewController`.

##Usage

Simply import the AirServiceKit umbrella header to get started.

`#import <AirServiceKit/AirServiceKit.h>`

From there you just initialise an instance of the `AirServiceKitViewController` using your AirService credentials and you can start taking orders right away.

```objc
self.viewController = [[AirServiceKitViewController alloc] initWithClientID:@"22c7d3fc" clientSecret:@"aada245b93feb5d8e84dfeb49296da8b" collection:@"airservice-qa-sdk" delegate:self];
```

Full AirServiceKit documentation can be found at [/iOS/Docs](https://github.com/airservice/Open-API-and-SDKs/tree/master/iOS/Docs) 

##Examples

The [Examples](Examples) directory demonstrates many common scenarios for integrating AirServiceKit. These demo Xcode projects include basic manual setups, cocoapods integration, modal presentation and supporting PayPal payments.

##PayPal Payments

Supporting PayPal payments inside AirServiceKit also requires the [ASPayPalPayments library](https://github.com/airservice/Open-API-and-SDKs).

You must supply an instance of `ASPayPalPayments` to `AirServiceKit`

```objc
self.viewController.acceptPayPalPayments = YES;
self.viewController.payPalPaymentsClient = [[ASPayPalPayments alloc] init];
```

For more information see the [documentation](https://github.com/airservice/Open-API-and-SDKs/tree/master/iOS/Docs) 

##Installation

###Cocoapods

AirService recommends using [CocoaPods](http://cocoapods.org). To install, simply add the following line to your Podfile:
`pod 'AirServiceKit', :git => 'https://github.com/airservice/Open-API-and-SDKs.git'`

To also support PayPal payments inside AirServiceKit you must also add the following line to your Podfile:
`pod 'ASPayPalPayments', :git => 'https://github.com/airservice/Open-API-and-SDKs.git'`

Run `pod install` from the command line and open the `.xcworkspace` file generated by CocoaPods.

###Manual

- To manually install AirServiceKit in your Xcode project, download the latest release of `AirServiceKit.framework`. 
- Go to your Xcode project’s “General” settings. Drag `AirServiceKit.framework` to the `Embedded Binaries` section.
- If you experience problems with unknown headers go to your target's `Build Settings` and add the parent path to `AirServiceKit.framework` in the `Framework Search Paths` section.

##Author

www.github.com/airservice

www.airservice.com