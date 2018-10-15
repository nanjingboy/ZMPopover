Pod::Spec.new do |s|
  s.name             = 'ZMPopover'
  s.version          = '0.1.0'
  s.summary          = 'Popover component for iOS with swift'
  s.homepage         = 'https://github.com/nanjingboy/ZMPopover'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Tom.Huang' => 'hzlhu.dargon@gmail.com' }
  s.source           = { :git => 'https://github.com/nanjingboy/ZMPopover.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.requires_arc = true
  s.source_files = "Source/*.swift"
end