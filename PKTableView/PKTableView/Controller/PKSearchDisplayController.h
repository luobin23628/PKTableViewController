//
//  PKSearchDisplayController.h
//  PKTableView
//
//  Created by zhongsheng on 13-4-16.
//  Copyright (c) 2013年 icePhone. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PKTableViewController;

@protocol PKSearchDisplayControllerDelegate <NSObject>
@optional
- (void)willBeginSearch;
- (void)willEndSearch;
- (void)willHideSearchResult;
- (void)didShowResult;
@end

@interface PKSearchDisplayController : UISearchDisplayController<UISearchDisplayDelegate>

@property (nonatomic, strong) PKTableViewController* searchResultsViewController;


@end
