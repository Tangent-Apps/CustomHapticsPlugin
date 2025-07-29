Pod::Spec.new do |s|
  s.name             = 'tangent_custom_haptics'
  s.version          = '0.0.1'
  s.summary          = 'A Flutter plugin for advanced haptic feedback patterns on iOS using CoreHaptics.'
  s.description      = <<-DESC
A Flutter plugin for advanced haptic feedback patterns on iOS using CoreHaptics.
                       DESC
  s.homepage         = 'https://github.com/Tangent-Apps/CustomHapticsPlugin'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Tangent Apps' => 'ahmedbahgatnabih@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '13.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end