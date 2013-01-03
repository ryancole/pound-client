//
//  ComposeMessageViewController.h
//  pound-client
//
//  Created by Ryan Cole on 12/31/12.
//  Copyright (c) 2012 Ryan Cole. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ComposeMessageDelegate <NSObject>

- (void)messageWasSent:(NSString *)message
           toRecipient:(NSString *)recipient;

@end


@interface ComposeMessageViewController : UIViewController

@property (nonatomic, assign) id<ComposeMessageDelegate> delegate;

@end
