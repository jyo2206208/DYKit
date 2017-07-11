#
#  Be sure to run `pod spec lint DYKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "DYKit"
  s.version      = "0.0.2"
  s.summary      = "DYKit easyUse UITableView block reactiveCocoa"
  s.description  = <<-DESC
  DYKit provide some kinds of categories for UIkit list UItableView. You can Use id more eazy. 
                   DESC
  s.homepage     = "https://github.com/jyo2206208/DYKit"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "DuYe" => "715135546@qq.com" }
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/jyo2206208/DYKit.git", :tag => "#{s.version}" }
  s.source_files  = "DYKit/*.{h,m}"
  #s.frameworks = "UIKit"
  #s.requires_arc = true
  s.dependency "ReactiveObjC"

end
