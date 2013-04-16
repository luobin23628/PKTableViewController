//
//  PKTableViewSectionObject.m
//  PKTableView
//
//  Created by zhongsheng on 13-4-16.
//  Copyright (c) 2013年 icePhone. All rights reserved.
//

#import "PKTableViewSectionObject.h"

@implementation PKTableViewSectionObject
@synthesize userInfo = _userInfo;
@synthesize letter = _letter;
@synthesize headerTitle = _headerTitle;
@synthesize footerTitle = _footerTitle;
@synthesize items = _items;

// 初始化一发
- (NSMutableArray *)items
{
    if (!_items)
    {
        _items = [[NSMutableArray alloc] init];
    }
    return _items;
}

@end
