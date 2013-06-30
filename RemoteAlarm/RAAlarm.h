//
//  RAAlarm.h
//  RemoteAlarm
//
//  Created by Phoebe Lv on 30/06/13.
//  Copyright (c) 2013 Alan Huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RAAlarm : NSObject <NSCoding>

@property (nonatomic, strong) NSDate *alarmTime;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *senderName;
@property (nonatomic, strong) NSString *senderID;
@property (nonatomic, strong) NSString *receiverName;
@property (nonatomic, strong) NSString *receiverID;
@property (nonatomic, strong) NSString *ringtone;
@property (nonatomic, strong) NSDate *dateCreated;

@end
