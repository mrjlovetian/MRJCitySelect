#
# Be sure to run `pod lib lint MRJCitySelect.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MRJCitySelect'
  s.version          = '0.1.3.1'
  s.summary          = '城市选择 MRJCitySelect.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/mrjlovetian/MRJCitySelect'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mrjlovetian@gmail.com' => 'mrjlovetian@gmail.com' }
  s.source           = { :git => 'https://github.com/mrjlovetian/MRJCitySelect.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'MRJCitySelect/Classes/**/*'
  
 s.resource_bundles = {
   'MRJCitySelect' => ['MRJCitySelect/Assets/*']
}

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'MRJTableView'
  s.dependency 'MJExtension'
  s.dependency 'MRJUIColorAdditions'
end
