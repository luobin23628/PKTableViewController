//
//  TestTableViewDataSource.m
//  PKTableViewController
//
//  Created by zhong sheng on 12-6-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TestTableViewDataSource.h"
#import "TestTableViewItem.h"
#import "TestTableViewCell.h"

@implementation TestTableViewDataSource

- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)object
{
    if ([object isKindOfClass:[TestTableViewItem class]]) {
        return [TestTableViewCell class];
    }
    return [super tableView:tableView cellClassForObject:object];
}

- (NSString*)titleForError:(NSError*)error{
    return @"title error";
}

- (NSString*)subtitleForError:(NSError*)error{
    return @"subtitle error";    
}
- (UIImage*)imageForError:(NSError*)error{
    return nil;
}

- (NSArray*)sectionIndexTitlesForTableView:(UITableView*)tableView
{
    return nil;
//    NSMutableArray *retArray = [NSMutableArray arrayWithCapacity:self.sections.count];
//    [self.sections enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        PKTableViewSectionObject *sectionObject = (PKTableViewSectionObject*)obj;
//        [retArray addObject:sectionObject.letter];
//    }];
//    return retArray;
}

@end
