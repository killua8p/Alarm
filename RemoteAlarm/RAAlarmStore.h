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
    NSMutableArray *allAlarms;
}

+ (RAAlarmStore *)sharedStore;

- (NSArray *)allAlarms;
- (void)addAlarm:(RAAlarm *)p;
- (void)removeAlarm:(RAAlarm *)p;
- (NSString *)itemArchivePath;
- (BOOL)saveChanges;

@end
