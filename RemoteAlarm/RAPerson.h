//
//  RAPerson.h
//  RemoteAlarm
//
//  Created by Alan Huang on 9/07/13.
//  Copyright (c) 2013 Alan Huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RAPerson : NSObject
{
    NSString *personID;
}

typedef enum {
    kPersonStatusNonMember,
    kPersonStatusNotConnected,
    kPersonStatusConnected
} PersonStatus;

@property NSInteger recordID;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSMutableArray *tel;
@property (nonatomic, strong) NSMutableArray *email;
@property PersonStatus status;

@end
