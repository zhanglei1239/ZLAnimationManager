//
//  BaseAnimation.h
//  SSAnimation
//
//  Created by 束 永兴 on 13-7-24.
//  Copyright (c) 2013年 Candy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface BaseAnimation : NSObject

 /**
  *	CABasicAnimation 关键帧动画
  */

/**
 *	animation Rotate 旋转
 *
 *	@param	duration	旋转时间
 *	@param	count	旋转次数
 *	@param	timingFunc	timing functions 动画行为效果 默认nil 
                        支持kCAMediaTimingFunctionLinear
                        kCAMediaTimingFunctionEaseIn 
                        kCAMediaTimingFunctionEaseOut 
                        kCAMediaTimingFunctionEaseInEaseOut 
                        kCAMediaTimingFunctionDefault
 *	@param	isClock	旋转房间 顺时针 或者逆时针
 *
 *	@return	CABasicAnimation 
 */
+ (CABasicAnimation *)ssRotateDuration:(CFTimeInterval)duration
                           repeatCount:(float)count
                        timingFunction:(NSString *)timingFunc
                             clockwise:(BOOL)isClock;
/**
 *	animation Rotate 旋转 是否forever
 *
 *	@param	speed	旋转速度  
 *	@param	timingFunc	同上
 *	@param	isClock	同上
 *
 *	@return	CABasicAnimation
 */
+ (CABasicAnimation *)ssRotateDurationRepeatForeverWithSpeed:(float)speed
                                                  timingFunction:(NSString*)timingFunc
                                                   clockWise:(BOOL)isClock;

/**
 *	animation Rotate 旋转 到指定的角度
 *
 *	@param	degree	旋转的角度
 *	@param	duration	旋转所用的时间
 *
 *	@return	CABasicAnimation
 */
+ (CABasicAnimation *)ssRotateToDegree:(float)degree
                             duration:(CFTimeInterval)duration;

+ (void)ssRotateLayer:(CALayer *)layer
             rotateDegree:(float)degree
             duration:(CFTimeInterval)duration;
/**
 *	animation Scale 缩放
 *
 *	@param	duration	缩放的时间
 *	@param	scale       缩放的大小比例
 *	@param	timingFunc	同上
 *
 *	@return	CABasicAnimation
 */
+ (CABasicAnimation *)ssScaleDuration:(CFTimeInterval)duration
                                scale:(CGFloat)scale
                       timingFunction:(NSString *)timingFunc;
/**
 *	animation Scale 缩放
 *
 *	@param	layer	需要缩放的layer
 *	@param	duration	缩放时间
 *	@param	scale	缩放比例
 *	@param	timingFunc	同上
 */
//TOOD:动画有冲突 展现不出来动画 不知道为什么
+ (void)ssScaleLayer:(CALayer*)layer
            duration:(CFTimeInterval)duration
               scale:(CGFloat)scale
      timingFunction:(NSString *)timingFunc;

+ (void)ssScaleLayer:(CALayer*)layer
            duration:(CFTimeInterval)duration
               scale:(CGFloat)scale
      timingFunction:(NSString *)timingFunc
            complete:(void (^)())block;

/**
 *	animation Move 两点直线移动
 *
 *	@param	fp	起点
 *	@param	tp	终点
 *	@param	duration 移动时间
 *
 *	@return	CAKeyframAnimation
 */
+ (CAKeyframeAnimation *)ssMoveFromPoint:(CGPoint)fp
                                 toPoint:(CGPoint)tp
                                duration:(CFTimeInterval)duration;
/**
 *	animation Move 两点之间的移动 必须给定路径
 *
 *	@param	fp	起点
 *	@param	tp	终点
 *	@param	path	路径
 *	@param	duration	移动时间
 *
 *	@return	CAKeyframeAnimation
 */
+ (CAKeyframeAnimation *)ssMoveFromPoint:(CGPoint)fp
                                 toPoint:(CGPoint)tp
                                    path:(UIBezierPath*)path
                                duration:(CFTimeInterval)duration;

/**
 *	animation HeartBeat 心跳动画
 *
 *	@param	scale	缩放大小
 *	@param	during	心跳一次的时间
 *
 *	@return	CABasicAnimation
 */
+ (CABasicAnimation *)ssHeartBeatLayer:(CALayer*)layer
                                 scale:(float)scale
                             perduring:(CFTimeInterval)during;

/**
 *	animaion 修改背景
 *
 *	@return	CABasicAnimation
 */
+ (CABasicAnimation *)ssBackgroundColor;

+ (CABasicAnimation *)ssOpacityDuration:(CFTimeInterval)duration;

/**
 *	描边颜色
 *
 *	@return	CABasicAnimation
 */
+ (CABasicAnimation *)ssStrokeColor;
/**
 *	animation flip 翻牌
 */
+ (void)flipViewsFrontView:(UIView*)fv backView:(UIView *)bv duration:(CFTimeInterval)duration;

@end
