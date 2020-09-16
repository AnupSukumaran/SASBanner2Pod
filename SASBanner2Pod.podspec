#
# Be sure to run `pod lib lint SASBanner2.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SASBanner2'
  s.version          = '1.0.6'
  s.summary          = 'SASBanner2 - new version of SASBanner.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
'Simple basic Horizontal Scrollable Banner View For Apps Development'
                       DESC

  s.homepage         = 'https://github.com/AnupSukumaran/SASBanner2Pod.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'AnupSukumaran' => 'anup.sukumaran9@gmail.com' }
  s.source           = { :git => 'https://github.com/AnupSukumaran/SASBanner2Pod.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'Source/**/*.swift'
  s.swift_version = '5.0'
  s.platforms = {
      "ios":"10.0"
  }
  s.resources = [ "Source/ScrollViewBlock.xib", "Source/ImageViewController.xib", "Source/PageSlideViewController.xib"]
  # s.resource_bundles = {
  #   'SASBanner2' => ['SASBanner2/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end