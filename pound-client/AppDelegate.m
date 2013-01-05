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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // set the tab bar delegate
    UITabBarController *tabBarController = (UITabBarController *)_window.rootViewController;
    tabBarController.delegate = self;
    
    return YES;
}

#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    if (tabBarController.selectedViewController == viewController && [viewController isKindOfClass:[MessageListViewController class]]) {
        
        // get reference to the selected view controller
        MessageListViewController *messageList = (MessageListViewController *)viewController;
        
        // scroll the table to the top
        [messageList scrollTableToTop];
        
        return NO;
        
    }
    
    return YES;
    
}

@end
