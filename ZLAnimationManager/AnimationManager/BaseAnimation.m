//
//  BaseAnimation.m
//  SSAnimation
//
//  Created by 束 永兴 on 13-7-24.
//  Copyright (c) 2013年 Candy. All rights reserved.
//

#import "BaseAnimation.h"
#import <QuartzCore/QuartzCore.h>

@implementation BaseAnimation

+ (CABasicAnimation *)ssRotateDuration:(CFTimeInterval)duration
                           repeatCount:(float)count
                        timingFunction:(NSString *)timingFunc
                             clockwise:(BOOL)isClock
{
    int direction = isClock ? 1 : -1;
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = @((2*M_PI) *direction);
    rotationAnimation.repeatCount = count;
    rotationAnimation.duration = duration / count;                              
    if (timingFunc) {
        rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:timingFunc];
    }
    return rotationAnimation;
}

+ (CABasicAnimation *)ssRotateDurationRepeatForeverWithSpeed:(float)speed
                                              timingFunction:(NSString *)timingFunc
                                                   clockWise:(BOOL)isClock
{
    int direction = isClock ? 1 : -1;
    CABasicAnimation *rotateForever = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateForever.toValue = @((2*M_PI * direction));
    rotateForever.repeatCount = HUGE_VALF;
    rotateForever.speed = speed;
    if (timingFunc) {
        rotateForever.timingFunction = [CAMediaTimingFunction functionWithName:timingFunc];
    }
    return rotateForever;
}

+ (CABasicAnimation *)ssRotateToDegree:(float)degree duration:(CFTimeInterval)duration
{
    CABasicAnimation *angleAnimate = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    angleAnimate.toValue = @(degree *M_PI / 180);
    angleAnimate.duration = duration;
    
    return angleAnimate;
}

+ (void)ssRotateLayer:(CALayer *)layer
         rotateDegree:(float)degree
             duration:(CFTimeInterval)duration
{
    CABasicAnimation *angleAnimate = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    float oldDegree = [[layer valueForKeyPath:@"transform.rotation"] floatValue];
    angleAnimate.toValue = @(degree *M_PI / 180 + oldDegree);
    angleAnimate.duration = duration;
    
    [layer addAnimation:angleAnimate forKey:@"rotateDegreeAnimation"];
    
    double delayInSeconds = duration-0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [layer setValue:@((degree *M_PI / 180)+oldDegree) forKeyPath:@"transform.rotation"];
    });
}

+ (CABasicAnimation *)ssScaleDuration:(CFTimeInterval)duration
                                scale:(CGFloat)scale
                       timingFunction:(NSString *)timingFunc
{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    NSNumber *scaleFactor = @(scale);
    scaleAnimation.toValue = scaleFactor;
    scaleAnimation.duration = duration;
    if (timingFunc) {
        scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:timingFunc];
    }
    return scaleAnimation;
}

+ (void)ssScaleLayer:(CALayer *)layer
            duration:(CFTimeInterval)duration
               scale:(CGFloat)scale
      timingFunction:(NSString *)timingFunc
{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    NSNumber *scaleFactor = @(scale);
    scaleAnimation.toValue = scaleFactor;
    scaleAnimation.duration = duration;
    if (timingFunc) {
        scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:timingFunc];
    }
    [layer addAnimation:scaleAnimation forKey:@"transformAnimation"];
    
    double delayInSeconds = duration;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [layer setValue:scaleFactor forKeyPath:@"transform.scale"];
    });
}

+ (void)ssScaleLayer:(CALayer *)layer
            duration:(CFTimeInterval)duration
               scale:(CGFloat)scale
      timingFunction:(NSString *)timingFunc
            complete:(void (^)())block
{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    NSNumber *scaleFactor = @(scale);
    scaleAnimation.toValue = scaleFactor;
    scaleAnimation.duration = duration;
    if (timingFunc) {
        scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:timingFunc];
    }
    [layer addAnimation:scaleAnimation forKey:@"transformAnimation"];
    
    double delayInSeconds = duration;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        block();
    });
}

+ (CAKeyframeAnimation *)ssMoveFromPoint:(CGPoint)fp
                                 toPoint:(CGPoint)tp
                                duration:(CFTimeInterval)duration
{
    CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnimation.duration = duration;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, fp.x, fp.y);
    CGPathAddLineToPoint(path, NULL, tp.x, tp.y);
    moveAnimation.path = path;
    CGPathRelease(path);
    moveAnimation.fillMode = kCAFillModeForwards;
    return moveAnimation;
}

//path 只能靠你聪明的大脑去设计了
+ (CAKeyframeAnimation *)ssMoveFromPoint:(CGPoint)fp
                                 toPoint:(CGPoint)tp
                                    path:(UIBezierPath *)path
                                duration:(CFTimeInterval)duration
{
    CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnimation.path = path.CGPath;
    moveAnimation.duration = duration;
    moveAnimation.rotationMode = kCAAnimationRotateAuto;
    moveAnimation.fillMode = kCAFillModeForwards;
    return moveAnimation;
}

+ (CABasicAnimation *)ssHeartBeatScale:(float)scale perduring:(CFTimeInterval)during
{
    CABasicAnimation *heartBeatAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    heartBeatAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    heartBeatAnimation.autoreverses = YES;
    heartBeatAnimation.duration = during;
    heartBeatAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    heartBeatAnimation.repeatCount = HUGE_VALF;
    return heartBeatAnimation;
}

+ (CABasicAnimation *)ssHeartBeatLayer:(CALayer *)layer
                                 scale:(float)scale
                             perduring:(CFTimeInterval)during
{
    layer.transform = CATransform3DMakeScale(scale, scale, 1);
    CABasicAnimation *heartBeatAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    heartBeatAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    heartBeatAnimation.autoreverses = YES;
    heartBeatAnimation.duration = during;
    heartBeatAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    heartBeatAnimation.repeatCount = HUGE_VALF;
    return heartBeatAnimation;
}

+ (CABasicAnimation *)ssOpacityDuration:(CFTimeInterval)duration
{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    anim.duration = duration;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return anim;
}

+ (CABasicAnimation *)ssBackgroundColor
{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    return anim;
}

+ (CABasicAnimation *)ssStrokeColor
{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
    return anim;
}

+ (void)flipViewsFrontView:(UIView *)fv backView:(UIView *)bv duration:(CFTimeInterval)duration
{
    UIViewAnimationOptions option = UIViewAnimationOptionTransitionFlipFromLeft;
    [UIView transitionFromView:fv
                        toView:bv
                      duration:duration
                       options:option
                    completion:^(BOOL finished) {
    
                    }];
}


@end
