//
//  SelectRecipientViewController.h
//  pound-client
//
//  Created by Ryan Cole on 1/2/13.
//  Copyright (c) 2013 Ryan Cole. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectRecipientDelegate <NSObject>

- (void)recipientWasSelected:(NSString *)recipient;

@end

@interface SelectRecipientViewController : UIViewController

@property (nonatomic, assign) id<SelectRecipientDelegate> delegate;

@end
