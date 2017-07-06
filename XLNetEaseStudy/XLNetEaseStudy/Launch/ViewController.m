//
//  ViewController.m
//  XLNetEaseStudy
//
//  Created by xl on 17/7/5.
//  Copyright © 2017年 xl. All rights reserved.
//

#import "ViewController.h"
#import "XLTestVC.h"
#import "XLNetEaseStudyDetailVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)demoClick:(id)sender {
    XLTestVC *test = [XLTestVC new];
    [self.navigationController pushViewController:test animated:YES];
}

- (IBAction)btnClick:(id)sender {
    XLNetEaseStudyDetailVC *detail = [XLNetEaseStudyDetailVC new];
    [self.navigationController pushViewController:detail animated:YES];
}



@end
