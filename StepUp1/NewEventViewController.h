//
//  NewEventViewController.h
//  StepUp
//
//  Created by Sunayna Jain on 2/8/14.
//
//

#import <UIKit/UIKit.h>

@interface NewEventViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSNumber *eventIndex;


@end
