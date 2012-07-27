//
//  TestTableViewItem.m
//  TDSTableViewController
//
//  Created by zhong sheng on 12-7-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TestTableViewItem.h"

@implementation TestTableViewItem
@synthesize text;
@synthesize image;
+ (TestTableViewItem *)itemWithText:(NSString *)string
{
    return [TestTableViewItem itemWithText:string image:[UIImage imageNamed:@"logo.png"]];
}
+ (TestTableViewItem *)itemWithText:(NSString *)string image:(UIImage *)image
{
    TestTableViewItem *item = [[TestTableViewItem alloc] init];
    item.text = string;
    item.image = image;
    return [item autorelease];
}
@end
