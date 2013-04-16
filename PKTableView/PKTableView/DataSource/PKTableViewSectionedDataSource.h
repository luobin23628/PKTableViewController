//
//  PKTableViewSectionedDataSource.h
//  PKTableView
//
//  Created by zhongsheng on 13-4-16.
//  Copyright (c) 2013年 icePhone. All rights reserved.
//

#import "PKTableViewDataSource.h"

@interface PKTableViewSectionedDataSource : PKTableViewDataSource

@property (nonatomic, strong) NSMutableArray *sections;			// RSSectionObject对象数组
@property (nonatomic,   weak) NSMutableArray *firstSectionItems;	// 返回第一个section的items数组

@end
