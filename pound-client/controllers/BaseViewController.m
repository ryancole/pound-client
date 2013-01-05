//
//  BaseViewController.m
//  pound-client
//
//  Created by Ryan Cole on 12/26/12.
//  Copyright (c) 2012 Ryan Cole. All rights reserved.
//

#import "BaseViewController.h"
#import "Utilities.h"

@interface BaseViewController ()

@property (nonatomic, strong) NSString *previousRecipient;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    
    // call super class constructor
    [super viewDidLoad];
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    // initialize the top toolbar
    _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    
    // create the compose button with a bordered style
    UIBarButtonItem *composeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(composeMessageButtonPressed:)];
    composeButton.style = UIBarButtonItemStyleBordered;
    
    // add the flex space and button to the toolbar items collection
    [items addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil]];
    [items addObject:composeButton];
    
    // add the compose button to the toolbar
    [_toolbar setItems:items];
    
    // add the toolbar to this view's subview]
    [self.view addSubview:_toolbar];
    
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
    [[Utilities sharedInstance] setPreviousRecipient:recipient];
    
}

@end
