//
//  RAAlarmStore.m
//  RemoteAlarm
//
//  Created by Phoebe Lv on 30/06/13.
//  Copyright (c) 2013 Alan Huang. All rights reserved.
//

#import "RAAlarmStore.h"

@implementation RAAlarmStore

// Singleton instance
+ (RAAlarmStore *)sharedStore
{
    static RAAlarmStore *sharedStore = nil;
    
    if (!sharedStore)
    {
        sharedStore = [[super allocWithZone:nil] init];
    }
    
    return sharedStore;
}

// Override allocWithZone to avoid creating new instance
+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        allAlarms = [NSKeyedUnarchiver unarchiveObjectWithFile:[self itemArchivePath]];
    }
    
    // If the array hasn't been saved previously, create a new one
    if (!allAlarms)
    {
        allAlarms = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (NSArray *)allAlarms;
{
    return nil;
}

- (void)addAlarm:(RAAlarm *)p
{
    [allAlarms addObject:p];
}

- (void)removeAlarm:(RAAlarm *)p;
{
    [allAlarms removeObjectIdenticalTo:p];
}

// Path to archive the alarms
- (NSString *)itemArchivePath
{
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [directory stringByAppendingPathComponent:@"alarms.archive"];
}

// Archive alarms
- (BOOL)saveChanges
{
    return [NSKeyedArchiver archiveRootObject:allAlarms toFile:[self itemArchivePath]];
}

@end
