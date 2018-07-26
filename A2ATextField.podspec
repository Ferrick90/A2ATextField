#
# Be sure to run `pod lib lint A2ATextField.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'A2ATextField'
  s.version          = '0.1.0'
  s.summary          = 'A2ATextField class to float the Placeholder and validate the text while editing.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A2ATextField is subclass of UITextfield class that float the Placeholder and validate the text while editing.
                       DESC

  s.homepage         = 'https://github.com/Ferrick90/A2ATextField'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ferrick90' => 'ferrick1990@hotmail.com' }
  s.source           = { :git => 'https://github.com/Ferrick90/A2ATextField.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'A2ATextField/Classes/**/*'
  
  # s.resource_bundles = {
  #   'A2ATextField' => ['A2ATextField/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
