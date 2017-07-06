//
//  UITableViewController+XLScroll.h
//  XLNetEaseStudy
//
//  Created by xl on 17/7/6.
//  Copyright © 2017年 xl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XLStudyChildVCDelegate <NSObject>

- (void)childVc:(UIViewController *)childVc scrollViewDidScroll:(UIScrollView *)scroll;

@end

@interface UIViewController (XLScroll)

/** 初始化，必须在对应VC中实现该方法*/
- (void)setupScroll;
/** 改变VC中的scroll偏移量*/
- (void)setCurrentScrollContentOffsetY:(CGFloat)offsetY;
@end
