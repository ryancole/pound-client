//
//  APIClient.m
//  pound-client
//
//  Created by Ryan Cole on 12/26/12.
//  Copyright (c) 2012 Ryan Cole. All rights reserved.
//

#import "APIClient.h"
#import "models/Message.h"
#import "../Pods/AFNetworking/AFNetworking/AFNetworking.h"

@implementation APIClient

+ (APIClient *)sharedInstance {
    
    static APIClient *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _sharedInstance = [[APIClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://ryan-server:8080/"]];
        
    });
    
    return _sharedInstance;
    
}

- (id)initWithBaseURL:(NSURL *)url {
    
    if ((self = [super initWithBaseURL:url])) {
        
        [self setParameterEncoding:AFJSONParameterEncoding];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        
    }
    
    return self;
    
}

- (void)getMessagesWithLimit:(int)limit
                     success:(void (^)(id messages))success
                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    // format the querystring
    NSDictionary *query = @{ @"limit": @(limit) };
    
    // fetch all messages
    [self getPath:@"message" parameters:query success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray *messages = [NSMutableArray array];
        
        // populate the collection with message objects
        for (id message in responseObject) {
            
            [messages addObject:[[Message alloc] initWithDictionary:message]];
            
        }
        
        // pass the messages on
        success(messages);
        
    } failure:failure];
    
}

@end
