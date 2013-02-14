//
//  ChannelListViewController.m
//  pound-client
//
//  Created by Ryan Cole on 12/30/12.
//  Copyright (c) 2012 Ryan Cole. All rights reserved.
//

#import "ChannelListViewController.h"
#import "JoinChannelViewController.h"
#import "APIClient.h"
#import "Channel.h"

@interface ChannelListViewController () <UITableViewDataSource, UITableViewDelegate, JoinChannelDelegate>

@property (nonatomic) BOOL tableIsEditing;
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSMutableArray *channels;

- (void)fetchChannels;

@end

@implementation ChannelListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *items = [[self.toolbar items] mutableCopy];
    
    // create the compose button
    [items insertObject:[[UIBarButtonItem alloc] initWithTitle:@"Edit"
                                                         style:UIBarButtonItemStyleBordered
                                                        target:self
                                                        action:@selector(editButtonWasPressed:)] atIndex:0];
    
    // add the button to the toolbar
    [self.toolbar setItems:items];
    
    // initialize the table
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, TOP_BAR_HEIGHT,
                                                           self.view.frame.size.width,
                                                           self.view.frame.size.height - (TOP_BAR_HEIGHT + TAB_BAR_HEIGHT)) style:UITableViewStyleGrouped];
    _table.dataSource = self;
    _table.delegate = self;
    _table.allowsSelection = NO;
    
    // add the table to the subviews
    [self.view addSubview:_table];
    
    // table is not editing by default
    _tableIsEditing = NO;
    
    // fetch messages
    [self fetchChannels];
}

- (void)editButtonWasPressed:(id)sender {
    
    NSMutableArray *items = [[self.toolbar items] mutableCopy];
    
    // change the edit button to a save button
    [items setObject:[[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                      style:UIBarButtonItemStyleBordered
                                                     target:self
                                                     action:@selector(saveButtonWasPressed:)] atIndexedSubscript:0];
    
    // replace the toolbar items
    [self.toolbar setItems:items];
    
    // put the view into editing mode
    [self setEditing:YES animated:YES];
    
}

- (void)saveButtonWasPressed:(id)sender {
    
    NSMutableArray *items = [[self.toolbar items] mutableCopy];
    
    // change the save button to an edit button
    [items setObject:[[UIBarButtonItem alloc] initWithTitle:@"Edit"
                                                      style:UIBarButtonItemStyleBordered
                                                     target:self
                                                     action:@selector(editButtonWasPressed:)] atIndexedSubscript:0];
    
    // replace the toolbar items
    [self.toolbar setItems:items];
    
    // take the view out of editing mode
    [self setEditing:NO animated:YES];
    
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    _tableIsEditing = editing;
    
    if (editing == YES) {
        
        [_table insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:_channels.count inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [super setEditing:editing animated:animated];
        [_table setEditing:editing animated:animated];
        
    } else if (editing == NO) {
        
        [super setEditing:editing animated:animated];
        [_table setEditing:editing animated:animated];
        
        [_table deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:_channels.count inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
    
}

#pragma mark - UITableViewDelegate

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == _channels.count) {
        
        return UITableViewCellEditingStyleInsert;
        
    }
    
    return UITableViewCellEditingStyleDelete;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"Leave";
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _tableIsEditing ? _channels.count + 1 : _channels.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // initialize the default cell identifier
    NSString *cellIdentifier = @"channelListCell";
    
    // initialize a reusable bool for whether or not this cell is for the add row
    BOOL isAddRow = (indexPath.row == _channels.count);
    
    // adjust cell identifier if this is the add row cell
    if (isAddRow)
        cellIdentifier = @"joinChannelCell";
    
    UITableViewCell *cell = [_table dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        
    }
    
    if (isAddRow) {
        
        cell.textLabel.text = @"Join a new channel ...";
        
    } else {
        
        // get the channel for this row
        Channel *channel = [_channels objectAtIndex:indexPath.row];
        
        // set the cell label texts
        cell.textLabel.text = channel.name;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d users", channel.users.count];
        
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // get the requested channel to be left
        Channel *channel = [_channels objectAtIndex:indexPath.row];
        
        // leave the channel
        [[APIClient sharedInstance] leaveChannel:channel.name
                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                             
                                             [self fetchChannels];
                                             
                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                             
                                             /* not sure */
                                             
                                         }];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
        JoinChannelViewController *view = [[JoinChannelViewController alloc] init];
        
        // the view should slide up from the bottom and cover everything
        view.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        view.modalPresentationStyle = UIModalPresentationFormSheet;
        view.delegate = self;
        
        // bring up the view
        [self presentViewController:view animated:YES completion:nil];
        
    }
    
}

#pragma mark - Private Methods

- (void)fetchChannels {
    
    [[APIClient sharedInstance] getChannels:^(NSMutableArray *channels) {
        
        // store the channels
        _channels = channels;
        
        // reload the table view
        [_table reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // reload the table view
        [_table reloadData];
        
    }];
    
}

#pragma mark - JoinChannelDelegate

- (void)channelWithName:(NSString *)channel wasJoined:(BOOL)success {
    
    if (success) {
        
        [self fetchChannels];
        
    }
    
}

@end
