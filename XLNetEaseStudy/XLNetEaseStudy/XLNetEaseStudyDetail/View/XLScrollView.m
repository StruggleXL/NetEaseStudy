//
//  XLScrollView.m
//  XLNetEaseStudy
//
//  Created by xl on 17/7/7.
//  Copyright © 2017年 xl. All rights reserved.
//

#import "XLScrollView.h"

@interface XLScrollView ()

@property (nonatomic,assign) CGPoint currentPoint;
@end

@implementation XLScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupTouches];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupTouches];
    }
    return self;
}
- (void)setupTouches {
    // 取消子试图延迟响应
    self.delaysContentTouches = NO;
    self.canCancelContentTouches = YES;
}

/** 重写此方法，控制scroll是否可滑动*/
- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    if ([view isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)view;
        if (tableView.tableHeaderView) {
            // 当点击的区域在tableView头视图时，禁止scroll滑动
            return !CGRectContainsPoint(tableView.tableHeaderView.frame, self.currentPoint);
        }
        return YES;
    } else if ([view isMemberOfClass:[UITableViewHeaderFooterView class]] || [view isKindOfClass:NSClassFromString(@"_UITableViewHeaderFooterContentView")]) {
        return NO;
    }
    return YES;
}
- (BOOL)touchesShouldBegin:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event inContentView:(UIView *)view {
    /** 获取当前触摸的位置*/
    CGPoint point = [[touches anyObject]locationInView:view];
    self.currentPoint = point;
    return YES;
}

@end
