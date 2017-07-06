//
//  XLStudyChildBaseVC.m
//  XLNetEaseStudy
//
//  Created by xl on 17/7/6.
//  Copyright © 2017年 xl. All rights reserved.
//

#import "XLStudyChildBaseVC.h"
#import "XLConst.h"

@interface XLStudyChildBaseVC ()

@end

@implementation XLStudyChildBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, headerImgH + barH)];;
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(headerImgH + barH, 0, 0, 0);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(childVc:scrollViewDidScroll:)]) {
        [self.delegate childVc:self scrollViewDidScroll:scrollView.contentOffset.y];
    }
}

- (void)setCurrentScrollContentOffsetY:(CGFloat)offsetY {
    [self.tableView setContentOffset:CGPointMake(0, offsetY)];
}
@end
