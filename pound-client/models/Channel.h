//
//  Channel.h
//  pound-client
//
//  Created by Ryan Cole on 12/30/12.
//  Copyright (c) 2012 Ryan Cole. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Channel : NSObject

@property (nonatomic, strong) NSString *name;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
