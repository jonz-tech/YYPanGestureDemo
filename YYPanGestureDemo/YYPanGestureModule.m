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
@property (nonatomic, strong) UIView  *panView, *moveView;
@property (nonatomic, assign) CGPoint lastPoint;
@property (nonatomic, assign) YYPandGestureDirection direction;
@property (nonatomic, assign) YYPandScrollDirection  lockScrollDirect;
@property (nonatomic, assign) UIGestureRecognizerState gestureState;

@end

@implementation YYPanGestureModule

+(instancetype)addPanGestureInView:(UIView*)view{
    YYPanGestureModule *module  = [[YYPanGestureModule alloc]init];
    module.panView              = view;
    module.lockScrollDirect            = YYPandScrollDirectionHorinizol;
    [module.panView addSubview:module.moveView];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:module action:@selector(pandGesture:)];
    [view addGestureRecognizer:pan];
    return module;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (UIView *)moveView{
    if (_moveView == nil) {
        _moveView = [[UIView alloc]initWithFrame:self.panView.bounds];
        _moveView.backgroundColor = [UIColor greenColor];
        _moveView.alpha = 0.6;
    }
    return _moveView;
}

-(void)pandGesture:(UIPanGestureRecognizer*)pan{
    CGPoint locationPoint  = [pan locationInView:self.panView];
    CGPoint translatePoint = [pan translationInView:self.panView];
    CGPoint volocityPoint  = [pan velocityInView:self.panView];
    self.direction         = [self directVolocity:volocityPoint];
    self.gestureState      = pan.state;
    NSLog(@"locationPoint ====%@  translatePoint %@ ====volocityPoint  %@ === %lu",NSStringFromCGPoint(locationPoint),NSStringFromCGPoint(translatePoint), NSStringFromCGPoint(volocityPoint), (unsigned long)self.direction);
    [self scrollSpace:volocityPoint];
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            NSLog(@"pan.state ==== %ld",(long)pan.state);
            
            break;
        case UIGestureRecognizerStateChanged:
            [self movingAnimation:translatePoint];
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            NSLog(@"pan.state ==== %ld",(long)pan.state);
            [self moveAnimation:[self moveFramePoint:locationPoint]];
            break;
        default:
            break;
    }
}


- (CGRect)moveFramePoint:(CGPoint)locationPoint{
    CGSize size = self.panView.frame.size;
    if (self.lockScrollDirect == YYPandScrollDirectionHorinizol) {
        CGFloat x =  self.direction == YYPandGestureDirectionLeft ?
                     (locationPoint.x < size.width/2 ? 0 : size.width) :
                     (locationPoint.x > size.width/2 ? size.width : 0 ) ;
        return CGRectMake(x, 0, size.width, size.height);
    }else{
        CGFloat y =  self.direction == YYPandGestureDirectionUp ?
        (locationPoint.y < size.height/5 ? 0 : size.height) :
        (locationPoint.y > size.height/2 ? size.height : 0 ) ;
        return CGRectMake(0, y, size.width, size.height);
    }
}

- (void)moveAnimation:(CGRect)frame{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.moveView.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)movingAnimation:(CGPoint)transtPoint{
    CGRect  frame = self.moveView.frame;
    if (self.lockScrollDirect == YYPandScrollDirectionHorinizol) {
       CGFloat offset = (self.direction == YYPandGestureDirectionRight) ? transtPoint.x :transtPoint.x;
        frame = CGRectMake(offset, frame.origin.y, frame.size.width, frame.size.height);
    }else{
        CGFloat offset = (self.direction == YYPandGestureDirectionUp) ? -transtPoint.y : transtPoint.y;
        frame = CGRectMake(0, frame.origin.y + offset, frame.size.width, frame.size.height);
    }
    self.moveView.frame = frame;
    self.lastPoint = transtPoint;
}

- (YYPandGestureDirection)directVolocity:(CGPoint)point{
    if (self.lockScrollDirect == YYPandScrollDirectionHorinizol) {
        return point.x > 0 ? YYPandGestureDirectionRight : YYPandGestureDirectionLeft;
    }else{
        return point.y > 0 ? YYPandGestureDirectionDown  : YYPandGestureDirectionUp ;
    }
}



- (CGFloat)scrollSpace:(CGPoint)point{
    CGFloat detalsA  = 0.0f;
    if (self.lockScrollDirect == YYPandScrollDirectionHorinizol) {
        detalsA = (point.x - self.lastPoint.x)/1;
        
    }else{
        detalsA = (point.y - self.lastPoint.y)/1;
    }
    NSLog(@"deltas XXXxXXXXXXX ===== %lf ====== XXXXXXX",detalsA);
    
    return self.lockScrollDirect == YYPandScrollDirectionHorinizol ? CGPointZero.x : CGPointZero.y;
}

@end
