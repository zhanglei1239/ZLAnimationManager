//
//  SSAction.h
//  SSAnimation
//
//  Created by vienta on 13-12-25.
//  Copyright (c) 2013年 Candy. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>
@interface CAAnimation (times)

@property (nonatomic, assign) NSInteger times;

@end



@interface SSAction : CAAnimation

@end


@interface SSMove : SSAction

/**
 *	move 移动
 *
 *	@param	duration	时间
 *	@param	fp	起点
 *	@param	tp	终点
 *
 *	@return	action
 */
+ (id)actionWithDuration:(CFTimeInterval)duration from:(CGPoint)fp to:(CGPoint)tp block:(void(^)(void))block;

- (id)initWithDuration:(CFTimeInterval)duration from:(CGPoint)fp to:(CGPoint)tp block:(void(^)(void))block;


/**
 *	move 移动
 *
 *	@param	duration	时间
 *	@param	path	路径
 *
 *	@return	action
 */
+ (id)actionWithDuration:(CFTimeInterval)duration path:(CGPathRef)path block:(void(^)(void))block;

- (id)initWithDuration:(CFTimeInterval)duration path:(CGPathRef)path block:(void(^)(void))block;

@end


@interface SSRotate : SSAction

/**
 *	rotate 旋转
 *
 *	@param	duration	时间
 *	@param	degree	角度 example:45 表示顺时针45°旋转 145 表示逆时针45°旋转
 *
 *	@return	action
 */
+ (id)actionWithDuration:(CFTimeInterval)duration degree:(float)degree clockwise:(BOOL)isClock keyPath:(NSString *)path block:(void(^)(void))block;

- (id)initWithDuration:(CFTimeInterval)duration degree:(float)degree clockwise:(BOOL)isClock keyPath:(NSString *)path block:(void(^)(void))block;

@end

@interface SSScale : SSAction

/**
 *	scale 缩放
 *	@param	duration	时间
 *	@param	s 缩放比例
 *
 *	@return	action
 */
+ (id)actionWithDuration:(CFTimeInterval)duration scale:(float)s block:(void(^)(void))block;

- (id)initWithDuration:(CFTimeInterval)duration scale:(float)s block:(void(^)(void))block;

+ (id)actionWithDuration:(CFTimeInterval)duration scaleX:(float)sx block:(void(^)(void))block;

- (id)initWithDuration:(CFTimeInterval)duration scaleX:(float)sx block:(void(^)(void))block;

+ (id)actionWithDuration:(CFTimeInterval)duration scaleY:(float)sy block:(void(^)(void))block;

- (id)initWithDuration:(CFTimeInterval)duration scaleY:(float)sy block:(void(^)(void))block;


@end

@interface SSFade : SSAction

/**
 *	fade 透明度
 *	@param	duration	时间
 *	@param	op	透明度
 *
 *	@return	action
 */
+ (id)actionDuration:(CFTimeInterval)duration fopacity:(float)fop topacity:(float)top block:(void(^)(void))block;

- (id)initWithDuration:(CFTimeInterval)duration fopacity:(float)fop topacity:(float)top block:(void(^)(void))block;

@end

@interface SSFadeIn : SSAction

/**
 *	fade in 透明度 current opactiy->1
 *
 *	@param	duration	时间
 *
 *	@return	action
 */
+ (id)actionWithDuration:(CFTimeInterval)duration block:(void(^)(void))block;

- (id)initWithDuration:(CFTimeInterval)duration block:(void(^)(void))block;

@end

@interface SSFadeOut : SSAction

/**
 *	fade out 透明度 current opacity->0
 *
 *	@param	duration	时间
 *
 *	@return	action
 */
+ (id)actionWithDuration:(CFTimeInterval)duration block:(void(^)(void))block;

- (id)initWithDuration:(CFTimeInterval)duration block:(void(^)(void))block;

@end


@interface SSDelayTime : SSAction

/**
 *	delaytime 延迟时间
 *
 *	@param	duration 时间
 *
 *	@return	action
 */
+ (id)actionWithDuration:(CFTimeInterval)duration block:(void (^)(void))block;

- (id)initWithDuration:(CFTimeInterval)duration block:(void (^)(void))block;

@end


@interface SSSequence : SSAction

+ (id)actionsWithBlock:(void (^)(void))block action:(SSAction *)action1,... NS_REQUIRES_NIL_TERMINATION;
+ (id)actionWithArray: (NSArray*) arrayOfActions block:(void (^)(void))block;
@end

@interface SSRepeat : SSAction

+ (id)actionWithAction:(SSAction *)action times:(NSUInteger)times block:(void (^)(void))block;

- (id)initWithAction:(SSAction *)action times:(NSUInteger)times block:(void (^)(void))block;

@end


@interface SSSpawn : SSAction

+ (id)actions:(SSAction *)action1, ... NS_REQUIRES_NIL_TERMINATION;
+ (id)actionWithArray: (NSArray*) arrayOfActions;

@end







