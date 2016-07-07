Pod::Spec.new do |s|
  
  s.name = 'AirServiceKit'
  s.version = '2.0.454'
  s.summary = 'AirServiceKit'
  s.description = 'AirServiceKit SDK allows you to include AirService in your own application'
  s.license = { :type => 'COMMERCIAL', :text => 'http://www.airservice.com/contact/' }
  s.authors = { "Daniel Bowden"=>"github@bowden.in" }
  s.homepage = 'http://www.airservice.com'
  s.platform = :ios, '8.0'
  s.ios.deployment_target = '8.0'
  s.requires_arc = true
  s.source = { :git => 'https://github.com/airservice/Open-API-and-SDKs.git', :branch => "feature/paypal-payments", :tag => "ios-sdk.#{s.version.to_s}" }
  s.default_subspec = 'Core'

  s.subspec 'Core' do |core|
    core.ios.vendored_framework = 'iOS/AirServiceKit.framework'
  end

  s.subspec 'PayPal-Payments' do |paypalpayments|
    paypalpayments.source_files = 'iOS/PayPal-Payments/*.{h,m}'
    paypalpayments.dependency 'AirServiceKit/Core'
    paypalpayments.dependency 'Braintree/PayPal'
  end

end
