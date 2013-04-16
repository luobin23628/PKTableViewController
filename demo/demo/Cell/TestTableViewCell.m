//
//  TestTableViewCell.m
//  PKTableViewController
//
//  Created by zhong sheng on 12-7-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TestTableViewCell.h"
#import "TestTableViewItem.h"

@implementation TestTableViewCell
@synthesize headerImgView = _headerImgView;
@synthesize testLabel = _testLabel;
+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object {
	return 50.0f;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.headerImgView.image = nil;
    self.detailTextLabel.text = nil;
}
- (void)setObject:(id)object {
    [super setObject:object];
    if (object == nil) return;
    
    TestTableViewItem* tableItem = (TestTableViewItem*)object;
    
    if (tableItem.text != nil && ![tableItem.text isEqualToString:@""]) {
        if (!_testLabel) {
            _testLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 5.0, 200, 40)];
            _testLabel.font = [UIFont boldSystemFontOfSize:18.0f];
            _testLabel.textColor = [UIColor blackColor];
            [self.contentView addSubview:_testLabel];
        }
        _testLabel.text = tableItem.text;
    }
    if (!_headerImgView) {
        _headerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, 5.0, 40, 40)];
        _headerImgView.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:_headerImgView];
    }
    if (tableItem.image != nil) {        
        self.headerImgView.image = tableItem.image;
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryNone;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
}
@end
