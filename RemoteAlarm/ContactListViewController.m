//
//  ContactListViewController.m
//  RemoteAlarm
//
//  Created by Phoebe Lv on 29/06/13.
//  Copyright (c) 2013 Alan Huang. All rights reserved.
//

#import "ContactListViewController.h"
#import "RAUtility.h"
#import "RAPerson.h"

@interface ContactListViewController ()

@end

@implementation ContactListViewController

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        contactList = [RAUtility getSystemContactList];
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [[self tableView] reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [contactList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ContactCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    RAPerson *aPerson = [contactList objectAtIndex:[indexPath row]];
    // Set main label as name
    [[cell textLabel] setText:[NSString stringWithFormat:@"%@ %@", [aPerson firstName], [aPerson lastName]]];
    // Set detail label as tel
    if ([aPerson tel] != nil && [[aPerson tel] count] > 0)
    {
        [[cell detailTextLabel] setText:[[aPerson tel] objectAtIndex:0]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RAPerson *person = [contactList objectAtIndex:[indexPath row]];
    NSArray *telArray = [person tel];
    NSMutableString *str = [[NSMutableString alloc] init];
    for (NSString *p in telArray)
    {
        [str appendFormat:@"%@\n", p];
    }
    
    // debug
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"debug"
                                                    message:str
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
