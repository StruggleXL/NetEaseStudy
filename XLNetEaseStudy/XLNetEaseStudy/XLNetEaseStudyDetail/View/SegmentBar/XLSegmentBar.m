//
//  XLSegmentBar.m
//  ReadPSY
//
//  Created by xl on 16/10/19.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "XLSegmentBar.h"
#import "NSString+XLSegmentModelPrtol.h"

CGFloat const btnMinWidth = 80.0f;

@interface XLSegmentBar ()

@property (nonatomic,strong) UIScrollView *btnScroll;
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic,strong) NSMutableArray *btns;
@property (nonatomic, weak) UIButton *lastBtn;

@end

@implementation XLSegmentBar


#pragma mark - life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupUI];
    }
    return self;
}
- (instancetype)initWithSegmentModels:(NSArray< id<XLSegmentModelProtocol>> *)segmentModels {
    if (self = [super init]) {
        self.segmentModels = segmentModels;
    }
    return self;
}

- (void)setupUI {
    UIScrollView *btnScroll = [[UIScrollView alloc]init];
    // 设置这2个属性为NO
    btnScroll.showsHorizontalScrollIndicator = NO;
    btnScroll.showsVerticalScrollIndicator = NO;
    [self addSubview:btnScroll];
    self.btnScroll = btnScroll;
}

- (UIView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc] init];
        [self.btnScroll addSubview:_indicatorView];
    }
    return _indicatorView;
}
- (NSMutableArray *)btns {
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.bounds.size.width>0) {
        if ([self.superview isKindOfClass:[UINavigationBar class]]) {
            // 如果将此试图放到导航栏上（titleView），当设置titleView为最大宽度时，导航条会左右空余8点像素,plus为12
            CGFloat navTitleViewMargin = [UIScreen mainScreen].scale > 2.1 ? 12 :8;
             self.btnScroll.frame = CGRectMake(-navTitleViewMargin, 0, self.bounds.size.width+navTitleViewMargin*2, self.bounds.size.height);
        } else {
            self.btnScroll.frame = self.bounds;
        }
        
        if (self.btns.count > 0) {
            CGFloat labelW = self.btnScroll.bounds.size.width/self.btns.count > btnMinWidth ?self.btnScroll.bounds.size.width/self.btns.count: btnMinWidth;
            CGFloat labelY = 0;
            CGFloat labelH = self.btnScroll.bounds.size.height;
            for (int i = 0; i < self.btns.count; i++) {
                UIButton *btn = self.btns[i];
                CGFloat labelX = i * labelW;
                btn.frame = CGRectMake(labelX, labelY, labelW, labelH);
            }
            self.btnScroll.contentSize = CGSizeMake(self.btns.count * labelW, 0);
        }
        
        if (self.lastBtn) {
            [self updateIndicatorFrame];
        }
    }
    
}
/** 刷新横线位置*/
- (void)updateIndicatorFrame {
    NSString *text = self.lastBtn.titleLabel.text;
    self.indicatorView.backgroundColor = [self.lastBtn titleColorForState:UIControlStateSelected];
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName : self.lastBtn.titleLabel.font}];
    CGFloat indicatorW = size.width + 20;
    CGFloat indicatorH = 1.5;
    CGFloat indicatorY = self.btnScroll.bounds.size.height - indicatorH;
    self.indicatorView.frame = CGRectMake(0, indicatorY, indicatorW, indicatorH);
    CGPoint center = self.indicatorView.center;
    center.x = self.lastBtn.center.x;
    self.indicatorView.center = center;
}
#pragma mark - setter
-(void)setSegmentModels:(NSArray<id<XLSegmentModelProtocol>> *)segmentModels {
    _segmentModels = segmentModels;
    if (segmentModels.count > 0) {
        self.btns = nil;
        self.lastBtn = nil;
        [self.btnScroll.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.indicatorView removeFromSuperview];
        self.indicatorView = nil;
        // 添加btn
        for (NSInteger i = 0; i < segmentModels.count; i++) {
            id<XLSegmentModelProtocol> model = segmentModels[i];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn setTitleColor:model.normalColor forState:UIControlStateNormal];
            [btn setTitleColor:model.selectedColor forState:UIControlStateSelected];
            [btn setTitle:model.segmentTitle forState:UIControlStateNormal];
            btn.tag = i;
            [self.btnScroll addSubview:btn];
            [self.btns addObject:btn];
        }
        [self layoutIfNeeded];
        
        // 默认选择第0个
        [self btnClick:self.btns.firstObject];
    }
    
}
- (void)setChangeIndex:(NSInteger)changeIndex {
    _changeIndex = changeIndex;
    [self changeMenuScrollOffset:changeIndex];
}
- (void)changeMenuScrollOffset:(NSInteger)index{
    // 让对应的顶部标题居中显示
    UIButton *btn = self.btnScroll.subviews[index];
    if (self.btnScroll.contentSize.width > self.btnScroll.bounds.size.width) {
        CGPoint titleOffset = self.btnScroll.contentOffset;
        titleOffset.x = btn.center.x - self.bounds.size.width * 0.5;
        // 左边超出处理
        if (titleOffset.x < 0) titleOffset.x = 0;
        // 右边超出处理
        CGFloat maxTitleOffsetX = self.btnScroll.contentSize.width - self.bounds.size.width;
        if (titleOffset.x > maxTitleOffsetX) titleOffset.x = maxTitleOffsetX;
        
        [self.btnScroll setContentOffset:titleOffset animated:YES];
    }
    // 修改选中状态
    self.lastBtn.selected = NO;
    btn.selected = YES;
    self.lastBtn = btn;
    
    // 移动横线位置
    if (CGRectEqualToRect(self.indicatorView.frame, CGRectZero)) {
        [self updateIndicatorFrame];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            [self updateIndicatorFrame];
        }];
    }
    
}

#pragma mark - 点击事件
- (void)btnClick:(UIButton *)tap {
    NSInteger index = tap.tag;
    [self changeMenuScrollOffset:index];
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentBar:tapIndex:)]) {
        [self.delegate segmentBar:self tapIndex:index];
    }
}
@end
