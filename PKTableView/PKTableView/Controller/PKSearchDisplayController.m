//
//  PKSearchDisplayController.m
//  PKTableView
//
//  Created by zhongsheng on 13-4-16.
//  Copyright (c) 2013年 icePhone. All rights reserved.
//

#import "PKSearchDisplayController.h"
#import "PKTableViewController.h"

@implementation PKSearchDisplayController
@synthesize searchResultsViewController = _searchResultsViewController;


- (id)initWithSearchBar:(UISearchBar*)searchBar contentsController:(UIViewController*)controller
{
    if (self = [super initWithSearchBar:searchBar contentsController:controller])
    {
        self.delegate = self;
    }
    
    return self;
}

#pragma mark -
#pragma mark Private

- (void)resetResults
{
	[_searchResultsViewController cancelSearch];
	[_searchResultsViewController search:nil];
	[_searchResultsViewController viewWillDisappear:NO];
	[_searchResultsViewController viewDidDisappear:NO];
	_searchResultsViewController.tableView = nil;
}


#pragma mark -
#pragma mark UISearchDisplayDelegate

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController*)controller
{
    id contenstController = controller.searchContentsController;
    [_searchResultsViewController viewWillAppear:NO];
    if ([contenstController respondsToSelector:@selector(willBeginSearch)])
    {
        [contenstController performSelector:@selector(willBeginSearch)];
    }
}


- (void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller
{
    [_searchResultsViewController viewDidAppear:NO];
}

- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
	id contenstController = controller.searchContentsController;
    
	if ([contenstController respondsToSelector:@selector(willEndSearch)])
    {
		[contenstController performSelector:@selector(willEndSearch)];
	}
}
- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController*)controller
{
    [self resetResults];
}


- (void)searchDisplayController:(UISearchDisplayController *)controller
  didLoadSearchResultsTableView:(UITableView *)tableView
{
    
}


- (void)searchDisplayController:(UISearchDisplayController *)controller
willUnloadSearchResultsTableView:(UITableView *)tableView
{
    
}


- (void)searchDisplayController:(UISearchDisplayController *)controller
  didShowSearchResultsTableView:(UITableView *)tableView
{
    _searchResultsViewController.tableView = tableView;
    [_searchResultsViewController viewWillAppear:NO];
    [_searchResultsViewController viewDidAppear:NO];
    
}


- (void)searchDisplayController:(UISearchDisplayController*)controller
 willHideSearchResultsTableView:(UITableView*)tableView
{
    [self resetResults];
    id contenstController = controller.searchContentsController;
    if ([contenstController respondsToSelector:@selector(willHideSearchResult)])
    {
        [contenstController performSelector:@selector(willHideSearchResult)];
    }
}


- (BOOL)searchDisplayController:(UISearchDisplayController*)controller
shouldReloadTableForSearchString:(NSString*)searchString
{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.001);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        for (UIView* v in self.searchResultsTableView.subviews)
        {
            if ([v isKindOfClass: [UILabel class]] &&
                [[(UILabel*)v text] isEqualToString:@"No Results"]) {
                [(UILabel*)v setText:@"没有结果"];
                break;
            }
        }
    });
    
    [_searchResultsViewController search:searchString];
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController*)controller
shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [_searchResultsViewController search:self.searchBar.text];
    return YES;
}

@end
