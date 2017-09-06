//
//  YYPanGesture.h
//  YYPanGestureDemo
//
//  Created by zhuangchubin on 2017/9/6.
//  Copyright © 2017年 zhuangchubin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, YYPandGestureDirection) {
    YYPandGestureDirectionDefault = 0,
    YYPandGestureDirectionUp ,
    YYPandGestureDirectionLeft,
    YYPandGestureDirectionDown,
    YYPandGestureDirectionRight
};

typedef NS_ENUM(NSUInteger, YYPandScrollDirection) {
    YYPandScrollDirectionDefault  = 0,
    YYPandScrollDirectionHorinizol,
    YYPandScrollDirectionVertical
};


@interface YYPanGesture : NSObject
@property  (nonatomic, assign) CGRect panBounds;
+ (instancetype)panGestureBuilder:(YYPandScrollDirection)scrollDirect;

@property (nonatomic, assign) YYPandGestureDirection direct;


- (void)panDirect:(CGPoint)volocityPoint;

- (CGRect)moveBegin;

- (void)moving;

- (CGRect)moveEnd:(CGPoint)translatPoint;

- (NSString *)directDescription;

- (NSString *)panState:(UIGestureRecognizerState)state;
@end


@interface YYPanGestureHorinizol : YYPanGesture

@end

@interface YYPanGestureVertical : YYPanGesture

@end

@interface YYPanGestureBoth : YYPanGesture

@end
