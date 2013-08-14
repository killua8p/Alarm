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

NSString *theDeviceToken;

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
    
    // Register for push notification
    // TODO: determine if pushnotification is already registered
    UIRemoteNotificationType types = (UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound);
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:types];
        
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Alarm" message:[notification alertBody] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [av show];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    theDeviceToken = [deviceToken description];
    // Trim "<" and ">"
    theDeviceToken = [theDeviceToken stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    // Remove spaces
    theDeviceToken = [theDeviceToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"FailToRegisterForRemoteNotifications: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Alarm" message:[NSString stringWithFormat:@"%@", userInfo] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [av show];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
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
