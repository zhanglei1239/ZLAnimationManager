    //
//  SSAction.m
//  SSAnimation
//
//  Created by vienta on 13-12-25.
//  Copyright (c) 2013年 Candy. All rights reserved.
//

#import "SSAction.h"


@implementation CAAnimation (times)

@dynamic times;

@end

@implementation SSAction

- (id)init
{
    if ((self = [CAAnimation animation])) {
        
    }
    return self;
}

@end


@implementation SSMove

+ (id)actionWithDuration:(CFTimeInterval)duration from:(CGPoint)fp to:(CGPoint)tp block:(void (^)(void))block
{
    return [[self alloc] initWithDuration:duration from:fp to:tp block:block];
}

- (id)initWithDuration:(CFTimeInterval)duration from:(CGPoint)fp to:(CGPoint)tp block:(void (^)(void))block
{
    if (self = [super init]) {
        CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        moveAnimation.duration = duration;
        moveAnimation.beginTime = CACurrentMediaTime();
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, fp.x, fp.y);
        CGPathAddLineToPoint(path, NULL, tp.x, tp.y);
        moveAnimation.path = path;
        moveAnimation.fillMode = kCAFillModeForwards;
        moveAnimation.removedOnCompletion = NO;
        CGPathRelease(path);
        double delayInSeconds = duration;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if (block) {
                block();
            }
        });
        self = (id)moveAnimation;
        
        
    }
    return self;
}

+ (id)actionWithDuration:(CFTimeInterval)duration path:(CGPathRef)path block:(void(^)(void))block
{
    return [[self alloc] initWithDuration:duration path:path block:block];
}

- (id)initWithDuration:(CFTimeInterval)duration path:(CGPathRef)path block:(void(^)(void))block
{
    if (self = [super init]) {
        CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        moveAnimation.duration= duration;
        moveAnimation.beginTime = CACurrentMediaTime();
        moveAnimation.path = path;
        moveAnimation.fillMode = kCAFillModeForwards;
        moveAnimation.removedOnCompletion = NO;
        double delayInSeconds = duration;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if (block) {
                block();
            }
        });
        self = (id)moveAnimation;
    }
    return self;
}

@end


@implementation SSRotate

+ (id)actionWithDuration:(CFTimeInterval)duration degree:(float)degree clockwise:(BOOL)isClock keyPath:(NSString *)path block:(void (^)(void))block
{
    return [[self alloc] initWithDuration:duration degree:degree clockwise:isClock keyPath:path block:block];
}

- (id)initWithDuration:(CFTimeInterval)duration degree:(float)degree clockwise:(BOOL)isClock keyPath:(NSString *)path block:(void (^)(void))block
{
    if (self = [super init]) {
        CABasicAnimation *angleAnimation;
        if ([path isEqualToString:@"transform.rotation.z"]) {
            angleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            int direction = isClock ? 1 : -1;
            angleAnimation.toValue = @((2*M_PI) *direction);
            angleAnimation.beginTime = CACurrentMediaTime();
            angleAnimation.repeatCount = 1;
            angleAnimation.duration = duration;
        }else{
            angleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
            angleAnimation.toValue = @(degree * M_PI / 180);
            angleAnimation.repeatCount = 1;
            angleAnimation.duration = duration;
            angleAnimation.beginTime = CACurrentMediaTime();
            angleAnimation.fillMode = kCAFillModeForwards;
            angleAnimation.removedOnCompletion = NO;
        }
        double delayInSeconds = duration;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if (block) {
                block();
            }
        });
        self = (id)angleAnimation;
    }
    
    return self;
}

@end

@implementation SSScale

+ (id)actionWithDuration:(CFTimeInterval)duration scale:(float)s block:(void (^)(void))block
{
    return [[self alloc] initWithDuration:duration scale:s block:block];
}

- (id)initWithDuration:(CFTimeInterval)duration scale:(float)s block:(void (^)(void))block
{
    if (self = [super init]) {
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.toValue = @(s);
        scaleAnimation.duration = duration;
        scaleAnimation.beginTime = CACurrentMediaTime();
        scaleAnimation.fillMode = kCAFillModeBoth;
        scaleAnimation.removedOnCompletion = NO;
        double delayInSeconds = duration;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if (block) {
                block();
            }
        });
        self = (id)scaleAnimation;
    }
    return self;
}

+ (id)actionWithDuration:(CFTimeInterval)duration scaleX:(float)sx block:(void (^)(void))block
{
    return [[self alloc] initWithDuration:duration scaleX:sx block:block];
}

- (id)initWithDuration:(CFTimeInterval)duration scaleX:(float)sx block:(void (^)(void))block
{
    if (self = [super init]) {
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
        scaleAnimation.toValue = @(sx);
        scaleAnimation.duration = duration;
        scaleAnimation.beginTime = CACurrentMediaTime();
        scaleAnimation.fillMode = kCAFillModeBoth;
        scaleAnimation.removedOnCompletion = NO;
        double delayInSeconds = duration;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if (block) {
                block();
            }
        });
        self = (id)scaleAnimation;
    }
    
    return self;
}

+ (id)actionWithDuration:(CFTimeInterval)duration scaleY:(float)sy block:(void (^)(void))block
{
    return [[self alloc] initWithDuration:duration scaleY:sy block:block];
}

- (id)initWithDuration:(CFTimeInterval)duration scaleY:(float)sy block:(void (^)(void))block
{
    if (self = [super init]) {
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
        scaleAnimation.toValue = @(sy);
        scaleAnimation.duration = duration;
        scaleAnimation.beginTime = CACurrentMediaTime();
        scaleAnimation.fillMode = kCAFillModeBoth;
        scaleAnimation.removedOnCompletion = NO;
        double delayInSeconds = duration;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if (block) {
                block();
            }
        });
        self = (id)scaleAnimation;
    }
    return self;
}

@end

@implementation SSFade

+ (id)actionDuration:(CFTimeInterval)duration fopacity:(float)fop topacity:(float)top block:(void (^)(void))block
{
    return [[self alloc] initWithDuration:duration fopacity:fop topacity:top block:block];
}

- (id)initWithDuration:(CFTimeInterval)duration fopacity:(float)fop topacity:(float)top block:(void (^)(void))block
{
    if (self = [super init]) {
        CABasicAnimation *fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        fadeAnimation.fromValue = @(fop);
        fadeAnimation.toValue = @(top);
        fadeAnimation.duration = duration;
        fadeAnimation.beginTime = CACurrentMediaTime();
        fadeAnimation.fillMode = kCAFillModeBoth;
        fadeAnimation.removedOnCompletion = NO;
        double delayInSeconds = duration;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if (block) {
                block();
            }
        });
        self = (id)fadeAnimation;
    }
    return self;
}

@end

@implementation SSFadeIn

+ (id)actionWithDuration:(CFTimeInterval)duration block:(void (^)(void))block
{
    return [[self alloc] initWithDuration:duration block:block];
}

- (id)initWithDuration:(CFTimeInterval)duration block:(void (^)(void))block
{
    if (self = [super init]) {
        CABasicAnimation *fadeInAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        fadeInAnimation.toValue = @1.0;
        fadeInAnimation.beginTime = CACurrentMediaTime();
        fadeInAnimation.duration = duration;
        fadeInAnimation.fillMode = kCAFillModeBoth;
        fadeInAnimation.removedOnCompletion = NO;
        double delayInSeconds = duration;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if (block) {
                block();
            }
        });
        self = (id)fadeInAnimation;
    }
    return self;
}

@end

@implementation SSFadeOut

+ (id)actionWithDuration:(CFTimeInterval)duration block:(void (^)(void))block
{
    return [[self alloc] initWithDuration:duration block:block];
}

- (id)initWithDuration:(CFTimeInterval)duration block:(void (^)(void))block
{
    if (self = [super init]) {
        CABasicAnimation *fadeOutAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        fadeOutAnimation.toValue = @.0;
        fadeOutAnimation.beginTime = CACurrentMediaTime();
        fadeOutAnimation.duration = duration;
        fadeOutAnimation.fillMode = kCAFillModeBoth;
        fadeOutAnimation.removedOnCompletion = NO;
        double delayInSeconds = duration;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if (block) {
                block();
            }
        });
        self = (id)fadeOutAnimation;
    }
    return self;
}

@end


@implementation SSDelayTime

+ (id)actionWithDuration:(CFTimeInterval)duration block:(void (^)(void))block
{
    return [[self alloc] initWithDuration:duration block:block];
}

- (id)initWithDuration:(CFTimeInterval)duration block:(void (^)(void))block
{
    if (self = [super init]) {
        CABasicAnimation *delayAnimation = [CABasicAnimation animation];
        delayAnimation.beginTime = CACurrentMediaTime();
        delayAnimation.duration = duration;
        double delayInSeconds = duration;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if (block) {
                block();
            }
        });
        self = (id)delayAnimation;
    }
    return self;
}

@end


@implementation SSSequence

+ (id)actionsWithBlock:(void (^)(void))block action:(SSAction *)action1, ...
{
    NSMutableArray *actions = [NSMutableArray arrayWithCapacity:0];
    CFTimeInterval totalDuration = 0;
    
    SSAction *eachaction;
    va_list params;
    if (action1) {
        action1.beginTime = action1.beginTime - CACurrentMediaTime();
        action1.fillMode = kCAFillModeForwards;
        action1.removedOnCompletion = NO;
        totalDuration = action1.duration + action1.beginTime;
        [actions addObject:action1];
        
        va_start(params,action1);
        
        while ((eachaction = va_arg(params, id))) {
            eachaction.beginTime = totalDuration + eachaction.beginTime - CACurrentMediaTime();
            eachaction.fillMode = kCAFillModeForwards;
            eachaction.removedOnCompletion = NO;
            [actions addObject:eachaction];
            totalDuration = totalDuration + eachaction.duration;
        }
        
        va_end(params);
    }
    
    return [[self alloc] initWithDuration:totalDuration actions:actions block:block];
}
+ (id)actionWithArray:(NSArray *)arrayOfActions block:(void (^)(void))block
{
    NSMutableArray *actions = [NSMutableArray arrayWithCapacity:0];
    CFTimeInterval totolDuration = 0;
    
    for (int idx = 0; idx < [arrayOfActions count]; idx++) {
        SSAction *eachaction = (SSAction *)arrayOfActions[idx];
        eachaction.beginTime -= CACurrentMediaTime();
        eachaction.fillMode = kCAFillModeBackwards;
        eachaction.removedOnCompletion = NO;
        [actions addObject:eachaction];
        totolDuration += eachaction.duration + eachaction.beginTime;
    }
    
    return [[self alloc] initWithDuration:totolDuration actions:actions block:block];
}

- (id)initWithDuration:(CFTimeInterval)duration actions:(NSMutableArray *)actions block:(void (^)(void))block
{
    if (self = [super init]) {
        CAAnimationGroup *actionGroup = [CAAnimationGroup animation];
        [actionGroup setDuration:duration];
        [actionGroup setAnimations:actions];
        actionGroup.fillMode = kCAFillModeForwards;
        actionGroup.removedOnCompletion = NO;
        double delayInSeconds = duration;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if (block) {
                block();
            }
        });

        self = (id)actionGroup;
    }
    return self;
}

@end


@implementation SSSpawn


+ (id)actions:(SSAction *)action1, ...
{
    NSMutableArray *actions = [NSMutableArray arrayWithCapacity:0];
    CFTimeInterval maxDuration = 0;
    SSAction *eachaction;
    
    va_list params;
    if (action1) {
        action1.beginTime = action1.beginTime - CACurrentMediaTime();
        action1.fillMode = kCAFillModeForwards;
        action1.removedOnCompletion = NO;
        maxDuration = action1.duration + action1.beginTime;
        [actions addObject:action1];
        
        va_start(params, action1);
        
        while ((eachaction = va_arg(params, id))) {
            eachaction.beginTime = eachaction.beginTime - CACurrentMediaTime();
            eachaction.fillMode = kCAFillModeForwards;
            eachaction.removedOnCompletion = NO;
            [actions addObject:eachaction];
            if (eachaction.duration >= maxDuration) {
                maxDuration = eachaction.duration;
            }
        }
        
        va_end(params);
    }
    
    return [[self alloc] initWithDuration:maxDuration actions:actions];
}

- (id)initWithDuration:(CFTimeInterval)duration actions:(NSMutableArray *)actions
{
    if (self = [super init]) {
        CAAnimationGroup *actionGroup = [CAAnimationGroup animation];
        [actionGroup setDuration:duration];
        [actionGroup setAnimations:actions];
        actionGroup.fillMode = kCAFillModeForwards;
        actionGroup.removedOnCompletion = NO;
        self = (id)actionGroup;
    }
    return self;
}

+ (id)actionWithArray:(NSArray *)arrayOfActions
{
    NSMutableArray *actions = [NSMutableArray arrayWithCapacity:0];
    CFTimeInterval maxDuration = 0;
    for (int idx = 0; idx < [arrayOfActions count]; idx++) {
        SSAction *eachAction = arrayOfActions[idx];
        eachAction.beginTime -= CACurrentMediaTime();
        if (eachAction.duration > maxDuration) {
            maxDuration = eachAction.duration;
        }
        eachAction.fillMode = kCAFillModeForwards;
        eachAction.removedOnCompletion = NO;
        [actions addObject:eachAction];
    }
    
    return [[self alloc] initWithDuration:maxDuration actions:actions];
}


@end

@implementation SSRepeat

+ (id)actionWithAction:(SSAction *)action times:(NSUInteger)times block:(void (^)(void))block
{
    return [[self alloc] initWithAction:action times:times block:(void (^)(void))block];
}


- (id)initWithAction:(SSAction *)action times:(NSUInteger)times block:(void (^)(void))block
{
    if (self = [super init]) {
        self = (id)action;
        self.times = times;
        action.repeatCount = times;
        double delayInSeconds = action.duration*times;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if (block) {
                block();
            }
        });
    }
    return self;
}

@end


