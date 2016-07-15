//
//  SumCubeView.h
//  HuiJing
//
//  Created by Peter on 6/21/16.
//  Copyright © 2016 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 Attention:
 在使用菜单时不要使用NSBUNDLE里的plist，在真机调试时会变成只读状态，无法修改，
 所以先在appdelegate中将NSBUNDLE的plist保存在硬盘中或者利用网络加载。
 
 */


@interface SumCubeView : UIView

/**
 *  包装image和title的数组
 */
@property(nonatomic,strong)NSArray *titleImageArray;

/**
 *  安装初始化Cube视图
 */
-(void)setCubeView;

/**
 *  保存布局到PLIST文件
 */
-(void)saveChangeToPlist;

@end
