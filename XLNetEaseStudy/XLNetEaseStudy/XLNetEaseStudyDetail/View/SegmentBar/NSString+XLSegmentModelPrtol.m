//
//  NSString+XLSegmentModelPrtol.m
//  XLNetEaseStudy
//
//  Created by xl on 17/7/5.
//  Copyright © 2017年 xl. All rights reserved.
//

#import "NSString+XLSegmentModelPrtol.h"

@implementation NSString (XLSegmentModelPrtol)

- (NSString *)segmentTitle {
    return self;
}

/*** 为了简单，实现这2个协议方法，真实开发中，需放到对应Model中实现 */
- (UIColor *)selectedColor {
    return [UIColor colorWithRed:42/255.0 green:184/255.0 blue:104/255.0 alpha:1.0];
}
- (UIColor *)normalColor {
    return [UIColor darkGrayColor];
}
@end
