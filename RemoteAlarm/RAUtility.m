//
//  RAUtility.m
//  RemoteAlarm
//
//  Created by Phoebe Lv on 20/08/13.
//  Copyright (c) 2013 Alan Huang. All rights reserved.
//

#import "RAUtility.h"
#import <AddressBook/AddressBook.h>
#import "RAPerson.h"

@implementation RAUtility

+ (NSString *)getUUID
{
    CFUUIDRef UUIDRef = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef UUIDString = CFUUIDCreateString(kCFAllocatorDefault, UUIDRef);
    NSString *strUUID = (__bridge_transfer NSString*)UUIDString;
    
    CFRelease(UUIDRef);
    
    return strUUID;
}

+ (NSMutableArray*)getSystemContactList
{
    // Retrieve system contacts
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
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
                }
            }
            CFRelease(tels);
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
                }
            }
            CFRelease(emails);
        }
        
        // Add contact to the array
        
        [aPerson setFirstName:(__bridge_transfer NSString*)firstName];
        [aPerson setLastName:(__bridge_transfer NSString*)lastName];
        [aPerson setRecordID:(NSInteger)recordID];
        [aPerson setTel:telArray];
        [aPerson setEmail:emailArray];
        
        [result addObject:aPerson];
    }
    
    // Release CF objects
    
    CFRelease(allPeople);
    CFRelease(addressBook);
    
    return result;
}

@end
