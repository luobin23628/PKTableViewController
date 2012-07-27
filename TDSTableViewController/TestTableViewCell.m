//
//  TestTableViewCell.m
//  TDSTableViewController
//
//  Created by zhong sheng on 12-7-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TestTableViewCell.h"
#import "TestTableViewItem.h"

@implementation TestTableViewCell
@synthesize headerImgView = _headerImgView;
+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object {
	return 50.0f;
}

- (void) layoutSubviews {
	[super layoutSubviews];
    self.backgroundColor = [UIColor clearColor];
}

- (void)setObject:(id)object {
    [super setObject:object];
    if (object == nil) return;
    
    TestTableViewItem* tableItem = (TestTableViewItem*)object;
    
    if (tableItem.text != nil && ![tableItem.text isEqualToString:@""]) {
        self.detailTextLabel.text = tableItem.text;
        self.detailTextLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        self.detailTextLabel.textColor = [UIColor blackColor];//[[RSResManager getInstance] colorForKey:@"colorOfNavigationBtnItem"];
    }      
    if (tableItem.image != nil) {
        if (!_headerImgView) {
            _headerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(80.0, 5.0, 40, 40)];
            [self.contentView addSubview:_headerImgView];
        }
        self.headerImgView.image = tableItem.image;
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryNone;
}

@end
