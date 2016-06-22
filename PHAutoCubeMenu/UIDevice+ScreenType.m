//
//  UIDevice+ScreenType.m
//  HuiJing
//
//  Created by Peter on 6/22/16.
//  Copyright © 2016 Peter. All rights reserved.
//

#import "UIDevice+ScreenType.h"

@implementation UIDevice (ScreenType)



+(ScreenType)getScreenType {
    
    NSInteger screenheight = (int)[UIScreen mainScreen].bounds.size.height;
    switch (screenheight) {
        case  480:
            return ScreenType320x480;
        case  568:
            return ScreenType320x568;
        case  667:
            return ScreenType375x667;
        case  736:
            return ScreenType414x736;
        case  1024:
            return ScreenType768x1024;
        default:
            return ScreenType375x667;
    }
}


@end
