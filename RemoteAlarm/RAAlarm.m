//
//  RAAlarm.m
//  RemoteAlarm
//
//  Created by Phoebe Lv on 30/06/13.
//  Copyright (c) 2013 Alan Huang. All rights reserved.
//

#import "RAAlarm.h"

@implementation RAAlarm

@synthesize alarmTime, message, senderName, senderID, receiverName, receiverID, ringtone, dateCreated, isEnabled;

- (id)init
{
    self = [super init];
    if (self)
    {
        [self setAlarmTime:[NSDate date]];
        [self setMessage:@"Time is up!"];
        [self setSenderID:@""];
        [self setSenderName:@""];
        [self setReceiverID:@""];
        [self setReceiverName:@""];
        [self setRingtone:@""];
        [self setDateCreated:[NSDate date]];
        [self setIsEnabled:FALSE];
    }
    
    return self;
}

- (void)setIsEnabled:(BOOL)value
{
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
        
    }
    else
    {
        // The alarm is DISABLED
        
    }
}

- (void)setAlarmTime:(NSDate *)t
{
    // Save alarm time
    NSDate *currentTime = [NSDate date];
    if ([t compare:currentTime] == NSOrderedAscending)
    {
        // If it's past time
        // Set Next Day + Time as alarm time
        alarmTime = [t dateByAddingTimeInterval:24*60*60];
    }
    else
    {
        // If it's current time or furture time
        // Set Current Day + Time as alarm time
        alarmTime = t;
    }
    // Set up local notification
//    [localNotif setFireDate:alarmTime];
//    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];

}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        [self setAlarmTime:[aDecoder decodeObjectForKey:@"alarmTime"]];
        [self setMessage:[aDecoder decodeObjectForKey:@"message"]];
        [self setSenderName:[aDecoder decodeObjectForKey:@"senderName"]];
        [self setSenderID:[aDecoder decodeObjectForKey:@"senderID"]];
        [self setReceiverName:[aDecoder decodeObjectForKey:@"receiverName"]];
        [self setReceiverID:[aDecoder decodeObjectForKey:@"receiverID"]];
        [self setRingtone:[aDecoder decodeObjectForKey:@"ringtone"]];
        [self setDateCreated:[aDecoder decodeObjectForKey:@"dateCreated"]];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:alarmTime forKey:@"alarmTime"];
    [aCoder encodeObject:message forKey:@"message"];
    [aCoder encodeObject:senderName forKey:@"senderName"];
    [aCoder encodeObject:senderID forKey:@"senderID"];
    [aCoder encodeObject:receiverName forKey:@"receiverName"];
    [aCoder encodeObject:receiverID forKey:@"receiverID"];
    [aCoder encodeObject:ringtone forKey:@"ringtone"];
    [aCoder encodeObject:dateCreated forKey:@"dateCreated"];
}

@end
