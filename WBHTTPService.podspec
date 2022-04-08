#
# Be sure to run `pod lib lint WBHTTPService.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WBHTTPService'
  s.version          = '0.0.1'
  s.summary          = 'HTTP请求封装'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  对Moya的二次封装
                       DESC

  s.homepage         = 'https://github.com/WBearJ/WBHTTPService'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'WBearJ' => 'karuasha@gmail.com' }
  s.source           = { :git => 'https://github.com/WBearJ/WBHTTPService.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.swift_versions = '5.2'
  s.ios.deployment_target = '12.0'

  s.source_files = 'WBHTTPService/Classes/**/*'
  
  # s.resource_bundles = {
  #   'WBHTTPService' => ['WBHTTPService/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'

  s.dependency 'RxSwift', '6.5.0'
  s.dependency 'RxCocoa', '6.5.0'
  s.dependency 'Moya/RxSwift', '~> 15.0'
  s.dependency 'HandyJSON', '~>5.0.2'
  
  
end
