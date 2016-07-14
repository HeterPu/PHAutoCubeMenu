//
//  CubeView.h
//  HuiJing
//
//  Created by Peter on 6/20/16.
//  Copyright © 2016 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CubeView;

/**
 *  立方体触摸事件代理
 */
@protocol CubeTouchEventDelegate <NSObject>
/**
 *  触摸开始
 *
 *  @param cube  立方体视图
 *  @param point 触摸开始时相对父视图的位置
 */
-(void)cubeTouchBeganWith:(CubeView *)cube
              andPosition:(CGPoint)point;
/**
 *  触摸移动
 *
 *  @param cube  立方体视图
 *  @param point 触摸移动时相对父视图的位置
 */
-(void)cubeTouchMoveWith:(CubeView *)cube
             andPosition:(CGPoint)point;
/**
 *  触摸结束
 *
 *  @param cube  立方体视图
 *  @param point 触摸结束时相对父视图的位置
 */
-(void)cubeTouchEndWith:(CubeView *)cube
            andPosition:(CGPoint)point;
@end


/**
 *  立方体长按事件代理(可选)
 */
@protocol CubeTapEventDelegate <NSObject>
@optional
-(void)longPressEvent:(CubeView *)cube;
-(void)doubleTapEvent:(CubeView *)cube;
-(void)singleTapEvent:(CubeView *)cube;

@end


@interface CubeView : UIView

@property (nonatomic,weak) id<CubeTouchEventDelegate> delegate1;
@property (nonatomic,weak) id<CubeTapEventDelegate> delegate2;

/**
 *  标签名称
 */
@property(nonatomic,copy)NSString *labelName;
/**
 *  图片名称
 */
@property(nonatomic,copy)NSString *iconName;
/**
 *  是否可拖拽
 */
@property(nonatomic,assign)BOOL isRDragble;


/**
 *  设置TITLE和图片名称
 *
 *  @param title 标题名称
 *  @param name  图片名称
 */
-(void)setTitle:(NSString *)title andImageName:(NSString *)name;


/**
 *  获取实例对象
 *
 *  @return <#return value description#>
 */
+(CubeView *)instanceCubeView;


/**
 *  设置CUBE动画缩放
 */
-(void)setShrinkAnimated;

@end
