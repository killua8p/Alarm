//
//  RAAlarmStore.h
//  RemoteAlarm
//
//  Created by Phoebe Lv on 30/06/13.
//  Copyright (c) 2013 Alan Huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RAAlarm;

@interface RAAlarmStore : NSObject
{
    NSMutableArray *allItems;
}

+ (RAAlarmStore *)sharedStore;

- (NSArray *)allItems;
- (RAAlarm *)createItem;
- (void)removeItem:(RAAlarmStore *)p;
- (NSString *)itemArchivePath;
- (BOOL)saveChanges;

@end
