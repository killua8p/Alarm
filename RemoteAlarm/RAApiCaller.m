//
//  RAApiCaller.m
//  RemoteAlarm
//
//  Created by Phoebe Lv on 3/08/13.
//  Copyright (c) 2013 Alan Huang. All rights reserved.
//

#import "RAApiCaller.h"

@implementation RAApiCaller

+ (NSData *)fetchData:(NSString *)theURL
{
    NSError *error;
    NSURL *url = [NSURL URLWithString:theURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    //TODO: error handling
    
    return response;
}

// JSON -> Dictionary
+ (NSDictionary *)parseJSONData:(NSData *)theData
{
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:theData options:NSJSONReadingMutableLeaves|NSJSONReadingMutableContainers error:&error];
    //TODO: error handling
    
    return dict;
}

// Dictionary -> JSON
+ (NSString *)compileJSONString:(NSDictionary *)theDict
{
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:theDict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //TODO: error handling
    
    return str;
}

@end
