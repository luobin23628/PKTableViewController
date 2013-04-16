//
//  PKTableViewLoadMoreItem.h
//  PKTableView
//
//  Created by zhongsheng on 13-4-16.
//  Copyright (c) 2013年 icePhone. All rights reserved.
//

#import "PKTableViewItem.h"

@interface PKTableViewLoadMoreItem : PKTableViewItem

@property (nonatomic, assign) BOOL          isLoading;
@property (nonatomic, strong) NSString		*title;

+ (PKTableViewLoadMoreItem *)itemWithTitle:(NSString *)title;

@end
