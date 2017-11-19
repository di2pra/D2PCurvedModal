#
# Be sure to run `pod lib lint D2PCurvedModal.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'D2PCurvedModal'
  s.version          = '0.1.0'
  s.summary          = 'An elegant and curved modal View for iOS (Swift)'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
An elegant, animated and curved modal view for iOS iPhone made with love by DI2PRA.
                       DESC

  s.homepage         = 'https://github.com/di2pra/D2PCurvedModal'
  s.screenshots     = 'https://raw.githubusercontent.com/di2pra/D2PCurvedModal/master/image/screenshot_1.png', 'https://raw.githubusercontent.com/di2pra/D2PCurvedModal/master/image/screenshot_2.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'di2pra' => 'pas495@gmail.com' }
  s.source           = { :git => 'https://github.com/di2pra/D2PCurvedModal.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/di2pra'

  s.ios.deployment_target = '9.0'

  s.source_files = 'D2PCurvedModal/Classes/**/*'
  
  # s.resource_bundles = {
  #   'D2PCurvedModal' => ['D2PCurvedModal/Assets/*.png']
  # }

  s.resource = 'D2PCurvedModal/Assets/*.{xcassets}'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
