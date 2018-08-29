//
//  YPDemoConfigureViewController.m
//  YPNavigationBarTransition-Example
//
//  Created by Guoyin Lee on 25/12/2017.
//  Copyright © 2017 yiplee. All rights reserved.
//

#import "YPDemoConfigureViewController.h"
#import "YPDemoContainerViewController.h"
#import "YPGradientDemoViewController.h"

#import "YPDemoSwitchCell.h"
#import "UIImage+YPConfigure.h"

#import <YPNavigationBarTransition/YPNavigationBarTransition.h>

@interface YPDemoConfigureViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong, readwrite) UITableView *tableView;

@end

@implementation YPDemoConfigureViewController {
    BOOL _barHidden;
    BOOL _transparent;
    BOOL _translucent;
    UIBarStyle _barStyle;
    
    NSArray<NSDictionary *> *_colors;
    NSArray<NSString *> *_imageNames;
}

- (void) loadView {
    [super loadView];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                              style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.view = _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_tableView registerClass:[YPDemoSwitchCell class] forCellReuseIdentifier:@"switch"];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"action"];
    
    _translucent = NO;
    _barStyle = UIBarStyleBlack;
    
    _colors = @[
      @{@"None" : [NSNull null]},
      @{@"Black" : [UIColor blackColor]},
      @{@"White" : [UIColor whiteColor]},
      @{@"TableView Background Color" : _tableView.backgroundColor},
      @{@"Red" : [UIColor redColor]}
      ];
    
    _imageNames = @[@"green",
                    @"blue",
                    @"purple",
                    @"red",
                    @"yellow"];
}

- (void) showNextViewControllerWithColor:(UIColor *)color {
    YPDemoContainerViewController *controller = [YPDemoContainerViewController new];
    controller.title = @"Color";
    
    YPNavigationBarConfigurations conf = YPNavigationBarShowShadowImage;
    if (_barHidden) {
        conf |= YPNavigationBarHidden;
    }
    
    if (_transparent) {
        conf |= YPNavigationBarBackgroundStyleTransparent;
    } else if (!_translucent) {
        conf |= YPNavigationBarBackgroundStyleOpaque;
    }
    
    if (_barStyle == UIBarStyleBlack) {
        conf |= YPNavigationBarStyleBlack;
    }
    
    if (color) conf |= YPNavigationBarBackgroundStyleColor;
    
    controller.configurations = conf;
    controller.backgroundColor = color;
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void) showNextViewControllerWithBackgroundImageName:(NSString *)imageName {
    YPDemoContainerViewController *controller = [YPDemoContainerViewController new];
    controller.title = imageName;
    
    YPNavigationBarConfigurations conf = YPNavigationBarConfigurationsDefault;
    if (_barHidden) {
        conf |= YPNavigationBarHidden;
    }
    
    if (_transparent) {
        conf |= YPNavigationBarBackgroundStyleTransparent;
    } else if (!_translucent) {
        conf |= YPNavigationBarBackgroundStyleOpaque;
    }
    
    if (_barStyle == UIBarStyleBlack) {
        conf |= YPNavigationBarStyleBlack;
    }
    
    conf |= YPNavigationBarBackgroundStyleImage;
    
    controller.configurations = conf;
    controller.backgroundImage = [[UIImage imageNamed:imageName] resizableImageWithCapInsets:UIEdgeInsetsZero
                                                                                resizingMode:UIImageResizingModeStretch];
    controller.backgroundImageName = imageName;
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void) switchValueChanged:(UISwitch *)sender {
    NSInteger const tag = sender.tag;
    if (tag == 0) {
        _barHidden = sender.isOn;
    } else if (tag == 1) {
        _transparent = sender.isOn;
        
        if (_transparent && _barStyle != UIBarStyleDefault) {
            // 为了更好的 demo 展示效果
            // bar 全透明之后把 barStyle 设置成 UIBarStyleDefault
            _barStyle = UIBarStyleDefault;
            
            NSIndexPath *barStyleIndexPath = [NSIndexPath indexPathForRow:3 inSection:0];
            YPDemoSwitchCell *cell = [_tableView cellForRowAtIndexPath:barStyleIndexPath];
            [cell.switcher setOn:NO animated:YES];
        }
    } else if (tag == 2) {
        _translucent = sender.isOn;
    } else {
        _barStyle = sender.isOn ? UIBarStyleBlack : UIBarStyleDefault;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return 4;
    else if (section == 1) return _colors.count;
    else if (section == 2) return _imageNames.count;
    else if (section == 3) return 1;
    else return 0;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger const section = indexPath.section;
    NSInteger const row     = indexPath.row;
    
    if (section == 0) {
        YPDemoSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"switch"
                                                                 forIndexPath:indexPath];
        NSString *title = nil;
        BOOL isOn = NO;
        
        if (row == 0) {
            title = @"Hidden";
            isOn = _barHidden;
        } else if (row == 1) {
            title = @"Transparent";
            isOn = _transparent;
        } else if (row == 2) {
            title = @"Translucent";
            isOn = _translucent;
        } else {
            title = @"Black Bar Style";
            isOn = _barStyle == UIBarStyleBlack;
        }
        
        cell.textLabel.text = title;
        cell.switcher.on = isOn;
        
        cell.switcher.tag = row;
        [cell.switcher addTarget:self
                          action:@selector(switchValueChanged:)
                forControlEvents:UIControlEventValueChanged];
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"action"
                                                                forIndexPath:indexPath];
        UIImage *image = nil;
        NSString *title = nil;
        
        if (section == 1) { // colors
            NSDictionary *color = _colors[row];
            title = color.allKeys.firstObject;
            id c = color.allValues.firstObject;
            if (c == [NSNull null]) {
                c = [UIColor clearColor];
            }
            
            image = [UIImage yp_imageWithColor:c size:CGSizeMake(32, 32)];
        } else if (section == 2) { // images
            title = _imageNames[row];
            image = [UIImage imageNamed:title];
        } else if (section == 3) {
            title = @"Dynamic Gradient Bar";
        }
        
        cell.imageView.image = image;
        cell.textLabel.text = title;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) return @"Next Controller Bar Style";
    else if (section == 1) return @"Colors";
    else if (section == 2) return @"Images";
    else return nil;
}

- (NSString *) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return
        @"bar style 会影响状态栏的样式\n"
        "bar style 是 UIBarStyleBlack 的时候状态栏为白色\n"
        "bar style 是 UIBarStyleDefault 的时候状态栏为黑色";
    } else if (section == 1) {
        return @"选择偏白的颜色的时候，关闭 Black Bar Style 展示效果更好";
    } else if (section == 2) {
        return @"选择图片为背景的时候建议关掉半透明效果";
    } else if (section == 3) {
        return @"style 根据页面滑动距离动态改变";
    }
    
    return nil;
}

#pragma mark - UITableViewDelegate

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger const section = indexPath.section;
    NSInteger const row     = indexPath.row;
    
    if (section == 1) {
        id color = _colors[row].allValues.firstObject;
        if (color == [NSNull null]) color = nil;
        [self showNextViewControllerWithColor:color];
    } else if (section == 2) {
        NSString *imageName = _imageNames[row];
        [self showNextViewControllerWithBackgroundImageName:imageName];
    } else if (section == 3) {
        YPGradientDemoViewController *demo = [YPGradientDemoViewController new];
        [self.navigationController pushViewController:demo animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
