//
//  YYPanGestureModule.m
//  YYPanGestureDemo
//
//  Created by zhuangchubin on 2017/9/1.
//  Copyright © 2017年 zhuangchubin. All rights reserved.
//

#import "YYPanGestureModule.h"
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, YYPandGestureDirection) {
     YYPandGestureDirectionUp = 0,
    YYPandGestureDirectionLeft,
    YYPandGestureDirectionDown,
    YYPandGestureDirectionRight
};

typedef NS_ENUM(NSUInteger, YYPandScrollDirection) {
    YYPandScrollDirectionHorinizol = 1,
    YYPandScrollDirectionVertical
};

@interface YYPanGestureModule ()
@property (nonatomic, assign) UIView  *panView;
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) YYPandGestureDirection direction;
@property (nonatomic, assign) YYPandScrollDirection  lockScrollDirect;
@end

@implementation YYPanGestureModule

+(instancetype)addPanGestureInView:(UIView*)view{
    YYPanGestureModule *module  = [[YYPanGestureModule alloc]init];
    module.panView              = view;
    module.lockScrollDirect            = YYPandScrollDirectionHorinizol;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:module action:@selector(pandGesture:)];
    [view addGestureRecognizer:pan];
    return module;
}

-(void)pandGesture:(UIPanGestureRecognizer*)pan{
    CGPoint locationPoint  = [pan locationInView:self.panView];
    CGPoint translatePoint = [pan translationInView:self.panView];
    CGPoint volocityPoint  = [pan velocityInView:self.panView];
    self.direction = [self directVolocity:volocityPoint];
    NSLog(@"locationPoint ====%@  translatePoint %@ ====volocityPoint  %@ === %lu",NSStringFromCGPoint(locationPoint),NSStringFromCGPoint(translatePoint), NSStringFromCGPoint(volocityPoint), (unsigned long)self.direction);
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            NSLog(@"pan.state ==== %ld",(long)pan.state);
            
            break;
        case UIGestureRecognizerStateChanged:
            
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            NSLog(@"pan.state ==== %ld",(long)pan.state);
            break;
            
        default:
            break;
        
    }
    
}

- (YYPandGestureDirection)directVolocity:(CGPoint)point{
    if (self.lockScrollDirect == YYPandScrollDirectionHorinizol) {
        return point.x > 0 ? YYPandGestureDirectionRight : YYPandGestureDirectionLeft;
    }else{
        return point.y > 0 ? YYPandGestureDirectionDown  : YYPandGestureDirectionUp ;
    }
}

- (CGFloat)scrollSpace:(CGPoint)point{
    
    if (self.lockScrollDirect == YYPandScrollDirectionHorinizol) {
        
    }else{
        
    }
    return CGPointZero.x;
}

@end
