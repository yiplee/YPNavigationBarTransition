Pod::Spec.new do |s|


  s.name         = "YPNavigationBarTransition"
  s.version      = "2.2.3"
  s.summary      = "A Fully functional UINavigationBar framework for making bar transition more natural!"
  s.description  = "A Fully functional UINavigationBar framework for making bar transition more natural! You don't need to call any UINavigationBar api, implementing YPNavigationBarConfigureStyle protocol for your view controller instead."               

  s.homepage     = "http://github.com/yiplee/YPNavigationBarTransition"
  s.screenshots  = "https://raw.githubusercontent.com/yiplee/YPNavigationBarTransition/master/screenshots/gif-01.gif", "https://raw.githubusercontent.com/yiplee/YPNavigationBarTransition/master/screenshots/gif-02.gif"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "yiplee" => "guoyinl@gmail.com" }
  s.social_media_url   = "https://twitter.com/yipleeyin"

  # s.platform     = :ios
  s.platform     = :ios, "8.0"

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  s.source       = { :git => "https://github.com/yiplee/YPNavigationBarTransition.git", :tag => s.version.to_s}

  s.source_files  = "YPNavigationBarTransition/**/*.{h,m}"
  s.public_header_files = 'YPNavigationBarTransition/*.h'
  s.private_header_files = "YPNavigationBarTransition/internal/*.h"

  s.frameworks = "UIKit" ,"Foundation"
  s.requires_arc = true

end
