//
//  YPNavigationControllerDelegateProxy.h
//  YPNavigationBarTransition
//
//  Created by Guoyin Lee on 2018/4/25.
//  Copyright © 2018 yiplee. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YPNavigationController;
@protocol UINavigationControllerDelegate;

@interface YPNavigationControllerDelegateProxy : NSProxy

- (instancetype) initWithNavigationTarget:(nullable id<UINavigationControllerDelegate>)navigationTarget
                              interceptor:(YPNavigationController *)interceptor;
- (instancetype) init NS_UNAVAILABLE;
+ (instancetype) new NS_UNAVAILABLE;

@end
