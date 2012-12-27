//
//  APIClient.h
//  pound-client
//
//  Created by Ryan Cole on 12/26/12.
//  Copyright (c) 2012 Ryan Cole. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../Pods/AFNetworking/AFNetworking/AFHTTPClient.h"

@interface APIClient : AFHTTPClient

+ (APIClient *)sharedInstance;

- (void)getMessagesWithLimit:(int)limit
                     success:(void (^)(id messages))success
                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
