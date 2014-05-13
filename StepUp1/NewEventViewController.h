//
//  NewEventViewController.h
//  StepUp
//
//  Created by Sunayna Jain on 2/8/14.
//
//

#import <UIKit/UIKit.h>

@interface NewEventViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>


@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSNumber *eventIndex;


@end
