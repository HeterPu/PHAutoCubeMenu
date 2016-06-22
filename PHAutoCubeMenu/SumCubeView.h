//
//  SumCubeView.h
//  HuiJing
//
//  Created by Peter on 6/21/16.
//  Copyright © 2016 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SumCubeView : UIView

// input array;
@property(nonatomic,strong)NSArray *titleImageArray;

-(void)setCubeView;
-(void)saveChangeToPlist;

@end
