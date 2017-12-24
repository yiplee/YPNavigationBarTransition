//
//  YPNavigationBarTransitionCenterProxy.h
//  YPNavigationBarTransition
//
//  Created by Guoyin Lee on 24/12/2017.
//  Copyright © 2017 yiplee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YPNavigationBarTransitionCenter;

NS_ASSUME_NONNULL_BEGIN

__attribute__((objc_subclassing_restricted))
@interface YPNavigationBarTransitionCenterProxy : NSProxy

- (instancetype) init NS_UNAVAILABLE;
+ (instancetype) new NS_UNAVAILABLE;

- (instancetype) initWithNavigationControllerDelegate:(nullable id<UINavigationControllerDelegate>)delegateTarget
                                          interceptor:(YPNavigationBarTransitionCenter *)interceptor;

@end

NS_ASSUME_NONNULL_END
