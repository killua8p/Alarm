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
    [isEnabled setOn:[alarm isEnabled]];
}

- (IBAction)sendAlarm:(UIButton *)sender
{    
    [alarm setReceiverName:[receiverName text]];
    [alarm setMessage:[message text]];
    [alarm setAlarmTime:[datePicker date]];
    [alarm setDateCreated:[NSDate date]];
    
    
    NSUInteger index = [[[RAAlarmStore sharedStore] allAlarms] indexOfObject:alarm];
    if (index == NSNotFound)
    {//Add
        [[RAAlarmStore sharedStore] addAlarm:alarm];
    }
    
    // Return last view
    [[self navigationController] popViewControllerAnimated:YES];
}

// Dismiss keyboard when clicking the background
- (IBAction)backgroundTapped:(id)sender
{
    [[self view] endEditing:YES];
}

// The alarm is turned on or turned off
- (IBAction)switchChanged:(UISwitch *)sender
{
    [alarm setIsEnabled:[sender isOn]];
}

@end
