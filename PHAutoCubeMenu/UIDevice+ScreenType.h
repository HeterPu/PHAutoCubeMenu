//
//  UIDevice+ScreenType.h
//  HuiJing
//
//  Created by Peter on 6/22/16.
//  Copyright © 2016 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ScreenType) {
    ScreenType320x480 = 1 ,
    ScreenType320x568,
    ScreenType375x667,
    ScreenType414x736,
    
    ScreenType768x1024,
};

@interface UIDevice (ScreenType)


+(ScreenType)getScreenType;


@end
