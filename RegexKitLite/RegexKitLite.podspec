Pod::Spec.new do |s|
  s.name = 'RegexKitLite'
  s.version = '1.0.0'
  s.platform = :ios
  s.ios.deployment_target = '6.0'
  s.source_files = '**/*.{h,m}'
  s.requires_arc = false
  s.libraries = 'icucore'
end
