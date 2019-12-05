//
//  YPNavigationControllerDelegateProxy.h
//  YPNavigationBarTransition
//
//  Created by Guoyin Lee on 2018/4/25.
//  Copyright © 2018 yiplee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class YPNavigationController;
@protocol UINavigationControllerDelegate;

@interface YPNavigationControllerDelegateProxy : NSProxy

- (instancetype) initWithNavigationTarget:(nullable id<UINavigationControllerDelegate>)navigationTarget
                              interceptor:(YPNavigationController *)interceptor;
- (instancetype) init NS_UNAVAILABLE;
+ (instancetype) new NS_UNAVAILABLE;

NS_ASSUME_NONNULL_END

@end
