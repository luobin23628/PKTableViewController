//
//  PKTableViewDataSource.h
//  PKTableView
//
//  Created by zhongsheng on 13-4-16.
//  Copyright (c) 2013年 icePhone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol PKTableViewDataSource <UITableViewDataSource, UISearchDisplayDelegate>

@required
- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)object;
///////////////////////////////////////////////////////////////////////////////////
@optional
- (id)tableView:(UITableView *)tableView objectForRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSIndexPath *)tableView:(UITableView *)tableView indexPathForObject:(id)object;

- (void)tableView:(UITableView *)tableView cell:(UITableViewCell *)cell willAppearAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)titleForLoading:(BOOL)reloading;

- (UIImage*)imageForEmpty;

- (UIImage*)titleImageForEmpty;

- (NSString*)titleForEmpty;

- (NSString*)subtitleForEmpty;

- (UIImage*)imageForError:(NSError*)error;

- (NSString*)titleForError:(NSError*)error;

- (NSString*)subtitleForError:(NSError*)error;

- (BOOL)empty;

- (BOOL)buttonExecutable;

- (UIEdgeInsets)emptyViewEdgeInsets;

///////////////////////////////////////////////////////////////////////////////////

- (NSIndexPath *)tableView:(UITableView *)tableView willUpdateObject:(id)object atIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)tableView:(UITableView *)tableView willInsertObject:(id)object atIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)tableView:(UITableView *)tableView willRemoveObject:(id)object atIndexPath:(NSIndexPath *)indexPath;
///////////////////////////////////////////////////////////////////////////////////
- (void)search:(NSString *)text;
///////////////////////////////////////////////////////////////////////////////////

@end

@interface PKTableViewDataSource : NSObject <PKTableViewDataSource>

@end
