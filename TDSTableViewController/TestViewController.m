//
//  TestViewController.m
//  TDSTableViewController
//
//  Created by zhong sheng on 12-6-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TestViewController.h"
#import "TestTableViewDataSource.h"
#import "TestTableViewItem.h"
#import "TDSTableViewSectionObject.h"

#define TEST_SECTION_INDEX 1

@interface TestViewController ()
- (void)addTestBtns;
- (void)testAddCell;
- (void)testDelCell;
- (void)testUpdateCell;
@end

@implementation TestViewController
#pragma mark - Super
- (void)createModel
{
    [super createModel];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsPullToRefresh = YES;
    self.tableView.showsInfiniteScrolling = YES;
    self.tableView.showsVerticalScrollIndicator = YES;
    
    // init DataSource
    NSMutableArray *sections= [NSMutableArray array];
    for (int i = 0; i<4; i++) {
        TDSTableViewSectionObject *sectionObject = [[TDSTableViewSectionObject alloc] init];
        sectionObject.title = [NSString stringWithFormat:@"%d",i];
        sectionObject.letter = sectionObject.title;
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
    [testDataSource release];

//    [self showError:YES];
    
//    [self refreshTable];

    [self addTestBtns];
}
// 下拉刷新方法
- (void)pullToRefreshAction
{
    [self performSelector:@selector(stopRefreshAction) withObject:nil afterDelay:2.0f];
}
// load more 方法
/*
 * 也可以用 TDSTableViewLoadMoreItem实现
 */
- (void)infiniteScrollingAction
{
    // TODO:loading status
    NSLog(@"will load more");
}
#pragma mark - Private
- (void)addTestBtns
{
    [self.tableView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 60.0f, 0.0f)];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f,
                                                                     self.view.bounds.size.height - 60,
                                                                     self.view.bounds.size.width, 60)];
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
                                                          style:UIButtonTypeCustom
                                                         target:self
                                                         action:@selector(testAddCell)];
    UIBarItem *delItem =[[UIBarButtonItem alloc] initWithTitle:@"-"
                                                         style:UIButtonTypeCustom
                                                        target:self
                                                        action:@selector(testDelCell)];
    UIBarItem *upItem =[[UIBarButtonItem alloc] initWithTitle:@"*"
                                                        style:UIButtonTypeCustom
                                                    target:self
                                                        action:@selector(testUpdateCell)];

    NSMutableArray *toolbarItems = [[NSMutableArray alloc] initWithCapacity:5];

    [toolbarItems addObject:addItem];
    [toolbarItems addObject:space];
    [toolbarItems addObject:delItem];
    [toolbarItems addObject:space];
    [toolbarItems addObject:upItem];

    [toolBar setItems:[NSArray arrayWithArray:toolbarItems]];
    [space release],[addItem release],[delItem release],[upItem release];
    
    [self.view addSubview:toolBar];
    [toolBar release];

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

    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                          withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];

}
- (void)testDelCell
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:TEST_SECTION_INDEX];
    TestTableViewDataSource *selfDataSource = (TestTableViewDataSource*)self.dataSource;
    if (selfDataSource.sections.count > TEST_SECTION_INDEX) {

        TDSTableViewSectionObject *sectionObject = [selfDataSource.sections objectAtIndex:indexPath.section];
        [selfDataSource tableView:self.tableView
                 willRemoveObject:nil
                      atIndexPath:indexPath];
//        [self refreshTable];
        
        [self.tableView beginUpdates];        
        if (sectionObject.items.count <= 0) {
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section]
                          withRowAnimation:UITableViewRowAnimationFade];
        }
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                              withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }
}
- (void)testUpdateCell
{
    TestTableViewItem *updateItem = [TestTableViewItem itemWithText:@"update" image:nil];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:TEST_SECTION_INDEX];

    TestTableViewDataSource *selfDataSource = (TestTableViewDataSource*)self.dataSource;
    if (selfDataSource.sections.count > TEST_SECTION_INDEX) {
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
        [self.tableView.pullToRefreshView triggerRefresh];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
