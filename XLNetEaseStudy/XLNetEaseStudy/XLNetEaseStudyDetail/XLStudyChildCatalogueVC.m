//
//  XLStudyChildCatalogueVC.m
//  XLNetEaseStudy
//
//  Created by xl on 17/7/6.
//  Copyright © 2017年 xl. All rights reserved.
//

#import "XLStudyChildCatalogueVC.h"
#import "UIViewController+XLScroll.h"

@interface XLStudyChildCatalogueVC ()

@end

@implementation XLStudyChildCatalogueVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupScroll];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@%zd", self.title,indexPath.row];
    return cell;
}
@end
