//
//  YPNavigationBarTransitionCenterInternal.h
//  YPNavigationBarTransition
//
//  Created by Guoyin Lee on 25/12/2017.
//  Copyright © 2017 yiplee. All rights reserved.
//

#import "YPNavigationBarTransitionCenter.h"
#import "YPNavigationBarTransitionCenterProxy.h"
#import "YPBarConfiguration.h"

BOOL YPTransitionNeedShowFakeBar(YPBarConfiguration *from,YPBarConfiguration *to);

@interface YPNavigationBarTransitionCenter ()
<
UINavigationControllerDelegate,
UIToolbarDelegate
>
{
    BOOL _isTransitionNavigationBar;
    __weak UINavigationController *_navigationController;
}

@property (nonatomic, strong) UIToolbar *fromViewControllerFakeBar;
@property (nonatomic, strong) UIToolbar *toViewControllerFakeBar;

@property (nonatomic, strong, readonly) YPBarConfiguration *defaultBarConfigure;
@property (nonatomic, strong, readonly) YPBarConfiguration *currentBarConfigure;

@property (nonatomic, strong) YPNavigationBarTransitionCenterProxy *delegateProxy;

@end
