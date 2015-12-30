//
//  AnimationManager.m
//  subviewTest
//
//  Created by vienta on 13-11-5.
//  Copyright (c) 2013年 Candy. All rights reserved.
//

#import "AnimationManager.h"
#import "BaseAnimation.h"
#import "SSActionManager.h"
#import "UIView+Action.h"
#import "AppDelegate.h"
#import "ZLUIImage.h"
@implementation AnimationManager

+ (AnimationManager *)sharedAnimationManager
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedAnimationManager = nil;
    dispatch_once(&pred,^{
        _sharedAnimationManager = [[self alloc] init];
    });
    return _sharedAnimationManager;
}

- (void)move:(UIView *)moveView from:(CGPoint)fp to:(CGPoint)tp duration:(CFTimeInterval)duration complete:(void (^)(void))block
{
    [self move:moveView from:fp to:tp duration:duration delay:0 complete:block];
}

- (void)move:(UIView *)moveView from:(CGPoint)fp to:(CGPoint)tp duration:(CFTimeInterval)duration
{
    [self move:moveView from:fp to:tp duration:duration complete:nil];
}

- (void)move:(UIView *)movedView from:(CGPoint)fp to:(CGPoint)tp duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay complete:(animationCompletionBlock)block
{
    CAKeyframeAnimation *anim = [BaseAnimation ssMoveFromPoint:fp toPoint:tp duration:duration];
    anim.beginTime = CACurrentMediaTime()+delay;
    anim.delegate = self;
    animationCompletionBlock theBlock;
    theBlock = ^void(void){
        movedView.layer.position = tp;
        if (block) {
            block();
        }
    };
    [anim setValue:theBlock forKey:kAnimationCompletionBlock];
    
    animationStartBlock theStartBlock;
    theStartBlock = ^void (void) {
        movedView.layer.position = tp;
    };
    [anim setValue:theStartBlock forKey:kAnimationStartBlock];
    
    [movedView.layer addAnimation:anim forKey:nil];
}

- (void)move:(UIView *)movedView from:(CGPoint)fp to:(CGPoint)tp duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay
{
    [self move:movedView from:fp to:tp duration:duration delay:delay complete:nil];
}


-(void)move:(UIView *)moveView from:(CGPoint)fpfp to:(CGPoint)tp duration:(CFTimeInterval)duration path:(UIBezierPath *)path delay:(CFTimeInterval)delay complete:(animationCompletionBlock)block{
    CAKeyframeAnimation *anim = [BaseAnimation ssMoveFromPoint:fpfp toPoint:tp path:path duration:duration];
    anim.beginTime = CACurrentMediaTime()+delay;
    anim.delegate = self;
    animationCompletionBlock theBlock;
    theBlock = ^void(void){
        moveView.layer.position = tp;
        if (block) {
            block();
        }
    };
    [anim setValue:theBlock forKey:kAnimationCompletionBlock];
    
    animationStartBlock theStartBlock;
    theStartBlock = ^void (void) {
        moveView.layer.position = tp;
    };
    [anim setValue:theStartBlock forKey:kAnimationStartBlock];
    
    [moveView.layer addAnimation:anim forKey:nil];
}
- (void)rotate:(UIView *)rotateView duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay repeatCount:(float)count timingFunction:(NSString *)timingFuc clockwise:(BOOL)isClock complete:(animationCompletionBlock)block
{
    CABasicAnimation *anim = [BaseAnimation ssRotateDuration:duration repeatCount:count timingFunction:timingFuc clockwise:isClock];
    anim.beginTime = CACurrentMediaTime()+delay;
    anim.delegate = self;
    animationCompletionBlock theBlock;
    theBlock = ^void(void){
        if (block) {
            block();
        }
    };
    [anim setValue:theBlock forKey:kAnimationCompletionBlock];
    [rotateView.layer addAnimation:anim forKey:nil];
}

- (void)rotate:(UIView *)rotateView duration:(CFTimeInterval)duration repeatCount:(float)count timingFunction:(NSString *)timingFuc clockwise:(BOOL)isClock complete:(animationCompletionBlock)block
{
    [self rotate:rotateView duration:duration delay:0 repeatCount:count timingFunction:timingFuc clockwise:isClock complete:block];
}

- (void)rotate:(UIView *)rotateView repeatForeverWithSpeed:(float)speed timingFuction:(NSString *)timingFuc clockWise:(BOOL)isClock
{
    CABasicAnimation *anim = [BaseAnimation ssRotateDurationRepeatForeverWithSpeed:speed timingFunction:timingFuc clockWise:isClock];
    [rotateView.layer addAnimation:anim forKey:nil];
}


- (void)rotate:(UIView *)rotateView toDegree:(float)degree duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay complete:(animationCompletionBlock)block
{
    CABasicAnimation *anim = [BaseAnimation ssRotateToDegree:degree duration:duration];
    anim.beginTime = CACurrentMediaTime()+delay;
    anim.delegate = self;
    animationCompletionBlock theBlock;
    theBlock = ^void(void){
        if (block) {
            block();
        }
    };
    [anim setValue:theBlock forKey:kAnimationCompletionBlock];
    [rotateView.layer addAnimation:anim forKey:nil];
}

- (void)rotate:(UIView *)rotateView toDegree:(float)degree duration:(CFTimeInterval)duration complete:(animationCompletionBlock)block
{
    [self rotate:rotateView toDegree:degree duration:duration delay:0 complete:block];
}

- (void)opacity:(UIView *)opacityView fromValue:(float)fv toValue:(float)tv duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay complete:(animationCompletionBlock)block
{
    opacityView.layer.opacity = fv;
    CABasicAnimation *anim = [BaseAnimation ssOpacityDuration:duration];
    anim.beginTime = CACurrentMediaTime() + delay;
    [anim setToValue:[NSNumber numberWithFloat:tv]];
    anim.delegate = self;
    animationCompletionBlock theBlock;
    theBlock = ^void(void){
        opacityView.layer.opacity = tv;
        if (block) {
            block();
        }
    };
    [anim setValue:theBlock forKey:kAnimationCompletionBlock];
    
    
    [opacityView.layer addAnimation:anim forKey:nil];
}

- (void)opacity:(UIView *)opacityView toValue:(float)value duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay complete:(animationCompletionBlock)block
{
    CABasicAnimation *anim = [BaseAnimation ssOpacityDuration:duration];
    anim.beginTime = CACurrentMediaTime() + delay;
    [anim setToValue:[NSNumber numberWithFloat:value]];
    anim.delegate = self;
    animationCompletionBlock theBlock;
    theBlock = ^void(void){
        if (block) {
            block();
        }
    };
    [anim setValue:theBlock forKey:kAnimationCompletionBlock];
    [opacityView.layer addAnimation:anim forKey:nil];
}

- (void)opacityShow:(UIView *)opacityView duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay complete:(animationCompletionBlock)block
{
    [self opacity:opacityView fromValue:.0 toValue:1.0 duration:duration delay:delay complete:block];
}

- (void)opacityShow:(UIView *)opacityView duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay
{
    [self opacityShow:opacityView duration:duration delay:delay complete:nil];
}

- (void)opacityShow:(UIView *)opacityView duration:(CFTimeInterval)duartion complete:(animationCompletionBlock)block
{
    [self opacityShow:opacityView duration:duartion delay:0 complete:block];
}

- (void)opacityHide:(UIView *)opacityView duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay complete:(animationCompletionBlock)block
{
    //[self opacity:opacityView.layer fromValue:1.0 toValue:0.0 duration:duration delay:delay complete:block];
    //修改 By WXM
    [self opacity:opacityView fromValue:opacityView.layer.opacity toValue:0.0 duration:duration delay:delay complete:block];
    
}

- (void)opacityHide:(UIView *)opacityView duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay
{
    [self opacityHide:opacityView duration:duration delay:delay complete:nil];
}

- (void)opacityHide:(UIView *)opactiyView duration:(CFTimeInterval)duration complete:(animationCompletionBlock)block
{
    [self opacityHide:opactiyView duration:duration delay:0 complete:block];
}

- (void)opacityHide:(UIView *)opactiyView duration:(CFTimeInterval)duration
{
    [self opacityHide:opactiyView duration:duration complete:nil];
}

- (void)colorChange:(UIView *)colorView fromColor:(UIColor *)fc toColor:(UIColor *)tc duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay complete:(animationCompletionBlock)block
{
    CABasicAnimation *anim = [BaseAnimation ssBackgroundColor];
    anim.beginTime = CACurrentMediaTime() + delay;
    anim.fromValue = (id)fc.CGColor;
    anim.toValue = (id)tc.CGColor;
    anim.duration = duration;
    anim.delegate = self;
    animationCompletionBlock theBolock;
    theBolock = ^void(void){
        colorView.layer.backgroundColor = (__bridge CGColorRef)((id)tc.CGColor);
        if (block) {
            block();
        }
    };
    [anim setValue:theBolock forKey:kAnimationCompletionBlock];
    [colorView.layer addAnimation:anim forKey:nil];
}

- (void)colorChange:(UIView *)colorView fromColor:(UIColor *)fc toColor:(UIColor *)tc duration:(CFTimeInterval)duration complete:(animationCompletionBlock)block
{
    [self colorChange:colorView fromColor:fc toColor:tc duration:duration delay:0 complete:block];
}

- (void)colorChange:(UIView *)colorView fromColor:(UIColor *)fc toColor:(UIColor *)tc duration:(CFTimeInterval)duration
{
    [self colorChange:colorView fromColor:fc toColor:tc duration:duration complete:nil];
}

- (void)strokeColor:(CALayer *)layer fromColor:(UIColor *)fc toColor:(UIColor *)tc duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay complete:(animationCompletionBlock)block
{
    CABasicAnimation *anim = [BaseAnimation ssStrokeColor];
    anim.beginTime = CACurrentMediaTime() + delay;
    anim.fromValue = (id)fc.CGColor;
    anim.toValue = (id)tc.CGColor;
    anim.duration = duration;
    anim.delegate = self;
    animationCompletionBlock theBlock;
    theBlock = ^void(void) {
        layer.backgroundColor = (__bridge CGColorRef)((id)tc.CGColor);
        if (block) {
            block();
        }
    };
    [anim setValue:theBlock forKey:kAnimationCompletionBlock];
    [layer addAnimation:anim forKey:nil];
}

- (void)strokeColor:(CALayer *)layer fromColor:(UIColor *)fc toColor:(UIColor *)tc duration:(CFTimeInterval)duration complete:(animationCompletionBlock)block
{
    [self strokeColor:layer fromColor:fc toColor:tc duration:duration delay:0 complete:block];
}

- (void)strokeColor:(CALayer *)layer fromColor:(UIColor *)fc toColor:(UIColor *)tc duration:(CFTimeInterval)duration
{
    [self strokeColor:layer fromColor:fc toColor:tc duration:duration complete:nil];
}

- (void)strokeMove:(CALayer *)layer from:(float)f to:(float)t duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay complete:(animationCompletionBlock)block
{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    anim.beginTime = CACurrentMediaTime() + delay;
    if (f >1) f = 1;
    if (f < 0) f = 0;
    if (t > 1) t = 1;
    if (t < 0) t = 0;
    anim.fromValue = [NSNumber numberWithFloat:f];
    anim.toValue = [NSNumber numberWithFloat:t];
    anim.delegate = self;
    anim.duration = duration;
    animationCompletionBlock theBlock;
    theBlock = ^void (void) {
        CAShapeLayer *sl = (CAShapeLayer *)layer;
        sl.strokeEnd = t;
        if (block) {
            block();
        }
    };
    [anim setValue:theBlock forKey:kAnimationCompletionBlock];
    [layer addAnimation:anim forKey:nil];
}

- (void)strokeMove:(CALayer *)layer from:(float)f to:(float)t duration:(CFTimeInterval)duration complete:(animationCompletionBlock)block
{
    [self strokeMove:layer from:f to:t duration:duration delay:0 complete:block];
}

- (void)strokeMove:(CALayer *)layer from:(float)f to:(float)t duration:(CFTimeInterval)duration
{
    [self strokeMove:layer from:f to:t duration:duration complete:nil];
}

- (void)scale:(UIView *)scaleView from:(float)f to:(float)t duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay complete:(animationCompletionBlock)block
{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.beginTime = CACurrentMediaTime() + delay;
    scaleAnimation.fromValue = [NSNumber numberWithFloat:f];
    scaleAnimation.toValue = [NSNumber numberWithFloat:t];
    scaleAnimation.duration = duration;
    scaleAnimation.delegate = self;
    scaleAnimation.fillMode = kCAFillModeBoth;
    animationCompletionBlock theBolock;
    theBolock = ^void(void){
        if (block) {
            block();
        }
    };
    [scaleAnimation setValue:theBolock forKey:kAnimationCompletionBlock];
    [scaleView.layer addAnimation:scaleAnimation forKey:nil];
}

- (void)animationDidStart:(CAAnimation *)anim
{
    animationStartBlock theBlock = [anim valueForKey:kAnimationStartBlock];
    if (theBlock) {
        theBlock();
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    animationCompletionBlock theBlock = [anim valueForKey:kAnimationCompletionBlock];
    if (theBlock) {
        theBlock();
    }
}

- (void)sequece:(UIView *)view repeatCount:(int)count withAnimations:(CAAnimation *)animtaion1, ...
{
    NSMutableArray *animMArr = [NSMutableArray arrayWithCapacity:0];
    CGFloat totalDuration = 0;
    CAAnimation* eachAni;
    va_list params;
    if (animtaion1) {
        totalDuration = animtaion1.duration+animtaion1.beginTime;
        [animMArr addObject:animtaion1];
        va_start(params, animtaion1);
        while ((eachAni = va_arg(params, id))){
            eachAni.beginTime = totalDuration+eachAni.beginTime;
            [animMArr addObject:eachAni];
            totalDuration = totalDuration+ eachAni.duration;
        }
        va_end(params);
    }
    CAAnimationGroup *group = [CAAnimationGroup animation];
    [group setDuration:totalDuration];
    [group setAnimations:animMArr];
    [group setRepeatCount:count];
    [view.layer addAnimation:group forKey:nil];
    
}

- (void)sequece:(UIView *)view complete:(animationCompletionBlock)block afterAnimations:(CAAnimation *)animtaion1, ...
{
    NSMutableArray *animMArr = [NSMutableArray arrayWithCapacity:0];
    CGFloat totalDuration = 0;
    CAAnimation* eachAni;
    va_list params;
    if (animtaion1) {
        totalDuration = animtaion1.duration+animtaion1.beginTime;
        [animMArr addObject:animtaion1];
        va_start(params, animtaion1);
        while ((eachAni = va_arg(params, id))){
            eachAni.beginTime = totalDuration+eachAni.beginTime;
            [animMArr addObject:eachAni];
            totalDuration = totalDuration+ eachAni.duration;
        }
        va_end(params);
    }
    CAAnimationGroup *group = [CAAnimationGroup animation];
    [group setDuration:totalDuration];
    [group setAnimations:animMArr];
    [group setRepeatCount:FLT_MAX];
    animationCompletionBlock theBlock;
    theBlock = ^void(void){
        if (block) {
            block();
        }
    };
    [group setValue:theBlock forKey:kAnimationCompletionBlock];
    group.delegate = self;
    [view.layer addAnimation:group forKey:nil];
}

-(void)touchEffect:(UIView *)view touchEvent:(NSString *)downOrUp duration:(float)duration from:(float)f to:(float)t{
    float from = 1;
    float to = 1;
    if ([downOrUp isEqualToString:@"down"]) {
        from = 1;
        to = 0.8;
    }else if([downOrUp isEqualToString:@"up"]){
        from = .8f;
        to = 1;
    }
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:f];
    scaleAnimation.toValue = [NSNumber numberWithFloat:t];
    scaleAnimation.duration = duration;
    scaleAnimation.delegate = self;
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fillMode = kCAFillModeBoth;
    [view.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}

-(void)mailIconAnimation:(UIView *)view{
    [view runAction:[SSRepeat actionWithAction:[SSSequence actionsWithBlock:nil action:[SSScale actionWithDuration:.3 scale:.8 block:nil],[SSScale actionWithDuration:.1 scale:1.2f block:nil],[SSScale actionWithDuration:.1 scale:1 block:nil],[SSScale actionWithDuration:.05 scale:.9f block:nil],[SSScale actionWithDuration:.05 scale:1 block:nil],[SSDelayTime actionWithDuration:1 block:nil], nil] times:FLT_MAX block:nil]];
}

-(void)stopAnimation:(UIView *)view{
    [view stopAllActions];
}

//-(void)receiveAwardAnimaton:(ReceiveAwardType)rType num:(NSString *)number{
//    ShowRewareReceivePopView * pop = POPUP_VIEW(NSStringFromClass([ShowRewareReceivePopView class]));
//    [pop show:rType num:number];
//    pop.center = MAINSCREEN_CENTER;
//    UIViewController * con = [[App.navController childViewControllers] lastObject];
//    [con.view addSubview:pop];
//    pop.hidden = YES;
//    [self performBlock:^{
//        pop.hidden = NO;
//        [self performBlock:^{
//            [pop removeFromSuperview];
//        } afterDelay:2];
//    } afterDelay:2];
//}
//
//-(void)dropAwardAnimation:(ReceiveAwardType)rType{
//    NSString * imgName;
//    if (rType == ReceiveAwardTypeChip) {
//        imgName = [NSString stringWithFormat:@"drop_animation_chip"];
//    }else{
//        imgName = [NSString stringWithFormat:@"drop_animation_gem"];
//    }
//    [self playAnimation:imgName];
//}
//-(void)playAnimation:(NSString*)name{
//    for (int i = 0; i<60; i++) {
//        float x = 0;
//        float y = 0;
//        //控制随机图片scale大小
//        float randomScale =rand()/(double)(RAND_MAX);
//        if (randomScale<0.5) {
//            randomScale = .5f;
//        }
//        //控制X坐标增加还是减少
//        BOOL addOrSubX = arc4random()%2>0.5?YES:NO;
//        //控制Y坐标增加还是减少
//        BOOL addOrSubY = arc4random()%2>0.5?YES:NO;
//        //随机X轴坐标增量
//        int halfWidth =MAINSCREEN_WIDTH/2;
//        float randomX = arc4random() % halfWidth + 1;
//        //随机Y轴坐标增量
//        int halfHeight = MAINSCREEN_HEIGHT/2;
//        float randomY = arc4random() % halfHeight + 1;
//        
//        if (addOrSubX) {
//            x = MAINSCREEN_WIDTH/2-randomX;
//        }else{
//            x = MAINSCREEN_WIDTH/2+randomX;
//        }
//        
//        if (addOrSubY) {
//            y = MAINSCREEN_HEIGHT/2-randomY;
//        }else{
//            y = MAINSCREEN_HEIGHT/2+randomY;
//        }
//        
//        UIImageView * imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 76*New_Content_Size*randomScale, 76*New_Content_Size*randomScale)];
//        [imgv setImage:[ZLUIImage zlImageNamed:name]];
//        imgv.center  = ccp(x, y);
//        UIViewController * con =[[App.navController childViewControllers] lastObject];
//        [con.view insertSubview:imgv atIndex:INFINITY];
//        CGMutablePathRef path=CGPathCreateMutable();
//        if (x>MAINSCREEN_WIDTH/2) {
//            CGPathMoveToPoint(path, NULL, x, y);
//            CGPathAddCurveToPoint(path,NULL,x,y,x-80*New_Content_Size,y-100*New_Content_Size,x-170*New_Content_Size,y-170*New_Content_Size);
//        }else{
//            CGPathMoveToPoint(path, NULL, x, y);
//            CGPathAddCurveToPoint(path,NULL,x,y,x+80*New_Content_Size,y-100*New_Content_Size,x+170*New_Content_Size,y-170*New_Content_Size);
//        }
//        
//        CGMutablePathRef path1=CGPathCreateMutable();
//        if (x>MAINSCREEN_WIDTH/2) {
//            CGPathMoveToPoint(path1, NULL, x-170*New_Content_Size,y-170*New_Content_Size);
//            CGPathAddCurveToPoint(path1,NULL,x-170*New_Content_Size,y-170*New_Content_Size,x-185*New_Content_Size,y-185*New_Content_Size,x-200*New_Content_Size,y-170*New_Content_Size);
//        }else{
//            CGPathMoveToPoint(path1, NULL, x+170*New_Content_Size,y-170*New_Content_Size);
//            CGPathAddCurveToPoint(path1,NULL,x+170*New_Content_Size,y-170*New_Content_Size,x+185*New_Content_Size,y-185*New_Content_Size,x+200*New_Content_Size,y-170*New_Content_Size);
//        }
//        
//        CGMutablePathRef path2=CGPathCreateMutable();
//        if (x>MAINSCREEN_WIDTH/2) {
//            CGPathMoveToPoint(path2, NULL, x-200*New_Content_Size,y-170*New_Content_Size);
//            CGPathAddCurveToPoint(path2,NULL,x-300*New_Content_Size,y-200*New_Content_Size,x-500*New_Content_Size,y+100*New_Content_Size,x-700*New_Content_Size,y+300*New_Content_Size);
//        }else{
//            CGPathMoveToPoint(path2, NULL, x+200*New_Content_Size,y-170*New_Content_Size);
//            CGPathAddCurveToPoint(path2,NULL,x+300*New_Content_Size,y-200*New_Content_Size,x+500*New_Content_Size,y+100*New_Content_Size,x+700*New_Content_Size,y+300*New_Content_Size);
//        }
//        
//        float r = rand()/(double)(RAND_MAX)*2;
//        
//        float time3 = r/4+.5+r/40+.05+r/40+.8+r/40;
//        
//        imgv.alpha = 0;
//        [imgv runAction:[SSRepeat actionWithAction:[SSRotate actionWithDuration:time3/4 degree:360 clockwise:YES keyPath:@"transform.rotation" block:nil] times:4 block:nil]];
//        [imgv runAction:[SSRepeat actionWithAction:[SSSequence actionsWithBlock:nil action:[SSDelayTime actionWithDuration:time3/8 block:nil],[SSFadeIn actionWithDuration:time3*7/8 block:nil], nil] times:1 block:nil]];
//        [imgv runAction:[SSRepeat actionWithAction:[SSSequence actionsWithBlock:nil action:[SSDelayTime actionWithDuration:r/4 block:nil],[SSMove actionWithDuration:(.5+r/40) path:path block:nil],[SSMove actionWithDuration:(.05+r/40) path:path1 block:nil],[SSMove actionWithDuration:(.8+r/40) path:path2 block:nil], nil] times:1 block:nil]];
//
//        [self performBlock:^{
//            [imgv removeFromSuperview];
//        } afterDelay:time3];
//    }
//}
@end
