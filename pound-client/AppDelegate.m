//
//  AppDelegate.m
//  pound-client
//
//  Created by Ryan Cole on 12/26/12.
//  Copyright (c) 2012 Ryan Cole. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // register the application defaults from settings.bundle
    [self registerDefaultsFromSettingsBundle];
    
    return YES;
}

- (void)registerDefaultsFromSettingsBundle {
    
    NSString *settingsBundle = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:@"Root.plist"]];
    NSArray *preferences = [settings objectForKey:@"PreferenceSpecifiers"];
    NSMutableDictionary *defaultsToRegister = [[NSMutableDictionary alloc] initWithCapacity:[preferences count]];
    
    for (NSDictionary *prefSpecification in preferences) {
        
        NSString *key = [prefSpecification objectForKey:@"Key"];
        
        if (key) {
            
            [defaultsToRegister setObject:[prefSpecification objectForKey:@"DefaultValue"] forKey:key];
            
        }
        
    }
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultsToRegister];
}

@end
