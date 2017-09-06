//
//  YYPanGestureModule.m
//  YYPanGestureDemo
//
//  Created by zhuangchubin on 2017/9/1.
//  Copyright © 2017年 zhuangchubin. All rights reserved.
//

#import "YYPanGestureModule.h"
#import <Foundation/Foundation.h>
#import "YYPanGesture.h"



@interface YYPanGestureModule ()
@property (nonatomic, strong) UIView  *panView, *moveView;
@property (nonatomic, assign) CGPoint lastPoint;
@property (nonatomic, strong) YYPanGesture *gesture;
@property (nonatomic, assign) YYPandScrollDirection  lockScrollDirect;
@property (nonatomic, assign) UIGestureRecognizerState gestureState;
@property (nonatomic, assign) BOOL pagingEnabled;

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
//        UIScrollView 
    }
    return self;
}

- (void)setLockScrollDirect:(YYPandScrollDirection)direct{
    _lockScrollDirect = direct;
    self.gesture = [YYPanGesture panGestureBuilder:direct];
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
    [self.gesture panDirect:volocityPoint];
    
    NSLog(@"\n位置坐标: %@  \n滑动像素: %@  \n速度标量: %@  \n滑动方向: %@ \n滑动状态: %@ ",NSStringFromCGPoint(locationPoint),NSStringFromCGPoint(translatePoint), NSStringFromCGPoint(volocityPoint),[self.gesture directDescription],[self.gesture panState:pan.state] );

    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            break;
        case UIGestureRecognizerStateChanged:
            if (self.gestureState == UIGestureRecognizerStateBegan) {
                if (self.pagingEnabled) {
                    CGRect frame = [self.gesture moveBegin];
                    self.moveView.frame = frame;
                }
            }
            [self.gesture moving];
            break;
        case UIGestureRecognizerStateEnded:
            
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            if (self.pagingEnabled) {
                CGRect frame = [self.gesture moveEnd:translatePoint];
                [UIView animateWithDuration:0.3 animations:^{
                    self.moveView.frame = frame;
                }];
            }else{
                
            }
            break;
        default:
            break;
    }
    self.gestureState      = pan.state;
}

@end


