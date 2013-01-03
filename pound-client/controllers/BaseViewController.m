//
//  BaseViewController.m
//  pound-client
//
//  Created by Ryan Cole on 12/26/12.
//  Copyright (c) 2012 Ryan Cole. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (nonatomic, strong) NSString *previousRecipient;

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    // call super class constructor
    [super viewDidLoad];
    
    // initialize a toolbar
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);

    // create the compose button
    NSMutableArray *items = [[NSMutableArray alloc] init];
    [items addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil]];
    [items addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(composeMessageButtonPressed:)]];
    
    // add the compose button to the toolbar
    [toolbar setItems:items];
    
    // add the toolbar to this view's subview
    [self.view addSubview:toolbar];
}

- (void)composeMessageButtonPressed:(id)sender {
    
    ComposeMessageViewController *view = [[ComposeMessageViewController alloc] init];
    
    // the view should slide up from the bottom and cover everything
    view.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    view.modalPresentationStyle = UIModalPresentationFormSheet;
    view.delegate = self;
    
    // bring up the view
    [self presentViewController:view animated:YES completion:nil];
    
}

#pragma mark - ComposeMessageDelegate

- (void)messageWasSent:(NSString *)message toRecipient:(NSString *)recipient {
    
    // make note of the previous recipient for future messages
    _previousRecipient = recipient;
    
}

@end
