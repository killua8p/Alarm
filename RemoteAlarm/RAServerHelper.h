//
//  RAApiCaller.h
//  RemoteAlarm
//
//  Created by Phoebe Lv on 3/08/13.
//  Copyright (c) 2013 Alan Huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RAAlarm, RAPerson;

@interface RAServerHelper : NSObject

+ (NSData *)fetchData:(NSString *)theURL;
+ (NSDictionary *)parseJSONData:(NSData *)theData;
+ (NSString *)compileJSONString:(NSDictionary *)theDict;
+ (NSDictionary *)registerNewAccount: (NSDictionary *)regDetails;
+ (NSDictionary *)addFriend:(NSString *)personID;
+ (NSDictionary *)acceptFriend:(NSString *)personID;
+ (NSDictionary *)createAlarm:(RAAlarm *)alarm forFriend:(RAPerson *)person;
+ (NSDictionary *)removeAlarm:(RAAlarm *)alarm;

@end
