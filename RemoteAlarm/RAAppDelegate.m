//
//  RAAppDelegate.m
//  RemoteAlarm
//
//  Created by Alan Huang on 30/06/13.
//  Copyright (c) 2013 Alan Huang. All rights reserved.
//

#import "RAAppDelegate.h"
#import "AlarmListViewController.h"
#import "ContactListViewController.h"
#import "RAAlarmStore.h"

@implementation RAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    // Alarm List
    AlarmListViewController *avc = [[AlarmListViewController alloc] init];
    UINavigationController *anv = [[UINavigationController alloc] initWithRootViewController:avc];
    [[anv tabBarItem] setTitle:@"Alarm"];
    
    // Contact List
    ContactListViewController *cvc = [[ContactListViewController alloc] init];
    UINavigationController *cnv = [[UINavigationController alloc] initWithRootViewController:cvc];
    [[cnv tabBarItem] setTitle:@"Contact"];
    
    // Tab View
    UITabBarController *tbc = [[UITabBarController alloc] init];
    NSArray *controllers = [NSArray arrayWithObjects:anv, cnv, nil];
    [tbc setViewControllers:controllers];
    
    // Set root view
    [[self window] setRootViewController:tbc];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    BOOL success = [[RAAlarmStore sharedStore] saveChanges];
    if (success)
    {
        NSLog(@"Saved the alarm store");
    }
    else
    {
        NSLog(@"Failed to save the alarm store");
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
