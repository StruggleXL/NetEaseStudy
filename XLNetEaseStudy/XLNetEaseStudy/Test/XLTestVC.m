//
//  XLTestVC.m
//  XLNetEaseStudy
//
//  Created by xl on 17/7/6.
//  Copyright © 2017年 xl. All rights reserved.
//

#import "XLTestVC.h"
#import "XLSegmentBar.h"

CGFloat const navBarH = 64.0f;
CGFloat const headerImgH = 210.0f;
CGFloat const barH = 44.0f;

@interface XLTestVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,weak) UIImageView *header;
@property (nonatomic,weak) XLSegmentBar *bar;
@end

@implementation XLTestVC

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"单个tableViewDemo";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置tableHeaderView为了让tableView显示数据源的位置向下偏移
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, headerImgH + barH)];
    // 设置滚动条向下偏移为了和显示的数据源位置对应
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(headerImgH + barH, 0, 0, 0);
    
    self.header.frame = CGRectMake(0, navBarH, self.view.bounds.size.width, headerImgH);

    self.bar.frame = CGRectMake(0, navBarH + headerImgH, self.view.bounds.size.width, barH);
    
}
#pragma mark - tableDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"数据%ld",indexPath.row];
    return cell;
}
#pragma mark - delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGRect headerFrame = self.header.frame;
    headerFrame.origin.y = navBarH - offsetY;
    // header上滑到导航条位置时，固定
    if (headerFrame.origin.y <= -(headerImgH - navBarH)) {
        headerFrame.origin.y = -(headerImgH - navBarH);
    }
    // header向下滑动时，固定
    else if (headerFrame.origin.y >= navBarH) {
        headerFrame.origin.y = navBarH;
    }
    self.header.frame = headerFrame;
    
    CGRect barFrame = self.bar.frame;
    barFrame.origin.y = CGRectGetMaxY(self.header.frame);
    self.bar.frame = barFrame;
    
}

#pragma mark - lazy
- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, navBarH, self.view.bounds.size.width, self.view.bounds.size.height - navBarH) style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}
- (UIImageView *)header {
    if (!_header) {
        UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"header.jpg"]];
        image.contentMode = UIViewContentModeScaleAspectFill;
        [self.view addSubview:image];
        _header = image;
    }
    return _header;
}

- (XLSegmentBar *)bar {
    if (!_bar) {
        XLSegmentBar *bar = [[XLSegmentBar alloc]initWithSegmentModels:@[@"介绍"]];
        bar.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:bar];
        _bar = bar;
    }
    return _bar;
}
@end
