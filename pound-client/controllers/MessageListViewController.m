//
//  MessageListViewController.m
//  pound-client
//
//  Created by Ryan Cole on 12/26/12.
//  Copyright (c) 2012 Ryan Cole. All rights reserved.
//

#import "MessageListViewController.h"
#import "MessageListCell.h"
#import "Message.h"
#import "APIClient.h"
#import "Utilities.h"
#import "ComposeMessageViewController.h"
#import "../../Pods/SSPullToRefresh/SSPullToRefresh.h"

@interface MessageListViewController () <UITableViewDelegate, UITableViewDataSource, SSPullToRefreshViewDelegate>

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSMutableArray *messages;
@property (nonatomic, strong) SSPullToRefreshView *pullToRefreshView;

- (void)fetchMessages;

@end

@implementation MessageListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // initialize a table view
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                           TOP_BAR_HEIGHT,
                                                           self.view.frame.size.width,
                                                           self.view.frame.size.height - (TOP_BAR_HEIGHT + TAB_BAR_HEIGHT)) style:UITableViewStyleGrouped];
    _table.dataSource = self;
    _table.delegate = self;
    
    // add the table to this view's subview
    [self.view addSubview:_table];
    
    // initialize third party libs
    _pullToRefreshView = [[SSPullToRefreshView alloc] initWithScrollView:_table delegate:self];
    
    // fetch messages
    [self fetchMessages];
}

#pragma mark - UITableViewDelegate Functions

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // get the cell for this index path
    MessageListCell *cell = (MessageListCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    // return the calculated height for this cell
    return [cell getCalculatedCellHeight];
    
}

#pragma mark - UITableViewDataSource Functions

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _messages.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // get the corresponding message item
    Message *message = [_messages objectAtIndex:indexPath.row];
    
    // dequeue a cell object
    MessageListCell *cell = (MessageListCell *)[_table dequeueReusableCellWithIdentifier:@"messageListCell"];
    
    // initialize the cell if it's null
    if (cell == nil)
        cell = [[MessageListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"messageListCell"];
    
    // set the cell attributes
    cell.source.text = [NSString stringWithFormat:@"%@, to %@", message.source, message.destination];
    cell.message.text = message.message;
    cell.timestamp.text = [Utilities relativeTime:message.timestamp];
    
    // make the cell adjust its own heights
    [cell adjustHeights];
    
    return cell;
    
}

#pragma mark - Private Methods

- (void)fetchMessages {
    
    if (_messages.count == 0) {
        
        [[APIClient sharedInstance] getMessages:^(NSMutableArray *messages) {
            
            // store the messages
            _messages = messages;
            
            // end pull to refresh
            [_pullToRefreshView finishLoading];
            
            // reload the table view
            [_table reloadData];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            // end pull to refresh
            [_pullToRefreshView finishLoading];
            
        }];
        
    } else {
        
        // get the most recent message
        Message *recent = [_messages objectAtIndex:0];
        
        // get all messages since this message
        [[APIClient sharedInstance] getMessagesSince:recent.id
                                             success:^(NSMutableArray *messages) {
                                                 
                                                 if (messages.count > 0) {
                                                     
                                                     // record the new messages
                                                     [_messages insertObjects:messages atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, messages.count)]];
                                                     
                                                     // refresh the table
                                                     [_table reloadData];
                                                     
                                                 }
                                                 
                                                 // end pull to refresh
                                                 [_pullToRefreshView finishLoading];
                                                 
                                             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                 
                                                 // end pull to refresh
                                                 [_pullToRefreshView finishLoading];
                                                 
                                             }];
        
    }
    
}

#pragma mark - SSPullToRefreshDelgate Functions

- (BOOL)pullToRefreshViewShouldStartLoading:(SSPullToRefreshView *)view {
    
    return YES;
    
}

- (void)pullToRefreshViewDidStartLoading:(SSPullToRefreshView *)view {
    
    [self fetchMessages];
    
}

#pragma mark - ComposeMessageDelegate

- (void)messageWasSent:(NSString *)message toRecipient:(NSString *)recipient {
    
    // make sure to handle the super class call too
    [super messageWasSent:message toRecipient:recipient];
    
    // reload the table to display our new message
    [self fetchMessages];
    
}

@end
