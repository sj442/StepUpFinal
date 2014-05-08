//
//  CalendarListVC.h
//  StepUp1
//
//  Created by Sunayna Jain on 5/7/14.
//  Copyright (c) 2014 LittleAuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@protocol eventSelectDelegate <NSObject>

-(void)eventPassedBackFromEventList:(Event*) event;

@end

@interface CalendarListVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (weak, nonatomic) id<eventSelectDelegate> myDelegate;

@property BOOL fromAdminPost;

@end
