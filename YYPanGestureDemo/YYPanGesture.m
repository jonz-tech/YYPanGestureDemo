//
//  YYPanGesture.m
//  YYPanGestureDemo
//
//  Created by zhuangchubin on 2017/9/6.
//  Copyright © 2017年 zhuangchubin. All rights reserved.
//

#import "YYPanGesture.h"

@implementation YYPanGesture

+ (instancetype)panGestureBuilder:(YYPandScrollDirection)scrollDirect{
    switch (scrollDirect) {
        case YYPandScrollDirectionDefault:
            return [YYPanGestureBoth new];
            break;
        case YYPandScrollDirectionHorinizol:
            return [YYPanGestureHorinizol new];
            break;
        case YYPandScrollDirectionVertical:
            return [YYPanGestureVertical new];
            break;
        default:
            break;
    }
    return nil;
}

- (void)panDirect:(CGPoint)volocityPoint{}

- (CGRect)moveBegin{return CGRectZero;}

- (void)moving{}

- (CGRect)moveEnd:(CGPoint)translatPoint{return CGRectZero;}

- (NSString *)directDescription{
    switch (self.direct) {
        case YYPandGestureDirectionLeft:
            return @"左";
            break;
        case YYPandGestureDirectionRight:
            return @"右";
            break;
        case YYPandGestureDirectionUp:
            return @"上";
            break;
        case YYPandGestureDirectionDown:
            return @"下";
            break;
        case YYPandGestureDirectionDefault:
            return @"默认";
            break;
        default:
            break;
    }
}

- (NSString *)panState:(UIGestureRecognizerState)state{
    switch (state) {
        case UIGestureRecognizerStatePossible:
            return @"未知";
            break;
        case UIGestureRecognizerStateBegan:
            return @"开始";
            break;
        case UIGestureRecognizerStateChanged:
            return @"滑动";
            break;
        case UIGestureRecognizerStateEnded:
            return @"结束";
            break;
        case UIGestureRecognizerStateCancelled:
            return @"取消";
            break;
        case UIGestureRecognizerStateFailed:
            return @"结束";
            break;
        default:
            break;
    }
}
@end



@implementation YYPanGestureHorinizol
-(void)panDirect:(CGPoint)volocityPoint{
    self.direct =  volocityPoint.x > 0 ? YYPandGestureDirectionRight : YYPandGestureDirectionLeft;
}
- (CGRect)moveBegin{
    if (self.direct == YYPandGestureDirectionLeft) {
        return CGRectMake(self.panBounds.size.width, self.panBounds.origin.y, self.panBounds.size.width, self.panBounds.size.height);
    }else{
        return CGRectMake(0, self.panBounds.origin.y, self.panBounds.size.width, self.panBounds.size.height);
    }
}

- (void)moving{
    if (self.direct == YYPandGestureDirectionLeft) {
        
    }else{
        
    }
}

- (CGRect)moveEnd:(CGPoint)translatPoint;{
    if (self.direct == YYPandGestureDirectionLeft) {
        CGFloat offset =  fabs(translatPoint.x) >= self.panBounds.size.width/2 ? -self.panBounds.size.width : 0 ;
        return CGRectMake(offset, self.panBounds.origin.y, self.panBounds.size.width, self.panBounds.size.height);
    }else{
        CGFloat offset =  fabs(translatPoint.x) >= self.panBounds.size.width/2 ? self.panBounds.size.width : 0 ;
        return CGRectMake(offset, self.panBounds.origin.y, self.panBounds.size.width, self.panBounds.size.height);
    }
    return CGRectZero;
}
@end

@implementation YYPanGestureVertical
-(void)panDirect:(CGPoint)volocityPoint{
    self.direct =  volocityPoint.y > 0 ? YYPandGestureDirectionDown  : YYPandGestureDirectionUp ;
}

- (CGRect)moveBegin{
    if (self.direct == YYPandGestureDirectionUp) {
        return CGRectMake(self.panBounds.origin.x, self.panBounds.size.height, self.panBounds.size.width, self.panBounds.size.height);
    }else{
        return CGRectMake(self.panBounds.origin.x, -self.panBounds.size.height, self.panBounds.size.width, self.panBounds.size.height);
    }
}

- (void)moving{
    if (self.direct == YYPandGestureDirectionLeft) {
        
    }else{
        
    }
}

- (CGRect)moveEnd:(CGPoint)translatPoint{
    if (self.direct == YYPandGestureDirectionLeft) {
        
    }else{
        
    }
    return CGRectZero;
}
@end

@implementation YYPanGestureBoth
-(void)panDirect:(CGPoint)volocityPoint{
    self.direct =  YYPandGestureDirectionDefault;
}
- (CGRect)moveBegin{
    
    return CGRectZero;
}

- (void)moving{
    if (self.direct == YYPandGestureDirectionLeft) {
        
    }else{
        
    }
}

- (CGRect)moveEnd:(CGPoint)translatPoint{
    if (self.direct == YYPandGestureDirectionLeft) {
        
    }else{
        
    }
    return CGRectZero;
}
@end
