//
//  Message.h
//  pound-client
//
//  Created by Ryan Cole on 12/27/12.
//  Copyright (c) 2012 Ryan Cole. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *destination;
@property (nonatomic, strong) NSDate *timestamp;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
