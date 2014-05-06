//
//  EventCreateVC.h
//  StepUp1
//
//  Created by Sunayna Jain on 3/25/14.
//  Copyright (c) 2014 LittleAuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventCreateVC : UITableViewController<UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>

@property (nonatomic, strong) NSString *date;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *description;

@property (nonatomic, strong) NSString *time;

@property (nonatomic, strong) NSString *address;

@property BOOL editMode;

@property  (nonatomic, strong) NSNumber *eventIndex;

@end
