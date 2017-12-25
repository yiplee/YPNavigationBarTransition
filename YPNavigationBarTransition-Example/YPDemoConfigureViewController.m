//
//  YPDemoConfigureViewController.m
//  YPNavigationBarTransition-Example
//
//  Created by Guoyin Lee on 25/12/2017.
//  Copyright © 2017 yiplee. All rights reserved.
//

#import "YPDemoConfigureViewController.h"
#import "YPDemoContainerViewController.h"
#import "YPDemoSwitchCell.h"
#import "UIImage+color.h"
#import "UIImage+YPConfigure.h"

@import YPNavigationBarTransition;

@interface YPDemoConfigureViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YPDemoConfigureViewController {
    BOOL _barHidden;
    BOOL _transparent;
    BOOL _translucent;
    UIBarStyle _barStyle;
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
    
    _translucent = YES;
    _barStyle = UIBarStyleBlack;
}

- (void) showNextViewControllerWithColor:(UIColor *)color {
    YPDemoContainerViewController *controller = [YPDemoContainerViewController new];
    controller.title = @"Color";
    
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
    
    conf |= YPNavigationBarBackgroundStyleColor;
    
    controller.configurations = conf;
    controller.backgroundColor = color;
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void) switchValueChanged:(UISwitch *)sender {
    NSInteger const tag = sender.tag;
    if (tag == 0) {
        _barHidden = sender.isOn;
    } else if (tag == 1) {
        _transparent = sender.isOn;
    } else if (tag == 2) {
        _translucent = sender.isOn;
    } else {
        _barStyle = sender.isOn ? UIBarStyleBlack : UIBarStyleDefault;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return 4;
    else if (section == 1) return 1;
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
            title = @"hidden";
            isOn = _barHidden;
        } else if (row == 1) {
            title = @"transparent";
            isOn = _transparent;
        } else if (row == 2) {
            title = @"translucent";
            isOn = _translucent;
        } else {
            title = @"black bar style";
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
            title = @"black";
            image = [UIImage yp_imageWithColor:[UIColor blackColor] size:CGSizeMake(28, 28)];
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
    else return nil;
}

#pragma mark - UITableViewDelegate

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger const section = indexPath.section;
    NSInteger const row     = indexPath.row;
    
    if (section == 1) {
        if (row == 0) {
            [self showNextViewControllerWithColor:[UIColor blackColor]];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
