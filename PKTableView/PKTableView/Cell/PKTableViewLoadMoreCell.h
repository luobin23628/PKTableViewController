//
//  PKTableViewLoadMoreCell.h
//  PKTableView
//
//  Created by zhongsheng on 13-4-16.
//  Copyright (c) 2013年 icePhone. All rights reserved.
//

#import "PKTableViewCell.h"

@interface PKTableViewLoadMoreCell : PKTableViewCell

@property (nonatomic, assign) BOOL animating;

- (void)resetLoadingAnimationView:(UIActivityIndicatorView*)loadingView;

@end
