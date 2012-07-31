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

}
// 下拉刷新方法
- (void)pullToRefreshAction
{
    [self createModel];
    [self performSelector:@selector(stopRefreshAction) withObject:nil afterDelay:1.0f];
}
// load more 方法
- (void)delayLoadingMore
{
    TestTableViewDataSource *dataSource = (TestTableViewDataSource*)self.dataSource;
    if (dataSource.sections.count >0) {
        TDSTableViewSectionObject *sectionObject = [dataSource.sections lastObject];
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
    }
}
/*
 * 也可以用 TDSTableViewLoadMoreItem实现
 */
- (void)infiniteScrollingAction
{
    // TODO:loading status
    NSLog(@"will load more");
    [self performSelector:@selector(delayLoadingMore) withObject:nil afterDelay:1.0f];
}
#pragma mark - Private
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
    
    TDSTableViewSectionObject *sectionObject = [selfDataSource.sections objectAtIndex:indexPath.section];
    [self.tableView beginUpdates];
    if (sectionObject.items.count == 1)
    {
        // Should Add new title and new letter
        sectionObject.title = @"newTltle";
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
    if (selfDataSource.sections.count > TEST_SECTION_INDEX) {

        TDSTableViewSectionObject *sectionObject = [selfDataSource.sections objectAtIndex:indexPath.section];
        [selfDataSource tableView:self.tableView
                 willRemoveObject:nil
                      atIndexPath:indexPath];
//        [self refreshTable];
        
        [self.tableView beginUpdates];        
        if (sectionObject.items.count <= 0)
        {
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
        [self.tableView.pullToRefreshView triggerRefresh];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
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
