//
//  PKTableViewItem.h
//  PKTableView
//
//  Created by zhongsheng on 13-4-16.
//  Copyright (c) 2013年 icePhone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKTableViewItem : NSObject

@property (nonatomic, assign) float cellHeight;	// 缓存cell的高度,主要用于高度可变的cell

@property (nonatomic, strong) id userInfo;		// 用户数据

@end
