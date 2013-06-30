//
//  AlarmDetailViewController.m
//  RemoteAlarm
//
//  Created by Alan Huang on 30/06/13.
//  Copyright (c) 2013 Alan Huang. All rights reserved.
//

#import "AlarmDetailViewController.h"
#import "RAAlarm.h"
#import "RAAlarmStore.h"

@implementation AlarmDetailViewController

@synthesize alarm;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    // Pre-populate fields
    [datePicker setDate:[alarm alarmTime]];
    [message setText:[alarm message]];
    [receiverName setText:[alarm receiverName]];
}

- (IBAction)sendAlarm:(UIButton *)sender
{
    NSArray *allAlarms = [[RAAlarmStore sharedStore] allAlarms];
    
    if ([allAlarms count] == 0)
    {// Add
        NSLog(@"[allAlarms count] == 0");
        [[RAAlarmStore sharedStore] addAlarm:alarm];
    }
    else
    {
        NSUInteger index = [[[RAAlarmStore sharedStore] allAlarms] indexOfObject:alarm];
        if (index == NSNotFound)
        {
            NSLog(@"index == NSNotFound");
            //Add
            [[RAAlarmStore sharedStore] addAlarm:alarm];
        }
    }
    
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
