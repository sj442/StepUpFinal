//
//  AdminPostCreate.h
//  StepUp1
//
//  Created by Sunayna Jain on 5/7/14.
//  Copyright (c) 2014 LittleAuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "CalendarListVC.h"


@interface AdminPostCreate : UIViewController <UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate, eventSelectDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) Event *eventSelected;

@end
