Pod::Spec.new do |s|

	s.name = "ASApplePayPayments"
	s.version = "3.0.0"
	s.summary = "Authorising Apple Pay payments inside AirServiceKit"
	s.description = "Simplifies authorising Apple Pay Payments. Can be used in conjunction with AirServiceKit SDK or standalone"
	s.homepage = "http://www.airservice.com"
	s.license = { :type => 'COMMERCIAL', :text => 'http://www.airservice.com/contact/' }
	s.author = { "Daniel Bowden" => "github@bowden.in" }
  s.source = { :git => 'https://github.com/airservice/Open-API-and-SDKs.git', :tag => "ios-sdk.#{s.version.to_s}" }
	s.platform = :ios, '8.0'
	s.ios.deployment_target = '8.0'
	s.requires_arc = true
	s.frameworks = 'PassKit'
	s.source_files = 'iOS/ApplePay-Payments/*.{h,m}'
	s.dependency 'Braintree/Apple-Pay', '>=4.10.0'

end
