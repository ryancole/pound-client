//
//  ComposeMessageViewController.m
//  pound-client
//
//  Created by Ryan Cole on 12/29/12.
//  Copyright (c) 2012 Ryan Cole. All rights reserved.
//

#import "ComposeMessageViewController.h"
#import "APIClient.h"

@interface ComposeMessageViewController ()

@property (nonatomic, strong) UITextView *input;

@end

@implementation ComposeMessageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // initialize a toolbar
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    // create the collection of bar button items
    [items addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed:)]];
    [items addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil]];
    [items addObject:[[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleDone target:self action:@selector(sendButtonPressed:)]];
    
    // add the compose button to the toolbar
    [toolbar setItems:items];
    
    // create the input area
    _input = [[UITextView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height)];
    
    // add the toolbar to this view's subview
    [self.view addSubview:toolbar];
    [self.view addSubview:_input];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // focus the input text field
    [_input becomeFirstResponder];
    
}

- (void)cancelButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)sendButtonPressed:(id)sender {
    
    [[APIClient sharedInstance] sendMessage:_input.text success:^{
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
}

@end
