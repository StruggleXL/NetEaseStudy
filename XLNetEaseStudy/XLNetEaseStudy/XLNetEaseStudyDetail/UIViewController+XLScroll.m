//
//  UITableViewController+XLScroll.m
//  XLNetEaseStudy
//
//  Created by xl on 17/7/6.
//  Copyright © 2017年 xl. All rights reserved.
//

#import "UIViewController+XLScroll.h"
#import "XLConst.h"

@implementation UIViewController (XLScroll)

- (void)setupScroll {
    if ([self isKindOfClass:[UITableViewController class]]) {
        UITableViewController *tableVC = (UITableViewController *)self;
        tableVC.tableView.tableHeaderView = [[UITableViewHeaderFooterView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, headerImgH + barH)];;
        tableVC.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(headerImgH + barH, 0, 0, 0);
        tableVC.tableView.delaysContentTouches = NO;
        tableVC.tableView.canCancelContentTouches = YES;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.parentViewController && [self.parentViewController respondsToSelector:@selector(childVc:scrollViewDidScroll:)]) {
        [self.parentViewController performSelector:@selector(childVc:scrollViewDidScroll:) withObject:self withObject:scrollView];
    }
}

- (void)setCurrentScrollContentOffsetY:(CGFloat)offsetY {
    if ([self isKindOfClass:[UITableViewController class]]) {
        UITableViewController *tableVC = (UITableViewController *)self;
        [tableVC.tableView setContentOffset:CGPointMake(0, offsetY)];
    }
}
@end
