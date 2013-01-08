//
//  JoinChannelViewController.m
//  pound-client
//
//  Created by Ryan Cole on 1/7/13.
//  Copyright (c) 2013 Ryan Cole. All rights reserved.
//

#import "JoinChannelViewController.h"
#import "JoinChannelCell.h"
#import "APIClient.h"

#define TOP_BAR_HEIGHT 44

@interface JoinChannelViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) UIBarButtonItem *joinButton;

@end

@implementation JoinChannelViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, TOP_BAR_HEIGHT)];
    
    // initialize the button items
    _joinButton = [[UIBarButtonItem alloc] initWithTitle:@"Join" style:UIBarButtonItemStyleDone target:self action:@selector(joinButtonPressed:)];
    
    [items addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed:)]];
    [items addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil]];
    [items addObject:_joinButton];
    
    // add the various toolbar items to the toolbar
    [toolbar setItems:items];
    
    // add the toolbar to this view's subview
    [self.view addSubview:toolbar];
    
    // initialize the table
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, TOP_BAR_HEIGHT,
                                                           self.view.frame.size.width,
                                                           self.view.frame.size.height - TOP_BAR_HEIGHT)
                                          style:UITableViewStyleGrouped];
    
    _table.dataSource = self;
    _table.delegate = self;
    
    // add the table to the subviews
    [self.view addSubview:_table];
    
}

- (void)cancelButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)joinButtonPressed:(id)sender {
    
    // disable the join button so it cannot be pressed again
    _joinButton.enabled = NO;
    
    // get the channel cell
    JoinChannelCell *joinChannelCell = (JoinChannelCell *)[_table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    // join the channel
    [[APIClient sharedInstance] joinChannel:joinChannelCell.channelName.text
                                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                        
                                        [self dismissViewControllerAnimated:YES completion:^{
                                            
                                            [_delegate channelWithName:joinChannelCell.channelName.text wasJoined:YES];
                                            
                                        }];
                                        
                                    }
                                    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                        
                                        [self dismissViewControllerAnimated:YES completion:^{
                                            
                                            [_delegate channelWithName:joinChannelCell.channelName.text wasJoined:NO];
                                            
                                        }];
                                        
                                    }];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // dequeue a cell object
    JoinChannelCell *cell = (JoinChannelCell *)[_table dequeueReusableCellWithIdentifier:@"joinChannelCell"];
    
    // initialize the cell if it's null
    if (cell == nil)
        cell = [[JoinChannelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"joinChannelCell"];
    
    return cell;
    
}

@end
