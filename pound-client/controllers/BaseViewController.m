//
//  BaseViewController.m
//  pound-client
//
//  Created by Ryan Cole on 12/26/12.
//  Copyright (c) 2012 Ryan Cole. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

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
    [items addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:nil]];
    
    // add the compose button to the toolbar
    [toolbar setItems:items];
    
    // add the toolbar to this view's subview
    [self.view addSubview:toolbar];
}

@end
