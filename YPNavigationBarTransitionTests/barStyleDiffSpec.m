//
//  barStyleDiffSpec.m
//  YPNavigationBarTransition
//
//  Created by Guoyin Lee on 27/12/2017.
//  Copyright 2017 yiplee. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "YPNavigationBarTransitionCenterInternal.h"
#import "TranslucentBlackBarStyleObject.h"
#import "ColorNavigationBarStyleObject.h"

SPEC_BEGIN(barStyleDiffSpec)

describe(@"barStyleDiff", ^{
    let(translucentBlackStyle, ^id{
        TranslucentBlackBarStyleObject *object = [TranslucentBlackBarStyleObject new];
        return [[YPBarConfiguration alloc] initWithBarConfigurationOwner:object];
    });
    
    let(WhitColorBarStyle, ^id{
        ColorNavigationBarStyleObject *object = [ColorNavigationBarStyleObject new];
        object.backgroundColor = [UIColor whiteColor];
        return [[YPBarConfiguration alloc] initWithBarConfigurationOwner:object];
    });
    
    context(@"translucent black bar", ^{
        it(@"configure style should be", ^{
            YPBarConfiguration *conf = translucentBlackStyle;
            [[conf shouldNot] beNil];
            [[theValue(conf.hidden) should] beNo];
            [[theValue(conf.transparent) should] beNo];
            [[theValue(conf.translucent) should] beYes];
            [[theValue(conf.barStyle) should] equal:@(UIBarStyleBlack)];
            [[conf.tintColor should] equal:[UIColor whiteColor]];
            [[conf.backgroundColor should] beNil];
            [[conf.backgroundImage should] beNil];
        });
        
        it(@"should be visible & use system blur background", ^{
            YPBarConfiguration *conf = translucentBlackStyle;
            [[conf shouldNot] beNil];
            [[theValue(conf.isVisible) should] beYes];
            [[theValue(conf.useSystemBarBackground) should] beYes];
        });
    });
    
    context(@"color bar", ^{
        it(@"configure style should be", ^{
            YPBarConfiguration *conf = WhitColorBarStyle;
            [[conf shouldNot] beNil];
            [[theValue(conf.hidden) should] beNo];
            [[theValue(conf.transparent) should] beNo];
            [[theValue(conf.translucent) should] beYes];
            [[theValue(conf.barStyle) should] equal:@(UIBarStyleDefault)];
            [[conf.tintColor should] equal:[UIColor blackColor]];
            [[conf.backgroundColor should] beNonNil];
            [[conf.backgroundImage should] beNil];
        });
        
        it(@"should be visible & not use system blur background", ^{
            YPBarConfiguration *conf = WhitColorBarStyle;
            [[conf shouldNot] beNil];
            [[theValue(conf.isVisible) should] beYes];
            [[theValue(conf.useSystemBarBackground) shouldNot] beYes];
        });
    });
    
    context(@"diff bar style", ^{
        it(@"should use fake bar", ^{
            BOOL useFakeBar = YPTransitionNeedShowFakeBar(WhitColorBarStyle, translucentBlackStyle);
            [[theValue(useFakeBar) should] beYes];
        });
    });
});

SPEC_END
