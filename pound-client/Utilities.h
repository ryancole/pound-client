//
//  Utilities.h
//  pound-client
//
//  Created by Ryan Cole on 12/28/12.
//  Copyright (c) 2012 Ryan Cole. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Utilities : NSObject

@property (nonatomic) NSString *previousRecipient;

+ (Utilities *)sharedInstance;
+ (NSString *)relativeTime:(NSDate *)timestamp;

@end
