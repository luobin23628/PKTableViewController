//
//  TDSViewController.m
//  icePhone
//
//  Created by zhong sheng on 12-6-5.
//  Copyright (c) 2012年 icePhone. All rights reserved.
//

#import "TDSViewController.h"

@implementation TDSViewController

- (void)dealloc 
{
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self createModel];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark - public
- (void)createModel
{}
@end
