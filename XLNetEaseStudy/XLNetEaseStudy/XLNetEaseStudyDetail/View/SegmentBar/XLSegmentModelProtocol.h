//
//  XLSementModelProtocol.h
//  XLNetEaseStudy
//
//  Created by xl on 17/7/5.
//  Copyright © 2017年 xl. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XLSegmentModelProtocol <NSObject>

/** segment内容*/
@property (nonatomic,copy,readonly) NSString *segmentTitle;
@optional;
/** segment选中颜色*/
@property (nonatomic,strong,readonly) UIColor *selectedColor;
/** segment正常颜色*/
@property (nonatomic,strong,readonly) UIColor *normalColor;

@end
