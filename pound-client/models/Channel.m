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
        
        // initialize the properties
        _name = [dictionary valueForKey:@"key"];
        
    }
    
    return self;
    
}

@end
