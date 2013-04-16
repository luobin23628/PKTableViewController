//
//  PKViewController.m
//  demo
//
//  Created by zhongsheng on 13-4-16.
//  Copyright (c) 2013年 icePhone. All rights reserved.
//

#import "TestViewController.h"

#import "TestTableViewDataSource.h"
#import "TestTableViewItem.h"
#import "TestSearchViewController.h"
#import "PKSearchDisplayController.h"

#define TEST_SECTION_INDEX 0

@interface TestViewController ()
@property (nonatomic, retain) UISearchBar *searchBar;
- (void)addTestBtns;
- (void)testAddCell;
- (void)testDelCell;
- (void)testUpdateCell;
@end

@implementation TestViewController
@synthesize searchBar = _searchBar;

#pragma mark - Super

// 下拉刷新方法
- (void)pullToRefreshAction
{
    NSLog(@"will refresh");
    [self performSelector:@selector(delayRefresh) withObject:nil afterDelay:1.0f];
}
/*
 * 也可以用 PKTableViewLoadMoreItem实现
 */
- (void)infiniteScrollingAction
{
    // TODO:loading status
    NSLog(@"will load more");
    [self performSelector:@selector(delayLoadingMore) withObject:nil afterDelay:1.0f];
}

#pragma mark - Private
// refresh
- (void)delayRefresh
{
    [self createModel];
    [self stopRefreshAction];
}
// load more 方法
- (void)delayLoadingMore
{
    TestTableViewDataSource *dataSource = (TestTableViewDataSource*)self.dataSource;
    if (dataSource.sections.count >0) {
        PKTableViewSectionObject *sectionObject = [dataSource.sections lastObject];
        NSUInteger index = sectionObject.items.count;
        for (int i = 0; i < 2; i++) {
            TestTableViewItem *loadingItem = [TestTableViewItem itemWithText:[NSString stringWithFormat:@"loadingMore：%d",(index+i)]
                                                                       image:nil];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sectionObject.items.count inSection:dataSource.sections.count-1];
            
            [dataSource tableView:self.tableView
                 willInsertObject:loadingItem
                      atIndexPath:indexPath];
        }
        [self refreshTable];
        self.tableView.showsInfiniteScrolling = YES;        
    }
}
- (void)addTestBtns
{
    CGFloat toolBarHeight = 60.0f;
    CGRect frame = self.tableView.frame;
    frame.size.height -= toolBarHeight;
    self.tableView.frame = frame;
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f,
                                                                     self.view.bounds.size.height - toolBarHeight,
                                                                     self.view.bounds.size.width, toolBarHeight)];
    [toolBar setBarStyle:UIBarStyleBlack];
    [toolBar setAutoresizingMask:
     UIViewAutoresizingFlexibleWidth |
     UIViewAutoresizingFlexibleHeight |
     UIViewAutoresizingFlexibleTopMargin |
     UIViewAutoresizingFlexibleRightMargin];
    
    UIBarItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                     target:nil
                                                                     action:nil];
    UIBarItem *addItem = [[UIBarButtonItem alloc] initWithTitle:@"+"
                                                          style:UIBarButtonItemStylePlain
                                                         target:self
                                                         action:@selector(testAddCell)];
    UIBarItem *delItem =[[UIBarButtonItem alloc] initWithTitle:@"-"
                                                         style:UIBarButtonItemStylePlain
                                                        target:self
                                                        action:@selector(testDelCell)];
    UIBarItem *upItem =[[UIBarButtonItem alloc] initWithTitle:@"*"
                                                        style:UIBarButtonItemStylePlain
                                                       target:self
                                                       action:@selector(testUpdateCell)];
    
    NSMutableArray *toolbarItems = [[NSMutableArray alloc] initWithCapacity:5];
    
    [toolbarItems addObject:addItem];
    [toolbarItems addObject:space];
    [toolbarItems addObject:delItem];
    [toolbarItems addObject:space];
    [toolbarItems addObject:upItem];
    
    [toolBar setItems:[NSArray arrayWithArray:toolbarItems]];
    
    [self.view addSubview:toolBar];

    
    UIButton *changePullBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 80, 320, 50)];
//    changePullBtn.alpha = .3f;
    [changePullBtn setTitle:[NSString stringWithFormat:@"showPullToRefresh:%d",self.tableView.showsPullToRefresh]
                   forState:UIControlStateNormal];
    changePullBtn.backgroundColor = [UIColor colorWithRed:0.0f
                                                    green:0.0f
                                                     blue:1.0f alpha:.3f];
    [changePullBtn addTarget:self action:@selector(changePullAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changePullBtn];
}

- (void)changePullAction:(id)sender
{
    self.tableView.showsPullToRefresh = !self.tableView.showsPullToRefresh;
    UIButton *changePullBtn = sender;
    [changePullBtn setTitle:[NSString stringWithFormat:@"showPullToRefresh:%d",self.tableView.showsPullToRefresh]
                   forState:UIControlStateNormal];
}
- (void)testAddCell
{
    TestTableViewItem *addItem = [TestTableViewItem itemWithText:@"isAdded" image:nil];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:TEST_SECTION_INDEX];
    TestTableViewDataSource *selfDataSource = (TestTableViewDataSource*)self.dataSource;
    [selfDataSource tableView:self.tableView
             willInsertObject:addItem
                  atIndexPath:indexPath];
    //    [self refreshTable];
    
    PKTableViewSectionObject *sectionObject = [selfDataSource.sections objectAtIndex:indexPath.section];
    [self.tableView beginUpdates];
    if (sectionObject.items.count == 1)
    {
        // Should Add new title and new letter
        sectionObject.headerTitle = @"newTltle";
        sectionObject.letter = @"N";
        [self.tableView insertSections:[NSIndexSet indexSetWithIndex:indexPath.section]
                      withRowAnimation:UITableViewRowAnimationFade];
    }
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                          withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
    
}
- (void)testDelCell
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:TEST_SECTION_INDEX];

    TestTableViewDataSource *selfDataSource = (TestTableViewDataSource*)self.dataSource;
    if (selfDataSource.sections.count > 0) {
        
        PKTableViewSectionObject *sectionObject = [selfDataSource.sections objectAtIndex:indexPath.section];
        BOOL needDelSection = NO;
        if (sectionObject.items.count > 1) {
            [sectionObject.items removeObjectAtIndex:0];
            [selfDataSource.sections replaceObjectAtIndex:TEST_SECTION_INDEX withObject:sectionObject];
        }else{
            needDelSection = YES;
            [selfDataSource.sections removeObject:sectionObject];
        }
        
        
        /*
        [selfDataSource tableView:self.tableView
                 willRemoveObject:nil
                      atIndexPath:indexPath];
        [self refreshTable];
         //*/
        
        [self.tableView beginUpdates];
        if (needDelSection)
        {
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section]
                          withRowAnimation:UITableViewRowAnimationNone];
        }else{            
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil]
                                  withRowAnimation:UITableViewRowAnimationLeft];
        }
        [self.tableView endUpdates];
    }
}
- (void)testUpdateCell
{
    TestTableViewItem *updateItem = [TestTableViewItem itemWithText:@"update" image:nil];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:TEST_SECTION_INDEX];
    
    TestTableViewDataSource *selfDataSource = (TestTableViewDataSource*)self.dataSource;
    if (selfDataSource.sections.count > TEST_SECTION_INDEX)
    {
        [selfDataSource tableView:self.tableView
                 willUpdateObject:updateItem
                      atIndexPath:indexPath];
        //        [self refreshTable];
        
        [self.tableView beginUpdates];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                              withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }
}

#pragma mark - Life Cycle
- (void)viewDidAppear:(BOOL)animated
{
    if (self.tableView.showsPullToRefresh) {
        [self.tableView triggerPullToRefresh];
    }
}

- (void)createModel
{
    // init DataSource
    NSMutableArray *sections= [NSMutableArray array];
    for (int i = 0; i<4; i++) {
        PKTableViewSectionObject *sectionObject = [[PKTableViewSectionObject alloc] init];
        sectionObject.headerTitle = [NSString stringWithFormat:@"%d",i];
        sectionObject.letter = sectionObject.headerTitle;
        NSMutableArray *aItems= [NSMutableArray array];
        for (int j = 0; j <4; j ++) {
            TestTableViewItem *item = [TestTableViewItem itemWithText:[NSString stringWithFormat:@"[%d][%d]",i,j]];
            [aItems addObject:item];
        }
        sectionObject.items = aItems;
        [sections addObject:sectionObject];
    }
    TestTableViewDataSource *testDataSource = [[TestTableViewDataSource alloc] init];
    self.dataSource = testDataSource;
    testDataSource.sections = sections;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.showsPullToRefresh = YES;
    self.tableView.showsInfiniteScrolling = YES;

    [self showLoading:YES];
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 44.0f)];
    
    //216,219,221
    _searchBar.tintColor = [UIColor colorWithRed:248.0f/255.0f
                                           green:248.0f/255.0f
                                            blue:248.0f/255.0f
                                           alpha:1.0f];
    _searchController = [[PKSearchDisplayController alloc]
                         initWithSearchBar:_searchBar
                         contentsController:self];
    
    TestSearchViewController *sv = [[TestSearchViewController alloc] init];
    _searchController.searchResultsViewController = sv;
    self.tableView.tableHeaderView = _searchBar;
    //    [self showError:YES];
    
    //    [self refreshTable];
	// Do any additional setup after loading the view.
    [self addTestBtns];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
