# YPNavigationBarTransition

<p align="left">
    <a href="https://travis-ci.org/yiplee/YPNavigationBarTransition">
        <img src="https://travis-ci.org/yiplee/YPNavigationBarTransition.svg?branch=master&style=flat"
             alt="Build Status">
    </a>
    <a href="https://cocoapods.org/pods/YPNavigationBarTransition">
        <img src="https://img.shields.io/cocoapods/v/YPNavigationBarTransition.svg?style=flat"
             alt="Pods Version">
    </a>
    <!-- <a href='https://coveralls.io/github/yiplee/YPNavigationBarTransition?branch=master'>
        <img src='https://coveralls.io/repos/github/yiplee/YPNavigationBarTransition/badge.svg?branch=master' alt='Coverage Status' />
    </a> -->
    <a href="https://github.com/Carthage/Carthage">
        <img src="https://img.shields.io/badge/Carthage-compatible-brightgreen.svg?style=flat"
             alt="Carthage Compatible">
    </a>
</p>

A Fully functional `UINavigationBar` framework for making bar transition more natural! You don't need to call any `UINavigationBar` api, implementing `YPNavigationBarConfigureStyle` protocol for your view controller instead.

类似微信 UINavigationBar 效果的切换方案，支持任意透明半透明图片背景等等不同样式的 UINavigationBar 的切换。

## features

- Transparent & translucent navigation bar  支持不透明、全透明和半透明的 navigation bar
- Pure color bar 支持设置 navigation bar 背景颜色
- Background image bar 支持设置 navigation bar 背景图片
- Update navigationBar style **dynamicly** 可以动态调整 navigation bar 样式
- Written in Objective-C with full Swift interop support

### 不同颜色和透明度的 bar 之间的切换

<p>
    <a href="https://www.youtube.com/watch?v=u8Y-pvqE9_4">
        <img src="https://raw.githubusercontent.com/yiplee/YPNavigationBarTransition/master/screenshots/gif-01.gif" width=300>
    </a>
</p>

### 图片背景的 navigation bar

<p>
    <a href="https://www.youtube.com/watch?v=u8Y-pvqE9_4">
        <img src="https://raw.githubusercontent.com/yiplee/YPNavigationBarTransition/master/screenshots/gif-02.gif" width=300>
    </a>
</p>

### 动态调整 navigation bar 样式

<p>
    <a href="https://www.youtube.com/watch?v=u8Y-pvqE9_4">
        <img src="https://raw.githubusercontent.com/yiplee/YPNavigationBarTransition/master/screenshots/gif-03.gif" width=300>
    </a>
</p>

## Requirements

- Xcode 9.0+
- iOS 8.0+

## Installation

### CocoaPods

The preferred installation method is with [CocoaPods](https://cocoapods.org). Add the following to your `Podfile`:

```ruby
# use_frameworks! is needed for swift projects
use_frameworks!
pod 'YPNavigationBarTransition', '~> 2.0'
```

### Carthage

For [Carthage](https://github.com/Carthage/Carthage), add the following to your `Cartfile`:

```ruby
github "yiplee/YPNavigationBarTransition" ~> 2.0
```

## Getting Started

### 1. Import Framework

```objc
// objc
#import <YPNavigationBarTransition/YPNavigationBarTransition.h>
```

```swift
// swift
import YPNavigationBarTransition
```

### 2. Replace UINavigationController with YPNavigationController

### 3. Implement Protocol YPNavigationBarConfigureStyle for YPNavigationController in Category

```objc
// objc (this will be your app's default navigationbar style)
@implementation YPNavigationController (Configure)

- (YPNavigationBarConfigurations) yp_navigtionBarConfiguration {
    return YPNavigationBarStyleBlack | YPNavigationBarBackgroundStyleTranslucent | YPNavigationBarBackgroundStyleNone;
}

- (UIColor *) yp_navigationBarTintColor {
    return [UIColor whiteColor];
}
```

```swift
// swift (this will be your app's default navigationbar style)
extension YPNavigationController : NavigationBarConfigureStyle {
    public func yp_navigtionBarConfiguration() -> YPNavigationBarConfigurations {
        return [.styleBlack]
    }

    public func yp_navigationBarTintColor() -> UIColor! {
        return UIColor.white
    }
}
```

- [example projects](https://github.com/yiplee/YPNavigationBarTransition/tree/master/Examples)
- [How To Use 中文](https://github.com/yiplee/YPNavigationBarTransition/blob/master/docs/how_to_use_CN.markdown)

## License

MIT. See the [LICENSE](LICENSE) file for details.

