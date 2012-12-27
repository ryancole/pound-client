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

@interface MessageListViewController ()

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSMutableArray *messages;

- (void)fetchMessages;

@end

@implementation MessageListViewController

- (void)viewDidLoad
{
    // call super class constructor
    [super viewDidLoad];
    
    // initialize a table view
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _table.dataSource = self;
    _table.delegate = self;
    
    // add the table to this view's subview
    [self.view addSubview:_table];
    
    // fetch messages
    [self fetchMessages];
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
    cell.source.text = message.source;
    cell.message.text = message.message;
    cell.destination.text = message.destination;
    
    return cell;
    
}

#pragma mark - Private Methods

- (void)fetchMessages {
    
    [[APIClient sharedInstance] getMessagesWithLimit:25 success:^(id messages) {
        
        // store the messages
        _messages = messages;
        
        // reload the table view
        [_table reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@ %@", error, [error userInfo]);
        
    }];
    
}

@end
