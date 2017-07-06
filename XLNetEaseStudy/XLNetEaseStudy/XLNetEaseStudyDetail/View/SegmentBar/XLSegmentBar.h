//
//  XLSegmentBar.h
//  ReadPSY
//
//  Created by xl on 16/10/19.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLSegmentModelProtocol.h"
@class XLSegmentBar;

@protocol XLSegmentBarDelegate <NSObject>

- (void)segmentBar:(XLSegmentBar *)segmentBar tapIndex:(NSInteger)index;

@end

@interface XLSegmentBar : UIView

@property (nonatomic,weak) id<XLSegmentBarDelegate> delegate;

@property (nonatomic, assign) NSInteger changeIndex;

@property (nonatomic,strong) NSArray< id<XLSegmentModelProtocol>> *segmentModels;
- (instancetype)initWithSegmentModels:(NSArray< id<XLSegmentModelProtocol>> *)segmentModels;

@end
