//
//  RAAlarm.m
//  RemoteAlarm
//
//  Created by Phoebe Lv on 30/06/13.
//  Copyright (c) 2013 Alan Huang. All rights reserved.
//

#import "RAAlarm.h"

NSString * const kKeyOfNotificationID = @"ID";

@implementation RAAlarm

@synthesize alarmTime, message, senderName, senderID, receiverName, receiverID, ringtone, dateCreated, isEnabled;

- (id)init
{
    self = [super init];
    if (self)
    {
        alarmID = [self getUUID];
        // Not using setter to avoid resetting local notification at the launch
        alarmTime = [NSDate date];
        [self setMessage:@"Time is up!"];
        [self setSenderID:@""];
        [self setSenderName:@""];
        [self setReceiverID:@""];
        [self setReceiverName:@""];
        [self setRingtone:@""];
        [self setDateCreated:[NSDate date]];
        // Not using setter to avoid resetting local notification at the launch
        isEnabled = FALSE;
    }
    
    return self;
}

- (NSString *)getUUID
{
    CFUUIDRef UUIDRef = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef UUIDString = CFUUIDCreateString(kCFAllocatorDefault, UUIDRef);
    NSString *strUUID = (__bridge_transfer NSString*)UUIDString;
    
    CFRelease(UUIDRef);
    
    return strUUID;
}

- (void)setIsEnabled:(BOOL)value
{
    // Return if the isEnabled variable doesn't change
    if (isEnabled == value)
    {
        return;
    }
    
    isEnabled = value;
    
    if (isEnabled)
    {
        // The alarm is ENABLED

        // Set up local notification
        UILocalNotification *localNotif = [[UILocalNotification alloc] init];
        [localNotif setFireDate:alarmTime];
        [localNotif setAlertBody:[self message]];
        [localNotif setAlertAction:@"OK"];
        [localNotif setSoundName:UILocalNotificationDefaultSoundName];
        
        if (alarmID)
        {
            NSDictionary *dict = [NSDictionary dictionaryWithObject:alarmID forKey:kKeyOfNotificationID];
            [localNotif setUserInfo:dict];
            [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
            NSLog(@"Local notification has been added");
        }
        else
        {
            NSLog(@"alarmID is nil");
        }
    }
    else
    {
        // The alarm is DISABLED

        // Remove the local notification
        NSArray *localNotifArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
        if (localNotifArray)
        {
            for (UILocalNotification *ln in localNotifArray)
            {
                if ([[[ln userInfo] objectForKey:kKeyOfNotificationID] isEqualToString:alarmID])
                {
                    [[UIApplication sharedApplication] cancelLocalNotification:ln];
                    NSLog(@"Local notification has been removed");
                }
            }
        }
    }
}

- (void)setAlarmTime:(NSDate *)t
{
    // If time has not been changed do nothing
    if (alarmTime && [alarmTime compare:t] == NSOrderedSame)
    {
        return;
    }
    
    // Save alarm time
    alarmTime = t;

//    NSDate *currentTime = [NSDate date];
//    if ([t compare:currentTime] == NSOrderedAscending)
//    {
//        // If it's past time
//        // Set Next Day + Time as alarm time
//        alarmTime = [t dateByAddingTimeInterval:24*60*60];
//    }
//    else
//    {
//        // If it's current time or furture time
//        // Set Current Day + Time as alarm time
//        alarmTime = t;
//    }
    
    // If the alarm is on, reset the local notification
    if (isEnabled)
    {
        [self setIsEnabled: FALSE];
        [self setIsEnabled: TRUE];
    }
}

// Unarchive
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        alarmID = [aDecoder decodeObjectForKey:@"alarmID"];
        // Not using setter to avoid resetting local notification at the launch
        alarmTime = [aDecoder decodeObjectForKey:@"alarmTime"];
        [self setMessage:[aDecoder decodeObjectForKey:@"message"]];
        [self setSenderName:[aDecoder decodeObjectForKey:@"senderName"]];
        [self setSenderID:[aDecoder decodeObjectForKey:@"senderID"]];
        [self setReceiverName:[aDecoder decodeObjectForKey:@"receiverName"]];
        [self setReceiverID:[aDecoder decodeObjectForKey:@"receiverID"]];
        [self setRingtone:[aDecoder decodeObjectForKey:@"ringtone"]];
        [self setDateCreated:[aDecoder decodeObjectForKey:@"dateCreated"]];
        // Not using setter to avoid resetting local notification at the launch
        isEnabled = [aDecoder decodeBoolForKey:@"isEnabled"];
    }
    
    return self;
}

// Archive
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:alarmID forKey:@"alarmID"];
    [aCoder encodeObject:alarmTime forKey:@"alarmTime"];
    [aCoder encodeObject:message forKey:@"message"];
    [aCoder encodeObject:senderName forKey:@"senderName"];
    [aCoder encodeObject:senderID forKey:@"senderID"];
    [aCoder encodeObject:receiverName forKey:@"receiverName"];
    [aCoder encodeObject:receiverID forKey:@"receiverID"];
    [aCoder encodeObject:ringtone forKey:@"ringtone"];
    [aCoder encodeObject:dateCreated forKey:@"dateCreated"];
    [aCoder encodeBool:isEnabled forKey:@"isEnabled"];
}

@end
