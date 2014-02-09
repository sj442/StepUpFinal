//
//  CalendarCell.h
//  StepUp
//
//  Created by Sunayna Jain on 2/8/14.
//
//

#import <UIKit/UIKit.h>

@interface CalendarCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *headerLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *colorLabel;



@end
