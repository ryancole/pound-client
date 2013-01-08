//
//  AppDelegate.m
//  pound-client
//
//  Created by Ryan Cole on 12/26/12.
//  Copyright (c) 2012 Ryan Cole. All rights reserved.
//

#import "AppDelegate.h"
#import "MessageListViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UITabBarController *tabBarController = (UITabBarController *)_window.rootViewController;
    
    // needed to detect which tab item is tapped
    tabBarController.delegate = self;
    
    return YES;
    
}

#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    if (tabBarController.selectedViewController == viewController && [viewController isKindOfClass:[MessageListViewController class]]) {
        
        MessageListViewController *messageList = (MessageListViewController *)viewController;
        
        // scroll the table to the top
        [messageList scrollTableToTop];
        
        // don't fire any selection events
        return NO;
        
    }
    
    return YES;
    
}

@end
