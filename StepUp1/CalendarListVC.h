//
//  CalendarListVC.h
//  StepUp1
//
//  Created by Sunayna Jain on 5/7/14.
//  Copyright (c) 2014 LittleAuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarListVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@end
