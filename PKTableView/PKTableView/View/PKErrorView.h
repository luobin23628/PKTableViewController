//
//  PKErrorView.h
//  PKTableView
//
//  Created by zhongsheng on 13-4-16.
//  Copyright (c) 2013年 icePhone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PKErrorView : UIView

@property (nonatomic, strong) UIImage*  image;
@property (nonatomic, strong) UIImage*  titleImage;
@property (nonatomic, copy)   NSString* title;
@property (nonatomic, copy)   NSString* subtitle;

- (id)initWithTitle:(NSString*)title subtitle:(NSString*)subtitle image:(UIImage*)image;
- (id)initWithTitle:(NSString*)title subtitle:(NSString*)subtitle titleImage:(UIImage*)tImage watermarkImage:(UIImage *)wImage;
- (void)addTarget:(id)target action:(SEL)action;// forControlEvents:(UIControlEvents)controlEvents;

@end
