//
//  APIClient.m
//  pound-client
//
//  Created by Ryan Cole on 12/26/12.
//  Copyright (c) 2012 Ryan Cole. All rights reserved.
//

#import "APIClient.h"
#import "models/Message.h"
#import "models/Channel.h"
#import "../Pods/AFNetworking/AFNetworking/AFNetworking.h"

@implementation APIClient

+ (APIClient *)sharedInstance {
    
    static APIClient *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        NSURL *baseApiUrl = [[NSURL alloc] initWithString:[[NSUserDefaults standardUserDefaults] stringForKey:@"baseApiUrl"]];
        
        _sharedInstance = [[APIClient alloc] initWithBaseURL:baseApiUrl];
        
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

- (void)getMessages:(void (^)(NSMutableArray *messages))success
            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    // fetch all messages
    [self getPath:@"message" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray *messages = [NSMutableArray array];
        
        // populate the collection with message objects
        for (id message in responseObject) {
            
            [messages addObject:[[Message alloc] initWithDictionary:message]];
            
        }
        
        // pass the messages on
        success(messages);
        
    } failure:failure];
    
}

- (void)getMessagesSince:(NSString *)endkey
                 success:(void (^)(NSMutableArray *messages))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSDictionary *query = @{ @"endkey": endkey };
    
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

- (void)sendMessage:(NSString *)message
          toChannel:(NSString *)channel
            success:(void (^)())success
            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSDictionary *query = @{ @"message": message };
    
    // send the message
    [self postPath:@"message" parameters:query success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        success();
        
    } failure:failure];
    
}

- (void)getChannels:(void (^)(NSMutableArray *channels))success
            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    // fetch all channels
    [self getPath:@"channel" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray *channels = [NSMutableArray array];
        
        // populate the collection with channel objects
        for (id channel in responseObject) {
            
            [channels addObject:[[Channel alloc] initWithDictionary:channel]];
            
        }
        
        // pass the channels on
        success(channels);
        
    } failure:failure];
    
}

@end
