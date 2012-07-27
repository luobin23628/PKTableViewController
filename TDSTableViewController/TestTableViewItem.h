//
//  TestTableViewItem.h
//  TDSTableViewController
//
//  Created by zhong sheng on 12-7-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TDSTableViewItem.h"

@interface TestTableViewItem : TDSTableViewItem
@property (nonatomic, copy  ) NSString *text;
@property (nonatomic, retain) UIImage *image;
+ (TestTableViewItem *)itemWithText:(NSString *)string;
+ (TestTableViewItem *)itemWithText:(NSString *)string image:(UIImage *)image;
@end
