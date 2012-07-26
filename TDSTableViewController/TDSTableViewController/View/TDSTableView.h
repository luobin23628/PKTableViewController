//
//  RSCTableView.h
//  icePhone
//
//  Created by zhong sheng on 12-5-28.
//  Copyright (c) 2012年 icePhone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDSTableView : UITableView{
@private
    
    CGFloat             _contentOrigin;
    
    BOOL _showShadows;
    
    CAGradientLayer* _originShadow;
    CAGradientLayer* _topShadow;
    CAGradientLayer* _bottomShadow;
}

@property (nonatomic)         CGFloat             contentOrigin;
@property (nonatomic)         BOOL                showShadows;

@end

//@protocol RSTableViewDelegate <UITableViewDelegate>
//
//- (void)tableView:(UITableView*)tableView touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event;
//- (void)tableView:(UITableView*)tableView touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event;
//
//@end
