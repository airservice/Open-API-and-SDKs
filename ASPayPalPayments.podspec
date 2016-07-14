Pod::Spec.new do |s|

	s.name		= "ASPayPalPayments"
	s.version = "2.1.2"
	s.summary = "Authorising PayPal payments inside AirServiceKit"
	s.description = "Simplifies authorising PayPal Payments. Can be used in conjunction with AirServiceKit SDK or standalone"
	s.homepage = "http://www.airservice.com"
	s.license = "COMMERCIAL"
	s.author = { "Daniel Bowden" => "github@bowden.in" }
  s.source = { :git => 'https://github.com/airservice/Open-API-and-SDKs.git', :tag => "ios-sdk.#{s.version.to_s}" }
	s.platform = :ios, '8.0'
	s.ios.deployment_target = '8.0'
	s.requires_arc = true
	s.source_files = 'iOS/PayPal-Payments/*.{h,m}'
	s.dependency 'Braintree/PayPal'

end