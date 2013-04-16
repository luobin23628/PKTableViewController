//
//  PKTableViewLoadMoreItem.m
//  PKTableView
//
//  Created by zhongsheng on 13-4-16.
//  Copyright (c) 2013年 icePhone. All rights reserved.
//

#import "PKTableViewLoadMoreItem.h"

@implementation PKTableViewLoadMoreItem
@synthesize isLoading = _isLoading;
@synthesize title = _title;

+ (PKTableViewLoadMoreItem *)itemWithTitle:(NSString *)title
{
	PKTableViewLoadMoreItem *item = [[PKTableViewLoadMoreItem alloc] init];
	item.title = title;
	return item;
}

@end
