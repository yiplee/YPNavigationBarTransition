## 怎么使用 YPNavigationBarTransition ##

YPNavigationBarTransition 依靠接管 UINavigationController 的 delegate 来实现自动管理 navigationBar 的切换。
对于每一个对 navigationBar 的样式有自定义需求的 viewController，可以通过实现 ```YPNavigationBarConfigureStyle``` 协议来实现。
每次 navigationController push 或者 pop viewController 的时候，YPNavigationBarTransition 通过对比当前 navigationBar 
的样式和目标 viewController 指定的样式来判断是否需要添加 fake bar （用 UIToolbar）来模拟 navigation bar 的切换。

### ```YPNavigationBarConfigureStyle``` 协议 ###

```objective-c
typedef NS_ENUM(NSUInteger, YPNavigationBarConfigurations) {
    /*
     *  是否隐藏 navigation bar，默认是 show。
     */
    YPNavigationBarShow   = 0,
    YPNavigationBarHidden = 1,
    
    /*
     *  YPNavigationBarStyleLight = UIbarStyleDefault
     *  YPNavigationBarStyleBlack = UIbarStyleBlack
     *
     *  bar style 会影响 status bar 的样式，为 black 的时候 status bar 是白色，light 的时候是黑色。
     *  当没有自定义 background color 和 background image 的时候，navigation bar 的颜色也由 bar style 决定
     *  另外如果没有提供有效的 tintColor，YPNavigationBarTransition 将根据 bar style 自动设置 tintColor
     */
    YPNavigationBarStyleLight = 0 << 4,  // UIbarStyleDefault
    YPNavigationBarStyleBlack = 1 << 4,  // UIbarStyleBlack
    
    /*
     *  translucent = 半透明，transparent = 全透明，opaque = 不透明
     */
    YPNavigationBarBackgroundStyleTranslucent = 0 << 8,
    YPNavigationBarBackgroundStyleOpaque      = 1 << 8,
    YPNavigationBarBackgroundStyleTransparent = 2 << 8,
    
    /*
     *  使用颜色或者图片来配置 navigation bar 的 background image
     */
    YPNavigationBarBackgroundStyleNone  = 0 << 16,
    YPNavigationBarBackgroundStyleColor = 1 << 16,
    YPNavigationBarBackgroundStyleImage = 2 << 16,
    
    YPNavigationBarConfigurationsDefault = 0,
};

- (YPNavigationBarConfigurations) yp_navigtionBarConfiguration;
```
**[required]** 返回 navigation bar 配置

```objective-c
- (UIColor *) yp_navigationBarTintColor;
```
**[required]** navigation bar tint color，影响 bar item 的颜色；
如果返回 nil，bar style 是 YPNavigationBarStyleBlack 的话，将使用白色作为 tintColor，
bar style 是 YPNavigationBarStyleLight 的话，将使用黑色作为 tintColor。

```objective-c
- (UIImage *) yp_navigationBackgroundImageWithIdentifier:(NSString **)identifier;
```
**[optional]** navigation bar background image,`identifier`作为 image 的 id 使用，同 id 的图片看作是同一张图片，在判断是否需要使用 fake bar 的时候需要用到。如果 bar configuration
使用了 YPNavigationBarBackgroundStyleImage，这个方法一定要实现。

```objective-c
- (UIColor *) yp_navigationBackgroundColor;
```
**[optional]** navigation bar background color。如果 bar configuration
使用了 YPNavigationBarBackgroundStyleColor，这个方法一定要实现。

### YPNavigationBarTransitionCenter ###

YPNavigationBarTransitionCenter 需要提供一个默认 configure style id<YPNavigationBarConfigureStyle> 来初始化，
它接管 navigationController 的 delegate，通过 navigationDelegate 转发 navigationController 的 delegate 消息。

### 最佳实践 ###

**默认 YPNavigationBarConfigureStyle 实现** 建议 subclass 一个 UINavigationController 并且实现 YPNavigationBarConfigureStyle 协议
来作为默认配置使用，并将 YPNavigationBarTransitionCenter 封装在里面。可以参考 Example 里面的 [YPNavigationController](https://github.com/yiplee/YPNavigationBarTransition/blob/1.0.4/YPNavigationBarTransition-Example/YPNavigationController.m)。

**NavigationItem Title** 建议使用一个 UILabel 作为 navigationItem 的 titleView 来展现页面 title，这样可以让页面完全自己控制 title 的颜色、
字体等等，并且还可以实现 subtitle。可以参考 Example 里面的 [YPNavigationTitleLabel](https://github.com/yiplee/YPNavigationBarTransition/blob/master/YPNavigationBarTransition-Example/YPNavigationTitleLabel.m)。

**ScrollView 跳动问题** 在转场过程中，navigationBar 的 translucent 属性可能发生了改变，
然后导致了 scrollView 的 frame 和 contentInset 发生改变，页面展示内容位置变化。如果遇到这种情况，建议设置对应 controller 的 extendedLayoutIncludesOpaqueBars （IB 里面的 under opaque bar） 为 YES，即可避开这个问题。 

### ⚠️ 注意 ###
- 不支持 iOS 11 新增的 navigationBar large title。
- 使用默认配置的页面，不用实现 YPNavigationBarConfigureStyle 协议。
