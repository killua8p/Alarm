//
//  AlarmListViewController.m
//  RemoteAlarm
//
//  Created by Phoebe Lv on 29/06/13.
//  Copyright (c) 2013 Alan Huang. All rights reserved.
//

#import "AlarmListViewController.h"

@implementation AlarmListViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [[cell textLabel] setText:@"No1"];
    
    return cell;
}

@end
