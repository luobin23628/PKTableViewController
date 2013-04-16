//
//  PKTableViewCell.m
//  PKTableView
//
//  Created by zhongsheng on 13-4-16.
//  Copyright (c) 2013年 icePhone. All rights reserved.
//

#import "PKTableViewCell.h"

@implementation PKTableViewCell

@synthesize object = _object;
@synthesize indexPath;

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    return 44;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setObject:(id)object {
    if (object != _object) {
        if (_object != nil) {
            [self finishObserveObjectProperty];
        }
        
        _object = object;
        if (_object != nil)
            [self startObserveObjectProperty];
    }
}

#pragma mark Object Property Observer

- (void)startObserveObjectProperty {
    
}

- (void)finishObserveObjectProperty {
    
}

- (void)addObservedProperty:(NSString *)property {
    [_object addObserver:self forKeyPath:property
                 options:NSKeyValueObservingOptionNew
                 context:nil];
}

- (void)removeObservedProperty:(NSString *)property {
    [_object removeObserver:self forKeyPath:property];
}

- (void)objectPropertyChanged:(NSString *)property {
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object != _object) {
        [object removeObserver:self forKeyPath:keyPath];
    }
    else {
        [self objectPropertyChanged:keyPath];
    }
}

@end
