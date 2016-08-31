Pod::Spec.new do |s|

  s.name         = "TTBannerView"
  s.version      = "0.0.1"
  s.summary      = "一个简单的滚动广告栏，图片来源可以选择本地或者网络，可以添加标题和分页控件"
  s.homepage     = "https://github.com/whtacm/TTBannerView"
  s.license      = "MIT"
  s.author             = { "whtacm" => "whtacm@gmail.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/whtacm/TTBannerView.git", :tag => s.version }
  s.source_files = "TTBannerView/TTBannerView.{h,m}"
  s.requires_arc = true
  s.dependency    "SDWebImage"
end