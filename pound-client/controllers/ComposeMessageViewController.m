//
//  ComposeMessageViewController.m
//  pound-client
//
//  Created by Ryan Cole on 12/29/12.
//  Copyright (c) 2012 Ryan Cole. All rights reserved.
//

#import "ComposeMessageViewController.h"
#import "APIClient.h"

@interface ComposeMessageViewController () <UITextViewDelegate>

@property (nonatomic, strong) UITextView *messageInput;
@property (nonatomic, strong) UIImageView *selectChannelArea;

@end

@implementation ComposeMessageViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    // initialize the toolbar
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    
    // create the collection of bar button items
    [items addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed:)]];
    [items addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil]];
    [items addObject:[[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleDone target:self action:@selector(sendButtonPressed:)]];
    
    // add the compose button to the toolbar
    [toolbar setItems:items];
    
    // add the toolbar to this view's subview
    [self.view addSubview:toolbar];
    
    // initialize the message input area
    _messageInput = [[UITextView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height)];
    _messageInput.delegate = self;
    
    // add the message input area to the view
    [self.view addSubview:_messageInput];
    
    // initialize the select channel area
    _selectChannelArea = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44)];
    _selectChannelArea.image = [[UIImage imageNamed:@"MessageInputBarBackground"] resizableImageWithCapInsets:UIEdgeInsetsMake(19, 3, 19, 3)];
    _selectChannelArea.userInteractionEnabled = YES;
    _selectChannelArea.opaque = YES;
    
    // add the channel select area to the view
    [self.view addSubview:_selectChannelArea];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // register to receive keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    // automatically highlight the message input area
    [_messageInput becomeFirstResponder];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    // remove the registered observers for keyboard events
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)cancelButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)sendButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Keyboard Notifications

- (void)keyboardWillShow:(NSNotification *)notification {
    
    CGRect frameEnd;
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    
    NSDictionary *userInfo = [notification userInfo];
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&frameEnd];
    
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(UIViewAnimationOptionBeginFromCurrentState)
                     animations:^{
                         
                         CGFloat viewHeight = [self.view convertRect:frameEnd fromView:nil].origin.y;
                         
                         _selectChannelArea.frame = CGRectMake(_selectChannelArea.frame.origin.x, viewHeight - _selectChannelArea.frame.size.height, _selectChannelArea.frame.size.width, _selectChannelArea.frame.size.height);
                         
                         
    } completion:nil];
    
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    
    
}

@end