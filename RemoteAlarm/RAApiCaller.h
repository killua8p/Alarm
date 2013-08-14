//
//  RAApiCaller.h
//  RemoteAlarm
//
//  Created by Phoebe Lv on 3/08/13.
//  Copyright (c) 2013 Alan Huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RAApiCaller : NSObject

+ (NSData *)fetchData:(NSString *)theURL;
+ (NSDictionary *)parseJSONData:(NSData *)theData;
+ (NSString *)compileJSONString:(NSDictionary *)theDict;

@end
