//
//  chatViewController.h
//  StepUp1
//
//  Created by Sunayna Jain on 2/16/14.
//  Copyright (c) 2014 LittleAuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface chatViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@end
