//
//  RSSectionObject.m
//  icePhone
//
//  Created by zhong sheng on 12-5-31.
//  Copyright (c) 2012年 icePhone. All rights reserved.
//

#import "TDSTableViewSectionObject.h"

@implementation TDSTableViewSectionObject
@synthesize letter = _letter;
@synthesize title = _title;
@synthesize userInfo = _userInfo;
@synthesize items = _items;
@synthesize footerTitle = _footerTitle;

- (void)dealloc{
    self.letter = nil;
    self.title = nil;
    self.userInfo = nil;
    self.items = nil;
    self.footerTitle = nil;
    [super dealloc];
}


@end
