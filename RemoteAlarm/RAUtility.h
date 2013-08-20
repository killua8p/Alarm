//
//  RAUtility.h
//  RemoteAlarm
//
//  Created by Phoebe Lv on 20/08/13.
//  Copyright (c) 2013 Alan Huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RAUtility : NSObject

+ (NSString *)getUUID;
+ (NSMutableArray*)getSystemContactList;

@end
