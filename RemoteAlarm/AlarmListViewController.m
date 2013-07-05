//
//  AlarmListViewController.m
//  RemoteAlarm
//
//  Created by Phoebe Lv on 29/06/13.
//  Copyright (c) 2013 Alan Huang. All rights reserved.
//

#import "AlarmListViewController.h"
#import "RAAlarmStore.h"
#import "RAAlarm.h"
#import "AlarmDetailViewController.h"

@implementation AlarmListViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        [[self navigationItem] setTitle:@"Alarm"];
        
        // Add the 'add' and 'edit' bar buttons
        UIBarButtonItem *addBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem)];
        [[self navigationItem] setLeftBarButtonItem:addBarButton];
        [[self navigationItem] setRightBarButtonItem:[self editButtonItem]];
    }
    
    return self;
}

// Add
- (void)addNewItem
{
    // Create a new alarm item
    RAAlarm *alarm = [[RAAlarm alloc] init];
    
    // Show the alarm detail view
    AlarmDetailViewController *detailVC = [[AlarmDetailViewController alloc] init];
    [detailVC setAlarm:alarm];
    [[self navigationController] pushViewController:detailVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [[self tableView] reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[RAAlarmStore sharedStore] allAlarms] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Get the Alarm item
    RAAlarm *alarm = [[[RAAlarmStore sharedStore] allAlarms] objectAtIndex:[indexPath row]];
    
    // Set cell text
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [[cell textLabel] setText:[dateFormatter stringFromDate:[alarm alarmTime]]];
    [[cell detailTextLabel] setText:[alarm receiverName]]; //TODO
    
    return cell;
}

// Edit
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RAAlarm *alarm = [[[RAAlarmStore sharedStore] allAlarms] objectAtIndex:[indexPath row]];
    
    AlarmDetailViewController *detailVC = [[AlarmDetailViewController alloc] init];
    [detailVC setAlarm:alarm];
    [[self navigationController] pushViewController:detailVC animated:YES];
}

// Delete
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Remove the alarm from store
        RAAlarm *p = [[[RAAlarmStore sharedStore] allAlarms] objectAtIndex:[indexPath row]];
        [[RAAlarmStore sharedStore] removeAlarm:p];
        
        // Remove the alarm from tableview
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
