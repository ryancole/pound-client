//
//  Channel.m
//  pound-client
//
//  Created by Ryan Cole on 12/30/12.
//  Copyright (c) 2012 Ryan Cole. All rights reserved.
//

#import "Channel.h"

@implementation Channel

- (id)initWithDictionary:(NSDictionary *)dictionary {
    
    if ((self = [super init])) {
        
        NSDictionary *users = [dictionary valueForKey:@"users"];
        
        // initialize the properties
        _name = [dictionary valueForKey:@"key"];
        _users = [NSArray arrayWithArray:users.allKeys];
        
    }
    
    return self;
    
}

@end
