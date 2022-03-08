Pod::Spec.new do |s|
  s.name             = 'JHWaterFallFlowLayout'
  s.version          = '0.1.0'
  s.summary          = 'A short description of JHWaterFallFlowLayout.'

  s.description      = "瀑布流实现"

  s.homepage         = 'https://github.com/hllGitHub/WaterFallFlowLayout'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liangliang.hu' => 'hllfj922@gmail.com' }
  s.source           = { :git => 'https://github.com/hllGitHub/WaterFallFlowLayout.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'JHWaterFallFlowLayout/Classes/**/*'

end
