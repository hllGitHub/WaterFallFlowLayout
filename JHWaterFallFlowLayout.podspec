Pod::Spec.new do |s|
  s.name             = 'JHWaterFallFlowLayout'
  s.version          = '0.1.0'
  s.summary          = '瀑布流实现'

  s.description      = '这是一个简单的瀑布流实现方案，目前定制性较弱，如果有相关的需求可以提 issue 或者 pull request，或者邮件留言。'

  s.homepage         = 'https://github.com/hllGitHub/WaterFallFlowLayout'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liangliang.hu' => 'hllfj922@gmail.com' }
  s.source           = { :git => 'https://github.com/hllGitHub/WaterFallFlowLayout.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.swift_versions = ['4', '5']

  s.source_files = 'WaterFallFlowLayout/Classes/**/*'

end
