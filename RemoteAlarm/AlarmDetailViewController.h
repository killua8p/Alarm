//
//  AlarmDetailViewController.h
//  RemoteAlarm
//
//  Created by Alan Huang on 30/06/13.
//  Copyright (c) 2013 Alan Huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RAAlarm;

@interface AlarmDetailViewController : UIViewController
{
    __weak IBOutlet UIDatePicker *datePicker;
    __weak IBOutlet UITextField *receiverName;
    __weak IBOutlet UITextField *message;
    __weak IBOutlet UISwitch *isEnabled;
}
@property (nonatomic, strong) RAAlarm *alarm;

- (IBAction)sendAlarm:(UIButton *)sender;
- (IBAction)backgroundTapped:(id)sender;
- (IBAction)switchChanged:(UISwitch *)sender;

@end
