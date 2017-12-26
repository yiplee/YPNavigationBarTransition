Pod::Spec.new do |s|


  s.name         = "YPNavigationBarTransition"
  s.version      = "1.0.0"
  s.summary      = "A full functions Library make navigation bar transition as you like."

  s.description  = <<-DESC
                   A full functions Library make navigation bar transition as you like.
                   DESC                   

  s.homepage     = "https://github.com/yiplee/YPNavigationBarTransition"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "yiplee" => "guoyinl@gmail.com" }
  s.social_media_url   = "http://twitter.com/yipleeyin"

  # s.platform     = :ios
  s.platform     = :ios, "8.0"

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  s.source       = { :git => "git@github.com:yiplee/YPNavigationBarTransition.git", :tag => s.version.to_s}

  s.source_files  = "YPNavigationBarTransition/**/*.{h,m}"
  s.private_header_files = "YPNavigationBarTransition/internal/*.h"

  s.frameworks = "UIKit" ,"Foundation"
  s.requires_arc = true

end