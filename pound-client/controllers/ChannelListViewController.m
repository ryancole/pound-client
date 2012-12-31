//
//  ChannelListViewController.m
//  pound-client
//
//  Created by Ryan Cole on 12/30/12.
//  Copyright (c) 2012 Ryan Cole. All rights reserved.
//

#import "ChannelListViewController.h"
#import "APIClient.h"
#import "ChannelListCell.h"
#import "Channel.h"

@interface ChannelListViewController ()

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSMutableArray *channels;
@property (nonatomic, strong) SSPullToRefreshView *pullToRefreshView;

- (void)fetchChannels;

@end

@implementation ChannelListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // initialize a table view
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _table.dataSource = self;
    _table.delegate = self;
    
    // add the table to this view's subview
    [self.view addSubview:_table];
    
    // initialize third party libs
    _pullToRefreshView = [[SSPullToRefreshView alloc] initWithScrollView:_table delegate:self];
    
    // fetch messages
    [self fetchChannels];
}

#pragma mark - UITableViewDelegate Functions

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // get the cell for this index path
    ChannelListCell *cell = (ChannelListCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    // return the calculated height for this cell
    return [cell getCalculatedCellHeight];
    
}

#pragma mark - UITableViewDataSource Functions

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _channels.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // get the corresponding channel item
    Channel *channel = [_channels objectAtIndex:indexPath.row];
    
    // dequeue a cell object
    ChannelListCell *cell = (ChannelListCell *)[_table dequeueReusableCellWithIdentifier:@"channelListCell"];
    
    // initialize the cell if it's null
    if (cell == nil)
        cell = [[ChannelListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"channelListCell"];
    
    // set the cell attributes
    cell.name.text = channel.name;
    
    return cell;
    
}

#pragma mark - Private Methods

- (void)fetchChannels {
    
    [[APIClient sharedInstance] getChannels:^(NSMutableArray *channels) {
        
        // store the channels
        _channels = channels;
        
        // end pull to refresh
        [_pullToRefreshView finishLoading];
        
        // reload the table view
        [_table reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // end pull to refresh
        [_pullToRefreshView finishLoading];
        
    }];
    
}

#pragma mark - SSPullToRefreshDelgate Functions

- (BOOL)pullToRefreshViewShouldStartLoading:(SSPullToRefreshView *)view {
    
    return YES;
    
}

- (void)pullToRefreshViewDidStartLoading:(SSPullToRefreshView *)view {
    
    [self fetchChannels];
    
}

@end
