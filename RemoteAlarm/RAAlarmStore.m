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
        allItems = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (NSArray *)allItems;
{
    return nil;
}

- (RAAlarm *)createItem;
{
    return nil;
}

- (void)removeItem:(RAAlarmStore *)p;
{
    
}

@end
