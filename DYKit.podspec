Pod::Spec.new do |s|

  s.name         = "DYKit"
  s.version      = "0.2.0"
  s.summary      = "DYKit easyUse UITableView block reactiveCocoa"
  s.description  = <<-DESC
  DYKit easyUse UITableView block reactiveCocoa reactiveObjC
                   DESC
  s.homepage     = "https://github.com/jyo2206208/DYKit"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "shaggon" => "715135546@qq.com" }
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/jyo2206208/DYKit.git", :tag => "#{s.version}" }
  s.source_files  = "DYKit/*.{h,m}"
  s.dependency "ReactiveObjC"

end
