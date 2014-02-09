//
//  NewEventViewController.h
//  StepUp
//
//  Created by Sunayna Jain on 2/8/14.
//
//

#import <UIKit/UIKit.h>

@interface NewEventViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
