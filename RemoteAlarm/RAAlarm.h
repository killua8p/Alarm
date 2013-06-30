//
//  RAAlarm.h
//  RemoteAlarm
//
//  Created by Phoebe Lv on 30/06/13.
//  Copyright (c) 2013 Alan Huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RAAlarm : NSObject

@property (nonatomic, strong) NSDate *time;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *senderName;
@property (nonatomic, strong) NSString *senderID;
@property (nonatomic, strong) NSString *ringtone;

@end
