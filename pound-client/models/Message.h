//
//  Message.h
//  pound-client
//
//  Created by Ryan Cole on 12/27/12.
//  Copyright (c) 2012 Ryan Cole. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *destination;
@property (nonatomic, strong) NSDate *timestamp;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
