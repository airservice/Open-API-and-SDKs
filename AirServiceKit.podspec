Pod::Spec.new do |s|
  s.name = 'AirServiceKit'
  s.version = '2.0.453'
  s.summary = 'AirServiceKit'
  s.description = 'AirServiceKit SDK allows you to include AirService in your own application'
  s.license = 'COMMERCIAL'
  s.authors = {"Daniel Bowden"=>"github@bowden.in"}
  s.homepage = 'http://www.airservice.com'
  s.platform = :ios, '8.0'
  s.ios.deployment_target = '8.0'
  s.requires_arc = true
  s.source = { :git => 'git@github.com:airservice/Open-API-and-SDKs.git' :branch =>  'fix/sdk' } #:tag => "sdk.#{s.version.to_s}" }
  s.ios.deployment_target    = '8.0'
  s.ios.vendored_framework   = 'iOS/AirServiceKit.framework'
end
