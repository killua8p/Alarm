//
//  RAAlarm.m
//  RemoteAlarm
//
//  Created by Phoebe Lv on 30/06/13.
//  Copyright (c) 2013 Alan Huang. All rights reserved.
//

#import "RAAlarm.h"

@implementation RAAlarm

@synthesize alarmTime, message, senderName, senderID, ringtone, dateCreated;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        [self setAlarmTime:[aDecoder decodeObjectForKey:@"alarmTime"]];
        [self setMessage:[aDecoder decodeObjectForKey:@"message"]];
        [self setSenderName:[aDecoder decodeObjectForKey:@"senderName"]];
        [self setSenderID:[aDecoder decodeObjectForKey:@"senderID"]];
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
    [aCoder encodeObject:ringtone forKey:@"ringtone"];
    [aCoder encodeObject:dateCreated forKey:@"dateCreated"];
}

@end
