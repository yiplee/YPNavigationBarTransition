bundler install
bundle exec pod install
xcodebuild analyze test -workspace YPNavigationBarTransition.xcworkspace -scheme YPNavigationBarTransition -sdk iphonesimulator -destination "OS=11.2,name=iPhone 8" -configuration Debug ONLY_ACTIVE_ARCH=NO CODE_SIGNING_REQUIRED=NO | bundle exec xcpretty -c