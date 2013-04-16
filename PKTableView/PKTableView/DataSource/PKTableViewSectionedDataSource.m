//
//  PKTableViewSectionedDataSource.m
//  PKTableView
//
//  Created by zhongsheng on 13-4-16.
//  Copyright (c) 2013年 icePhone. All rights reserved.
//

#import "PKTableViewSectionedDataSource.h"
#import "PKTableViewSectionObject.h"
@interface PKTableViewSectionedDataSource ()
- (BOOL)removeItemAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)removeItemAtIndexPath:(NSIndexPath *)indexPath andSectionIfEmpty:(BOOL)andSection;
@end

@implementation PKTableViewSectionedDataSource
@synthesize sections			= _sections;
@synthesize firstSectionItems	= _firstSectionItems;

#pragma mark - PKTableViewDataSource
// should be overrided
- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)object
{
    return [super tableView:tableView cellClassForObject:object];
}

- (BOOL)empty
{
    return (self.sections == nil
            || self.sections.count <= 0
            || (self.sections.count == 1 && self.firstSectionItems.count <= 0) );
}

- (id)tableView:(UITableView *)tableView objectForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (_sections.count > 0)
    {
		PKTableViewSectionObject *aSectionObject = [_sections objectAtIndex:indexPath.section];
        
		if ([aSectionObject.items count] > indexPath.row)
        {
			return [aSectionObject.items objectAtIndex:indexPath.row];
		}
	}
    
	return nil;
}

- (NSIndexPath *)tableView:(UITableView *)tableView indexPathForObject:(id)object
{
	if (_sections) {
		for (int i = 0; i < _sections.count; ++i)
        {
			PKTableViewSectionObject	*aSectionObject = [_sections objectAtIndex:i];
			NSUInteger					objectIndex		= [aSectionObject.items indexOfObject:object];
            
			if (objectIndex != NSNotFound) {
				return [NSIndexPath indexPathForRow:objectIndex inSection:i];
			}
		}
	}
    
	return nil;
}

////////////////////////////////////////////////////////////////////////////////////////////////
- (NSIndexPath *)tableView:(UITableView *)tableView willUpdateObject:(id)object atIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(object != nil, @"tableview updateObject is nil !!!");
    if (_sections.count > indexPath.section)
    {
        PKTableViewSectionObject *sectionObject = [_sections objectAtIndex:indexPath.section];
        if (sectionObject.items.count > indexPath.row)
        {
            [sectionObject.items replaceObjectAtIndex:indexPath.row withObject:object];
        }
    }
    return indexPath;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willInsertObject:(id)object atIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(object != nil, @"tableview insertObject is nil !!!");
    PKTableViewSectionObject *sectionObject = nil;
    if (_sections.count <= indexPath.section)
    {
        // ADD section
        sectionObject = [[PKTableViewSectionObject alloc] init];
        sectionObject.items = [NSMutableArray arrayWithObject:object];
        [_sections insertObject:sectionObject atIndex:indexPath.section];
    }
    else
    {
        NSAssert(indexPath != nil , @"indexPath is nil !!!");
        sectionObject = [_sections objectAtIndex:indexPath.section];
        [sectionObject.items insertObject:object atIndex:indexPath.row];
        [_sections replaceObjectAtIndex:indexPath.section withObject:sectionObject];
    }
    
    return indexPath;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willRemoveObject:(id)object atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath != nil)
    {
        [self removeItemAtIndexPath:indexPath andSectionIfEmpty:YES];
    }
    else if(object != nil)
    {
        indexPath = [self tableView:tableView indexPathForObject:object];
        if (indexPath != nil)
        {
            [self removeItemAtIndexPath:indexPath andSectionIfEmpty:YES];
        }
    }
    else
    {
        NSAssert(indexPath == nil && object == nil, @"object and indexPath are nil !!!");
    }
    // If Object Not Founded ==> return nil
    return indexPath;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return _sections ? _sections.count : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (_sections && _sections.count > section)
    {
		PKTableViewSectionObject *sectionObject = [_sections objectAtIndex:section];
		return sectionObject.items.count;
	}
    
	return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	if (_sections.count)
    {
		PKTableViewSectionObject *sectionObject = [_sections objectAtIndex:section];
		return sectionObject.headerTitle;
	}
    
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
	if (_sections.count)
    {
		PKTableViewSectionObject *sectionObject = [_sections objectAtIndex:section];
        if (sectionObject != nil && sectionObject.footerTitle != nil && ![sectionObject.footerTitle isEqualToString:@""])
        {
            return sectionObject.footerTitle;
        }
        
	}
    
    return nil;
}
#pragma mark - Private
- (BOOL)removeItemAtIndexPath:(NSIndexPath *)indexPath
{
	return [self removeItemAtIndexPath:indexPath andSectionIfEmpty:NO];
}

- (BOOL)removeItemAtIndexPath:(NSIndexPath *)indexPath andSectionIfEmpty:(BOOL)andSection
{
	if (_sections.count)
    {
		PKTableViewSectionObject *sectionObject = [_sections objectAtIndex:indexPath.section];
		[sectionObject.items removeObjectAtIndex:indexPath.row];
        
		if (andSection && sectionObject.items.count == 0)
        {
			[_sections removeObjectAtIndex:indexPath.section];
			return YES;
		}
	}
    
	return NO;
}

#pragma mark - Propertys
- (NSMutableArray *)sections
{
    if (_sections == nil) {
        _sections = [[NSMutableArray alloc] init];
    }
    
    return _sections;
}

- (NSArray *)firstSectionItems
{
	if ((_sections == nil) || (_sections.count <= 0)) {
		return nil;
	}
    
	PKTableViewSectionObject *firstObj = [_sections objectAtIndex:0];
	return firstObj.items;
}

- (void)setFirstSectionItems:(NSArray *)itemArray
{
    if (!self.sections || self.sections.count <= 0) {
        PKTableViewSectionObject *firstObj = [[PKTableViewSectionObject alloc] init];
        self.sections = [NSArray arrayWithObject:firstObj];
    }
    [[self.sections objectAtIndex:0] setItems:itemArray];
}


@end
