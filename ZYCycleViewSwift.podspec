
Pod::Spec.new do |spec|

  spec.name         = "ZYCycleViewSwift"
  spec.version      = "0.0.1"
  spec.summary      = "ZYCycleViewSwift轮播图"

  spec.description  = <<-DESC
                    swift版轮播图
                   DESC

  spec.homepage     = "https://github.com/ios-zhouyu"
  spec.screenshots  = "https://avatars3.githubusercontent.com/u/19289675?s=460&v=4"
  spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  spec.author             = { "zhouyu" => "ioszhouyu@163.com" }
  spec.social_media_url   = "https://blog.csdn.net/kuangdacaikuang"

  spec.platform     = :ios, "8.0"
  spec.source       = { :git => "https://github.com/ios-zhouyu/ZYCycleViewSwift.git", :tag => "#{spec.version}" }

  spec.source_files  = "saasSwift/Classes/Home/CycleView/*.{swift}"
  spec.public_header_files = "ZYCycleViewSwift/*.swift"
  spec.ios.deployment_target = '8.0'

  # spec.framework  = "SomeFramework"
  # spec.frameworks = "SomeFramework", "AnotherFramework"

  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"

  spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # spec.dependency "JSONKit", "~> 1.4"

end
