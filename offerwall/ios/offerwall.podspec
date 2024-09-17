#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint offerwall.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'offerwall'
  s.version          = '0.0.2'
  s.summary          = 'Flutter plugin for integrating the Revlum Offerwall SDK.'
  s.description      = <<-DESC
Flutter plugin that allows developers to easily configure and launch an offerwall on Android and iOS, enabling users to earn rewards through engaging offers.
                       DESC
  s.homepage         = 'https://revlum.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Revlum' => 'hello@revlum.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  # Download and extract the hosted XCFramework from GitHub
  s.prepare_command = <<-CMD
    curl -L -o RevlumOfferwallSDK.xcframework.zip https://github.com/revlum/ios/releases/download/v1.0.0/RevlumOfferwallSDK.xcframework.zip
    unzip -o RevlumOfferwallSDK.xcframework.zip -d Frameworks/
  CMD

  # Link the XCFramework
  s.vendored_frameworks = 'Frameworks/RevlumOfferwallSDK.xcframework'

  # If your plugin requires a privacy manifest, for example if it uses any
  # required reason APIs, update the PrivacyInfo.xcprivacy file to describe your
  # plugin's privacy impact, and then uncomment this line. For more information,
  # see https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
  # s.resource_bundles = {'offerwall_privacy' => ['Resources/PrivacyInfo.xcprivacy']}
end
