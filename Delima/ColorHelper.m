//
//  ColorHelper.m
//  Delima
//
//  Created by Arie Prasetyo on 12/6/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "ColorHelper.h"

@implementation UIColor (ColorHelper)

+ (UIColor *)delimaRedColor {
    return [UIColor colorWithRed:204.0 / 255.0
                           green:51.0 / 255.0
                            blue:51.0 / 255.0
                           alpha:1.0];
}

+ (UIColor *)delimaGrayColor {
    return [UIColor colorWithRed:178 / 255.0
                           green:178 / 255.0
                            blue:178 / 255.0
                           alpha:1.0];
}

+ (UIColor *)delimaDarkRedColor {
    return [UIColor colorWithRed:187.0 / 255.0
                           green:20.0 / 255.0
                            blue:24.0 / 255.0
                           alpha:1.0];
}

+ (UIColor *)delimaYellowColor {
    return [UIColor colorWithRed:254.0 / 255.0
                           green:215.0 / 255.0
                            blue:34.0 / 255.0
                           alpha:1.0];
}

+ (UIColor *)delimaGreenColor {
    return [UIColor colorWithRed:110.0 / 255.0
                           green:207.0 / 255.0
                            blue:67.0 / 255.0
                           alpha:1.0];
}

+ (UIColor *)delimaBlueColor {
    return [UIColor colorWithRed:8.0 / 255.0
                           green:76.0 / 255.0
                            blue:152.0 / 255.0
                           alpha:1.0];
}

+ (UIColor *)delimaDarkGrayColor {
    return [UIColor colorWithRed:71.0 / 255.0
                           green:70.0 / 255.0
                            blue:70.0 / 255.0
                           alpha:1.0];
}

+ (UIColor *)delimaLightGrayColor {
    return [UIColor colorWithRed:212.0 / 255.0
                           green:210.0 / 255.0
                            blue:210.0 / 255.0
                           alpha:1.0];
}
+ (UIColor *)delimaSuperLightGrayColor{
    return [UIColor colorWithRed:0.937 green:0.937 blue:0.937 alpha:1];
    /*#efefef*/
}
+(UIColor *)delimaF7Color{
    return [UIColor colorWithRed:0.969 green:0.969 blue:0.969 alpha:1] /*#f7f7f7*/;
}

@end
