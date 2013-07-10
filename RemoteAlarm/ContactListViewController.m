//
//  ContactListViewController.m
//  RemoteAlarm
//
//  Created by Phoebe Lv on 29/06/13.
//  Copyright (c) 2013 Alan Huang. All rights reserved.
//

#import "ContactListViewController.h"
#import <AddressBook/AddressBook.h>
#import "RAPerson.h"

@interface ContactListViewController ()

@end

@implementation ContactListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Retrieve system contacts
        
        contactList = [[NSMutableArray alloc] init];
        
        CFErrorRef *error = nil;
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(nil, error);
        CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
        CFIndex nPeople = ABAddressBookGetPersonCount(addressBook);
        
        for (NSInteger i = 0; i < nPeople; i++)
        {
            RAPerson *aPerson = [[RAPerson alloc] init];
            
            // Get name and record ID
            ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
            CFTypeRef firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
            CFTypeRef lastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
            ABRecordID recordID = ABRecordGetRecordID(person);
            
            // Get telephone numbers
            ABMultiValueRef tels= ABRecordCopyValue(person, kABPersonPhoneProperty);
            NSMutableArray *telArray = nil;
            if (tels != nil)
            {
                NSInteger count = ABMultiValueGetCount(tels);
                if (count > 0)
                {
                    telArray = [[NSMutableArray alloc] init];
                    
                    for (NSInteger j = 0; j < count; j++)
                    {
                        CFTypeRef tel = ABMultiValueCopyValueAtIndex(tels, j);
                        [telArray addObject:(__bridge_transfer NSString*)tel];

                        CFRelease(tel);
                    }
                }
            }
            
            // Get email addresses
            ABMultiValueRef emails = ABRecordCopyValue(person, kABPersonEmailProperty);
            NSMutableArray *emailArray = nil;
            if (emails != nil)
            {
                NSInteger count = ABMultiValueGetCount(emails);
                if (count > 0)
                {
                    emailArray = [[NSMutableArray alloc] init];
                    
                    for (NSInteger j = 0; j < count; j++)
                    {
                        CFTypeRef email = ABMultiValueCopyValueAtIndex(emails, j);
                        [emailArray addObject:(__bridge_transfer NSString*)email];
                        
                        CFRelease(email);
                    }
                }
            }
            
            // Add contact to the array
            [aPerson setFirstName:(__bridge_transfer NSString*)firstName];
            [aPerson setLastName:(__bridge_transfer NSString*)lastName];
            [aPerson setRecordID:(NSInteger)recordID];
            [aPerson setTel:telArray];
            [aPerson setEmail:emailArray];

            [contactList addObject:aPerson];

            // Release CF objects
            CFRelease(firstName);
            CFRelease(lastName);
            CFRelease(tels);
            CFRelease(emails);
        }
        
        CFRelease(addressBook);
    }
    return self;
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
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"debug"
                                                    message:str
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
