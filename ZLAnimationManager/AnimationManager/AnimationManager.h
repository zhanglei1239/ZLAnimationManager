//
//  AnimationManager.h
//  subviewTest
//
//  Created by vienta on 13-11-5.
//  Copyright (c) 2013年 Candy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void (^animationCompletionBlock) (void);
typedef void (^animationStartBlock)(void);

#define kAnimationCompletionBlock @"kAnimationCompletionBlock"
#define kAnimationStartBlock @"kAnimationStartBlock"

@interface AnimationManager : NSObject

+ (AnimationManager *)sharedAnimationManager;
/**
 *  两点之间的移动
 *
 *  @param moveView 需要移动的物件
 *  @param fp       起始点
 *  @param tp       终点
 *  @param duration 时间
 *  @param block    完成block
 */
- (void)move:(UIView *)moveView from:(CGPoint)fp to:(CGPoint)tp duration:(CFTimeInterval)duration complete:(void (^)(void))block;


/**
 *  两点之间移动
 *
 *  @param moveView 需要移动的物件
 *  @param fp       起始点
 *  @param tp       终点
 *  @param duration 时间
 */
- (void)move:(UIView *)moveView from:(CGPoint)fp to:(CGPoint)tp duration:(CFTimeInterval)duration;
/**
 *  两点之间的移动
 *
 *  @param movedView 需要移动的物件
 *  @param fp        起始点
 *  @param tp        终点
 *  @param duration  所用时间
 *  @param delay     停留时间 即这段时间后触发
 *  @param block     完成block
 */
- (void)move:(UIView *)movedView from:(CGPoint)fp to:(CGPoint)tp duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay complete:(animationCompletionBlock)block;

/**
 *  两点之间的移动
 *
 *  @param movedView 需要移动的物件
 *  @param fp        起始点
 *  @param tp        终点
 *  @param duration  所用时间
 *  @param delay     停留时间 即这段时间后触发
 */
- (void)move:(UIView *)movedView from:(CGPoint)fp to:(CGPoint)tp duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay;

/**
 *  旋转物件
 *
 *  @param rotateView 被旋转的物件
 *  @param duration   旋转时间
 *  @param delay      停留多少时间触发
 *  @param count      旋转多少次
 *  @param timingFuc  timing functions 动画行为效果 默认nil 支持kCAMediaTimingFunctionLinear kCAMediaTimingFunctionEaseIn kCAMediaTimingFunctionEaseOut kCAMediaTimingFunctionEaseInEaseOut kCAMediaTimingFunctionDefault
 *  @param isClock    旋转方向 顺时针 或者逆时针
 *  @param block      完成block
 */
- (void)rotate:(UIView *)rotateView duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay repeatCount:(float)count timingFunction:(NSString *)timingFuc clockwise:(BOOL)isClock complete:(animationCompletionBlock)block;

/**
 *  旋转物件
 *
 *  @param rotateView 被旋转的物件
 *  @param duration   旋转时间
 *  @param count      旋转多少次
 *  @param timingFuc  同上
 *  @param isClock    同上
 *  @param block      完成block
 */
- (void)rotate:(UIView *)rotateView duration:(CFTimeInterval)duration repeatCount:(float)count timingFunction:(NSString *)timingFuc clockwise:(BOOL)isClock complete:(animationCompletionBlock)block;

/**
 *  物件无限旋转
 *
 *  @param rotateView 被旋转的物件
 *  @param speed      旋转速度
 *  @param timingFuc  timingFuc
 *  @param isClock    旋转方向 顺时针 或者逆时针
 */
- (void)rotate:(UIView *)rotateView repeatForeverWithSpeed:(float)speed timingFuction:(NSString *)timingFuc clockWise:(BOOL)isClock;

/**
 *  旋转物件到指定角度
 *
 *  @param rotateView 被旋转的物件
 *  @param degree     旋转角度
 *  @param duration   所需时间
 *  @param delay      延迟多少时间后触发
 *  @param block      完成block
 */
- (void)rotate:(UIView *)rotateView toDegree:(float)degree duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay complete:(animationCompletionBlock)block;

/**
 *  旋转物件到指定角度
 *
 *  @param rotateView 被旋转的物件
 *  @param degree     旋转角度
 *  @param duration   所需时间
 *  @param block      完成block
 */
- (void)rotate:(UIView *)rotateView toDegree:(float)degree duration:(CFTimeInterval)duration complete:(animationCompletionBlock)block;

/**
 *  物件透明度调整
 *
 *  @param opacityView 需要调整的物件
 *  @param fv          起始透明度 (fv.tv 都在0-1.0之间)
 *  @param tv          终点透明度
 *  @param duration    时间
 *  @param delay       延迟多少时间后触发
 *  @param block       完成block
 */
- (void)opacity:(UIView *)opacityView fromValue:(float)fv toValue:(float)tv duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay complete:(animationCompletionBlock)block;


/**
 *  物件透明度调整
 *
 *  @param opacityView 需要调整的物件
 *  @param value       需要调整到的值(在0~1.0之间)
 *  @param duration    时间
 *  @param delay       延迟多少时间后触发
 *  @param block       完成block
 */
- (void)opacity:(UIView *)opacityView toValue:(float)value duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay complete:(animationCompletionBlock)block;

/**
 *  物件透明度调整 从完全透明到完全不透明
 *
 *  @param opacityView 需要调整的物件
 *  @param duration    时间
 *  @param delay       延迟多少时间后触发
 *  @param block       完成block
 */
- (void)opacityShow:(UIView *)opacityView duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay complete:(animationCompletionBlock)block;

/**
 *  物件透明度调整 从完全透明到完全不透明
 *
 *  @param opacityView 需要调整的物件
 *  @param duration    时间
 *  @param delay       延迟多少时间后触发
 */
- (void)opacityShow:(UIView *)opacityView duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay;

/**
 *  物件透明度调整 从完全透明到完全不透明
 *
 *  @param opacityView 需要调整的物件
 *  @param duartion    时间
 *  @param block       完成block
 */
- (void)opacityShow:(UIView *)opacityView duration:(CFTimeInterval)duartion complete:(animationCompletionBlock)block;

/**
 *  物件透明度调整 从完全不透明到完全透明
 *
 *  @param opacityView 需要调整的物件
 *  @param duration    时间
 *  @param delay       延迟多少时间后触发
 *  @param block       完成block
 */
- (void)opacityHide:(UIView *)opacityView duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay complete:(animationCompletionBlock)block;

/**
 *  物件透明度调整 从完全不透明到完全透明
 *
 *  @param opacityView 需要调整的物件
 *  @param duration    时间
 *  @param delay       延迟多少时间后触发
 */
- (void)opacityHide:(UIView *)opacityView duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay;

/**
 *  物件透明度调整 从完全不透明到完全透明
 *
 *  @param opactiyView 需要调整的物件
 *  @param duration    时间
 *  @param block       完成block
 */
- (void)opacityHide:(UIView *)opactiyView duration:(CFTimeInterval)duration complete:(animationCompletionBlock)block;

/**
 *  物件透明度调整 从完全不透明到完全透明
 *
 *  @param opactiyView 需要调整的物件
 *  @param duration    时间
 */
- (void)opacityHide:(UIView *)opactiyView duration:(CFTimeInterval)duration;

/**
 *	改变物件背景颜色
 *
 *	@param	colorView	需要修改的物件
 *	@param	fc	起始颜色
 *	@param	tc	终点颜色
 *	@param	duration	经过时间
 *	@param	delay	延迟多少时间后触发
 *	@param	block   完成block
 */
- (void)colorChange:(UIView *)colorView fromColor:(UIColor *)fc toColor:(UIColor *)tc duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay complete:(animationCompletionBlock)block;

/**
 *	改变物件背景颜色
 *
 *	@param	colorView	需要修改的物件
 *	@param	fc	起始颜色
 *	@param	tc	终点颜色
 *	@param	duration	经过时间
 *	@param	block	完成block
 */
- (void)colorChange:(UIView *)colorView fromColor:(UIColor *)fc toColor:(UIColor *)tc duration:(CFTimeInterval)duration complete:(animationCompletionBlock)block;

/**
 *	改变物件背景颜色
 *
 *	@param	colorView	需要修改的物件
 *	@param	fc	起始颜色
 *	@param	tc	终点颜色
 *	@param	duration	经过时间
 */
- (void)colorChange:(UIView *)colorView fromColor:(UIColor *)fc toColor:(UIColor *)tc duration:(CFTimeInterval)duration;


/**
 *	改strokeColor
 *
 *	@param	layer	需要修改的layer CAShaperLayer
 *	@param	fc	起始颜色
 *	@param	tc	终点颜色
 *	@param	duration	持续时间
 *	@param	delay	延迟多少后触发
 *	@param	block   完成block
 */
- (void)strokeColor:(CALayer *)layer fromColor:(UIColor *)fc toColor:(UIColor *)tc duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay complete:(animationCompletionBlock)block;

- (void)strokeColor:(CALayer *)layer fromColor:(UIColor *)fc toColor:(UIColor *)tc duration:(CFTimeInterval)duration complete:(animationCompletionBlock)block;

- (void)strokeColor:(CALayer *)layer fromColor:(UIColor *)fc toColor:(UIColor *)tc duration:(CFTimeInterval)duration;


/**
 *	strokeMove 针对项目需要
 *
 *	@param	layer	需要修改的layer CAShaperLayer
 *	@param	f	起始点 (f,p 是在0~1之间)
 *	@param	t	终点
 *	@param	duration	持续时间
 *	@param	delay	延迟多少后触发
 *	@param	block	完成block
 */
- (void)strokeMove:(CALayer *)layer from:(float)f to:(float)t duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay complete:(animationCompletionBlock)block;

- (void)strokeMove:(CALayer *)layer from:(float)f to:(float)t duration:(CFTimeInterval)duration complete:(animationCompletionBlock)block;

- (void)strokeMove:(CALayer *)layer from:(float)f to:(float)t duration:(CFTimeInterval)duration;

- (void)scale:(UIView *)scaleView from:(float)f to:(float)t duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay complete:(animationCompletionBlock)block;

/**
 *  物体动画序列
 *
 *  @param view       需要动画的物件
 *  @param block      序列动画完成后的block
 *  @param animtaion1 动画多参数...  移动要注意移动动画是调整物体的位置 否则容易出错
 */
- (void)sequece:(UIView *)view complete:(animationCompletionBlock)block afterAnimations:(CAAnimation *)animtaion1, ...NS_REQUIRES_NIL_TERMINATION;
/**
 *  view 放大缩小
 *
 *  @param view     要处理的view
 *  @param downOrUp 是放大还是缩小
 */
-(void)touchEffect:(UIView *)view touchEvent:(NSString *)downOrUp duration:(float)duration from:(float)f to:(float)t;

/**
 *  邮箱提示闪动动画
 *
 *  @param view 邮箱提示View
 */
-(void)mailIconAnimation:(UIView *)view;

-(void)stopAnimation:(UIView *)view;
@end
