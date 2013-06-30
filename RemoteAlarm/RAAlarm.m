//
//  RAAlarm.m
//  RemoteAlarm
//
//  Created by Phoebe Lv on 30/06/13.
//  Copyright (c) 2013 Alan Huang. All rights reserved.
//

#import "RAAlarm.h"

@implementation RAAlarm

@synthesize alarmTime, message, senderName, senderID, receiverName, receiverID, ringtone, dateCreated;

- (id)init
{
    self = [super init];
    if (self)
    {
        [self setAlarmTime:[NSDate date]];
        [self setMessage:@""];
        [self setSenderID:@""];
        [self setSenderName:@""];
        [self setReceiverID:@""];
        [self setReceiverName:@""];
        [self setRingtone:@""];
        [self setDateCreated:[NSDate date]];
    }
    
    return self;
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
