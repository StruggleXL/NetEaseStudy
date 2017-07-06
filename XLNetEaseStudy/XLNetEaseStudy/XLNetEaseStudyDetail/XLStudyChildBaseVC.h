//
//  XLStudyChildBaseVC.h
//  XLNetEaseStudy
//
//  Created by xl on 17/7/6.
//  Copyright © 2017年 xl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XLStudyChildVCDelegate <NSObject>

- (void)childVc:(UIViewController *)childVc scrollViewDidScroll:(CGFloat)offsetY;

@end

@interface XLStudyChildBaseVC : UITableViewController

@property (nonatomic,assign) id<XLStudyChildVCDelegate>delegate;
/** 改变当前vc中scroll的偏移量*/
- (void)setCurrentScrollContentOffsetY:(CGFloat)offsetY;
@end
