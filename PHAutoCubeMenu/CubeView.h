//
//  CubeView.h
//  HuiJing
//
//  Created by Peter on 6/20/16.
//  Copyright © 2016 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CubeView;

@protocol CubeTouchEventDelegate <NSObject>

-(void)cubeTouchBeganWith:(CubeView *)cube andPosition:(CGPoint)point;
-(void)cubeTouchMoveWith:(CubeView *)cube andPosition:(CGPoint)point;
-(void)cubeTouchEndWith:(CubeView *)cube andPosition:(CGPoint)point;

@end

@protocol CubeTapEventDelegate <NSObject>

@optional
-(void)longPressEvent:(CubeView *)cube;
-(void)doubleTapEvent:(CubeView *)cube;
-(void)singleTapEvent:(CubeView *)cube;

@end


@interface CubeView : UIView

@property (nonatomic,weak) id<CubeTouchEventDelegate> delegate1;
@property (nonatomic,weak) id<CubeTapEventDelegate> delegate2;

@property(nonatomic,copy)NSString *labelName;
@property(nonatomic,copy)NSString *iconName;
@property(nonatomic,assign)BOOL isRDragble;

-(void)setTitle:(NSString *)title andImageName:(NSString *)name;

+(CubeView *)instanceCubeView;

-(void)setShrinkAnimated;





@end
