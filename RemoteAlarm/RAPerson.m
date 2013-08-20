//
//  RAPerson.m
//  RemoteAlarm
//
//  Created by Alan Huang on 9/07/13.
//  Copyright (c) 2013 Alan Huang. All rights reserved.
//

#import "RAPerson.h"
#import "RAUtility.h"

@implementation RAPerson

@synthesize recordID, firstName, lastName, tel, email, status;

- (id)init
{
    self = [super init];
    if (self)
    {
        personID = [RAUtility getUUID];
        [self setRecordID:0];
        [self setFirstName:@""];
        [self setLastName:@""];
        [self setTel:[[NSMutableArray alloc] init]];
        [self setEmail:[[NSMutableArray alloc] init]];
        [self setStatus:kPersonStatusNonMember];
    }
    
    return self;
}

@end
