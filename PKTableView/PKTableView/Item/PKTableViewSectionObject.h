//
//  PKTableViewSectionObject.h
//  PKTableView
//
//  Created by zhongsheng on 13-4-16.
//  Copyright (c) 2013年 icePhone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKTableViewSectionObject : NSObject
@property (nonatomic, strong) id userInfo;
@property (nonatomic, copy) NSString *letter;
@property (nonatomic, copy) NSString *headerTitle;
@property (nonatomic, copy) NSString *footerTitle;
@property (nonatomic, strong) NSMutableArray *items;
@end
