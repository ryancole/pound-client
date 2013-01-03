//
//  SelectRecipientViewController.m
//  pound-client
//
//  Created by Ryan Cole on 1/2/13.
//  Copyright (c) 2013 Ryan Cole. All rights reserved.
//

#import "SelectRecipientViewController.h"
#import "APIClient.h"
#import "Channel.h"

@interface SelectRecipientViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSInteger selectedRecipientType;
@property (nonatomic, strong) UITableView *recipientsTable;
@property (nonatomic, strong) NSMutableArray *channelRecipients;
@property (nonatomic, strong) NSMutableArray *userRecipients;

@end

@implementation SelectRecipientViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *buttonItems = [[NSMutableArray alloc] init];
    
    // initialize the toolbar
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    
    // create the collection of bar button items
    [buttonItems addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed:)]];
    [buttonItems addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil]];
    
    // initialize the segmented control
    UISegmentedControl *recipientTypes = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Channels", @"Users", nil]];
    recipientTypes.segmentedControlStyle = UISegmentedControlStyleBar;
    recipientTypes.selectedSegmentIndex = 0;
    
    // set the segmented control target
    [recipientTypes addTarget:self action:@selector(didChangeSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    
    // add the segmented control to a bar item and then to the bar items collection
    [buttonItems addObject:[[UIBarButtonItem alloc] initWithCustomView:recipientTypes]];
    [buttonItems addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil]];
    
    // add the items to the toolbar
    [toolbar setItems:buttonItems];
    
    // add the toolbar to this view's subview
    [self.view addSubview:toolbar];
    
    // initialize the table
    _recipientsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 44) style:UITableViewStyleGrouped];
    _recipientsTable.delegate = self;
    _recipientsTable.dataSource = self;
    
    // add the table to the view's subview
    [self.view addSubview:_recipientsTable];
    
    // load the recipient
    [self fetchRecipients];
}

- (void)cancelButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didChangeSegmentedControl:(UISegmentedControl *)sender {
    
    // save this new recipient type
    _selectedRecipientType = sender.selectedSegmentIndex;
    
    // reload the table based on this information
    [_recipientsTable reloadData];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_selectedRecipientType == 1)
        return _userRecipients.count;
    
    return _channelRecipients.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // dequeue a cell object
    UITableViewCell *cell = (UITableViewCell *)[_recipientsTable dequeueReusableCellWithIdentifier:@"recipientListCell"];
    
    // initialize the cell if it's null
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"recipientListCell"];
    
    if (_selectedRecipientType == 0) {
        
        cell.textLabel.text = [_channelRecipients objectAtIndex:indexPath.row];
        
    } else if (_selectedRecipientType == 1) {
        
        cell.textLabel.text = [_userRecipients objectAtIndex:indexPath.row];
        
    }
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // get the selected cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    // make note of the selected recipient
    NSString *selectedRecipient = cell.textLabel.text;
    
    // dismiss the view controlled and notify the other delegates
    [self dismissViewControllerAnimated:YES completion:^{
        
        [_delegate recipientWasSelected:selectedRecipient];
        
    }];
    
}

#pragma mark - Helper Functions

- (void)fetchRecipients {
    
    [[APIClient sharedInstance] getChannels:^(NSMutableArray *channels) {
        
        // store the recipients
        _channelRecipients = [self extractChannelRecipients:channels];
        _userRecipients = [self extractUserRecipients:channels];
        
        // reload the table
        [_recipientsTable reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // something went wrong so at least init to nothing
        _channelRecipients = [NSMutableArray arrayWithCapacity:0];
        _userRecipients = [NSMutableArray arrayWithCapacity:0];
        
        // reload the table
        [_recipientsTable reloadData];
        
    }];
    
}

- (NSMutableArray *)extractChannelRecipients:(NSMutableArray *)channels {
    
    // initialize the channel name collection
    NSMutableArray *channelRecipients = [NSMutableArray arrayWithCapacity:channels.count];
    
    // add each channel name to the collection
    for (Channel *channel in channels) {
        
        [channelRecipients addObject:channel.name];
        
    }
    
    return channelRecipients;
    
}

- (NSMutableArray *)extractUserRecipients:(NSMutableArray *)channels {
    
    // initialize the user name collection
    NSMutableArray *userRecipients = [NSMutableArray array];
    
    // add each user name to the collection
    for (Channel *channel in channels) {
        
        for (NSString *user in channel.users) {
            
            if ([userRecipients containsObject:user] == false)
                [userRecipients addObject:user];
            
        }
        
    }
    
    return userRecipients;
    
}

@end
