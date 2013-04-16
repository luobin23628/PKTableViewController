//
//  PKTableViewCell.h
//  PKTableView
//
//  Created by zhongsheng on 13-4-16.
//  Copyright (c) 2013年 icePhone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PKTableViewCell : UITableViewCell
{
    id _object;
}

@property (nonatomic, strong) id		object;
@property (nonatomic, copy) NSIndexPath *indexPath;

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object;


//object属性observer相关
/*开始监听object属性,在subclass中通过该方法可自定义添加监听的属性*/
- (void)startObserveObjectProperty;
/*清除监听,在subclass中应该清除已添加的属性*/
- (void)finishObserveObjectProperty;

/*监听一个属性*/
- (void)addObservedProperty:(NSString *)property;
/*移出监听*/
- (void)removeObservedProperty:(NSString *)property;

@end
