//
//  PKTableViewDataSource.m
//  PKTableView
//
//  Created by zhongsheng on 13-4-16.
//  Copyright (c) 2013年 icePhone. All rights reserved.
//

#import "NSObject+ClassName.h"
#import "PKTableViewDataSource.h"
#import "PKTableViewItem.h"
#import "PKTableViewCell.h"
#import "PKTableViewLoadMoreItem.h"
#import "PKTableViewLoadMoreCell.h"

@implementation PKTableViewDataSource

#pragma mark - PKTableViewDataSource
// @required
- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)object
{
    if ([object isKindOfClass:[PKTableViewLoadMoreItem class]]) {
        return [PKTableViewLoadMoreCell class];
    }else if ([object isKindOfClass:[PKTableViewItem class]]){
        return [PKTableViewCell class];
    }
    return [PKTableViewCell class];
}
// @optional
- (id)tableView:(UITableView *)tableView objectForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (NSIndexPath *)tableView:(UITableView *)tableView indexPathForObject:(id)object
{
    return nil;
}

- (void)tableView:(UITableView *)tableView cell:(UITableViewCell *)cell willAppearAtIndexPath:(NSIndexPath *)indexPath
{}

- (NSString *)titleForLoading:(BOOL)reloading
{
    return nil;
}
- (UIImage*)imageForEmpty
{
    return nil;
}

- (UIImage*)titleImageForEmpty
{
    return nil;
}

- (NSString*)titleForEmpty
{
    return nil;
}

- (NSString*)subtitleForEmpty
{
    return nil;
}

- (UIImage*)imageForError:(NSError*)error
{
    return nil;
}

- (NSString*)titleForError:(NSError*)error
{
    return nil;
}

- (NSString*)subtitleForError:(NSError*)error
{
    return nil;
}

- (BOOL)empty
{
    return YES;
}

- (BOOL)buttonExecutable
{
    return YES;
}

- (UIEdgeInsets)emptyViewEdgeInsets
{
    return UIEdgeInsetsZero;
}
////////////////////////////////////////////////////////////////////////////////////////////////
- (NSIndexPath *)tableView:(UITableView *)tableView willUpdateObject:(id)object atIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
- (NSIndexPath *)tableView:(UITableView *)tableView willInsertObject:(id)object atIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
- (NSIndexPath *)tableView:(UITableView *)tableView willRemoveObject:(id)object atIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
////////////////////////////////////////////////////////////////////////////////////////////////
- (void)search:(NSString*)text {
}
////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [self tableView:tableView objectForRowAtIndexPath:indexPath];
    
    Class cellClass = [self tableView:tableView cellClassForObject:object];
    NSString *className = [cellClass className];
    
    UITableViewCell* cell =
    (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:className];
    if (cell == nil) {
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault
                                reuseIdentifier:className];
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    if ([cell isKindOfClass:[PKTableViewCell class]]) {
        [(PKTableViewCell*)cell setObject:object];
        [(PKTableViewCell*)cell setIndexPath:indexPath];
    }
    [self tableView:tableView cell:cell willAppearAtIndexPath:indexPath];
    
    return cell;
}

- (NSArray*)sectionIndexTitlesForTableView:(UITableView*)tableView
{
    return nil;
}

- (NSInteger)tableView:(UITableView*)tableView sectionForSectionIndexTitle:(NSString*)title
               atIndex:(NSInteger)sectionIndex {
    if (tableView.tableHeaderView) {
        if (sectionIndex == 0)  {
            // This is a hack to get the table header to appear when the user touches the
            // first row in the section index.  By default, it shows the first row, which is
            // not usually what you want.
            [tableView scrollRectToVisible:tableView.tableHeaderView.bounds animated:NO];
            return -1;
        }
    }
    
    NSString* letter = [title substringToIndex:1];
    NSInteger sectionCount = [tableView numberOfSections];
    for (NSInteger i = 0; i < sectionCount; ++i) {
        NSString* section  = [tableView.dataSource tableView:tableView titleForHeaderInSection:i];
        if ([section hasPrefix:letter]) {
            return i;
        }
    }
    if (sectionIndex >= sectionCount) {
        return sectionCount-1;
        
    } else {
        return sectionIndex;
    }
}


@end
