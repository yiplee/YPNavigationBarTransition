//
//  YPNavigationBarTransitionCenter.h
//  YPNavigationBarTransition
//
//  Created by Guoyin Lee on 24/12/2017.
//  Copyright © 2017 yiplee. All rights reserved.
//

#import "YPNavigationBarProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface YPNavigationBarTransitionCenter : NSObject

- (instancetype) init NS_UNAVAILABLE;
- (instancetype) initWithDefaultBarConfiguration:(id<YPNavigationBarConfigureStyle>)_default NS_DESIGNATED_INITIALIZER;

@property (nonatomic, weak, nullable) id<UINavigationControllerDelegate> navigationDelegate;
@property (nonatomic, weak, nullable) UINavigationController *navigationController;

@end

NS_ASSUME_NONNULL_END
