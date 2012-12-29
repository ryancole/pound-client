//
//  Message.m
//  pound-client
//
//  Created by Ryan Cole on 12/27/12.
//  Copyright (c) 2012 Ryan Cole. All rights reserved.
//

#import "Message.h"

@implementation Message

- (id)initWithDictionary:(NSDictionary *)dictionary {
    
    if ((self = [super init])) {
        
        // get the embedded value document
        NSDictionary *value = [dictionary valueForKey:@"value"];
        
        // initialize the properties
        self.id = [value valueForKey:@"_id"];
        self.source = [value valueForKey:@"source"];
        self.message = [value valueForKey:@"message"];
        self.destination = [value valueForKey:@"destination"];
        self.timestamp = [NSDate dateWithTimeIntervalSince1970:[[value objectForKey:@"timestamp"] integerValue]];
        
    }
    
    return self;
    
}

@end
