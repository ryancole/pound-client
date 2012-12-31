//
//  APIClient.h
//  pound-client
//
//  Created by Ryan Cole on 12/26/12.
//  Copyright (c) 2012 Ryan Cole. All rights reserved.
//

#import "../Pods/AFNetworking/AFNetworking/AFHTTPClient.h"

@interface APIClient : AFHTTPClient

+ (APIClient *)sharedInstance;

- (void)getMessages:(void (^)(NSMutableArray *messages))success
            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)getMessagesSince:(NSString *)offset
                 success:(void (^)(NSMutableArray *messages))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)sendMessage:(NSString *)message
            success:(void (^)())success
            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)getChannels:(void (^)(NSMutableArray *channels))success
            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
