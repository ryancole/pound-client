//
//  ComposeMessageViewController.m
//  pound-client
//
//  Created by Ryan Cole on 12/29/12.
//  Copyright (c) 2012 Ryan Cole. All rights reserved.
//

#import "ComposeMessageViewController.h"
#import "SelectRecipientViewController.h"
#import "APIClient.h"
#import "Utilities.h"

@interface ComposeMessageViewController () <UITextViewDelegate, SelectRecipientDelegate>

@property (nonatomic, strong) UITextView *messageInput;
@property (nonatomic, strong) UIBarButtonItem *sendButton;
@property (nonatomic, strong) NSString *selectedRecipientName;
@property (nonatomic, strong) UILabel *selectedRecipientLabel;
@property (nonatomic, strong) UIImageView *selectRecipientArea;

@end

@implementation ComposeMessageViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    // initialize the button items
    _sendButton = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleDone target:self action:@selector(sendButtonPressed:)];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    
    [items addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed:)]];
    [items addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil]];
    [items addObject:_sendButton];
    
    // add the various toolbar items to the toolbar
    [toolbar setItems:items];
    
    // add the toolbar to this view's subview
    [self.view addSubview:toolbar];
    
    // initialize the message input area
    _messageInput = [[UITextView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height)];
    _messageInput.delegate = self;
    
    // add the message input area to the view
    [self.view addSubview:_messageInput];
    
    // initialize the select channel area
    _selectRecipientArea = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44)];
    _selectRecipientArea.image = [[UIImage imageNamed:@"MessageInputBarBackground"] resizableImageWithCapInsets:UIEdgeInsetsMake(19, 3, 19, 3)];
    _selectRecipientArea.userInteractionEnabled = YES;
    
    // add the channel select area to the view
    [self.view addSubview:_selectRecipientArea];
    
    _selectedRecipientName = [Utilities sharedInstance].previousRecipient;
    
    // initialize the label for the channel select area
    _selectedRecipientLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, _selectRecipientArea.frame.size.height)];
    _selectedRecipientLabel.text = [NSString stringWithFormat:@"To: %@", _selectedRecipientName];
    _selectedRecipientLabel.backgroundColor = [UIColor clearColor];
    _selectedRecipientLabel.textColor = [UIColor grayColor];
    
    // add the label to the recipient select area
    [_selectRecipientArea addSubview:_selectedRecipientLabel];
    
    UIButton *selectRecipientButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    
    // adjust the select recipient button's frame
    selectRecipientButton.frame = CGRectMake(_selectRecipientArea.frame.size.width - (selectRecipientButton.frame.size.width + 10),
                                             0,
                                             selectRecipientButton.frame.size.width,
                                             _selectRecipientArea.frame.size.height);
    
    // add an event target handler to the select button
    [selectRecipientButton addTarget:self
                              action:@selector(addRecipientButtonPressed:)
                    forControlEvents:UIControlEventTouchUpInside];
    
    // add the select recipient button to the button area
    [_selectRecipientArea addSubview:selectRecipientButton];
    
    // default the send button to disabled
    _sendButton.enabled = NO;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // register to receive keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    // automatically highlight the message input area
    [_messageInput becomeFirstResponder];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    // remove the registered observers for keyboard events
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)cancelButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)sendButtonPressed:(id)sender {
    
    // disable the send button so it cannot be pressed again
    _sendButton.enabled = NO;
    
    // send the request to the api server
    [[APIClient sharedInstance] sendMessage:_messageInput.text
                                  toRecipient:_selectedRecipientName
                                    success:^{
                                        
                                        [self dismissViewControllerAnimated:YES completion:^{
                                            
                                            [_delegate messageWasSent:_messageInput.text toRecipient:_selectedRecipientName];
                                            
                                        }];
                                        
                                    }
                                    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                        
                                        // re-enable the send button
                                        _sendButton.enabled = YES;
                                        
                                    }];
    
}

- (void)addRecipientButtonPressed:(id)sender {
    
    SelectRecipientViewController *view = [[SelectRecipientViewController alloc] init];
    
    // the view should slide up from the bottom and cover everything
    view.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    view.modalPresentationStyle = UIModalPresentationFormSheet;
    view.delegate = self;
    
    // bring up the view
    [self presentViewController:view animated:YES completion:nil];
    
}

#pragma mark - Keyboard Notifications

- (void)keyboardWillShow:(NSNotification *)notification {
    
    CGRect frameEnd;
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    
    NSDictionary *userInfo = [notification userInfo];
    
    // get the keyboard details from the notification object
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&frameEnd];
    
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(UIViewAnimationOptionBeginFromCurrentState)
                     animations:^{
                         
                         CGFloat viewHeight = [self.view convertRect:frameEnd
                                                            fromView:nil].origin.y;
                         
                         // adjust the frame of the select channel area
                         _selectRecipientArea.frame = CGRectMake(_selectRecipientArea.frame.origin.x,
                                                               viewHeight - _selectRecipientArea.frame.size.height,
                                                               _selectRecipientArea.frame.size.width,
                                                               _selectRecipientArea.frame.size.height);
                         
    } completion:nil];
    
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    CGRect frameEnd;
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    
    NSDictionary *userInfo = [notification userInfo];
    
    // get the keyboard details from the notification object
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&frameEnd];
    
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(UIViewAnimationOptionBeginFromCurrentState)
                     animations:^{
                         
                         CGFloat viewHeight = [self.view convertRect:frameEnd
                                                            fromView:nil].origin.y;
                         
                         // adjust the frame of the select channel area
                         _selectRecipientArea.frame = CGRectMake(_selectRecipientArea.frame.origin.x,
                                                                 viewHeight - _selectRecipientArea.frame.size.height,
                                                                 _selectRecipientArea.frame.size.width,
                                                                 _selectRecipientArea.frame.size.height);
                         
                     }
                     completion:nil];
    
}

#pragma mark - SelectRecipientDelegate

- (void)recipientWasSelected:(NSString *)recipient {
    
    // save the selected recipient text
    _selectedRecipientName = recipient;
    
    // also in the global
    [[Utilities sharedInstance] setPreviousRecipient:recipient];
    
    // update the label
    _selectedRecipientLabel.text = [NSString stringWithFormat:@"To: %@", recipient];
    
    // adjust the send button state
    if (_selectedRecipientName.length > 0 && _messageInput.text.length > 0) {
        
        _sendButton.enabled = YES;
        
    } else {
        
        _sendButton.enabled = NO;
        
    }
    
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    
    if (_selectedRecipientName.length > 0 && _messageInput.text.length > 0) {
        
        _sendButton.enabled = YES;
        
    } else {
        
        _sendButton.enabled = NO;
        
    }
    
}

@end