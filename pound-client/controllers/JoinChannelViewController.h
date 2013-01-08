//
//  JoinChannelViewController.h
//  pound-client
//
//  Created by Ryan Cole on 1/7/13.
//  Copyright (c) 2013 Ryan Cole. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JoinChannelDelegate <NSObject>

- (void)channelWithName:(NSString *)channel wasJoined:(BOOL)success;

@end

@interface JoinChannelViewController : UIViewController

@property (nonatomic, assign) id<JoinChannelDelegate> delegate;

@end
