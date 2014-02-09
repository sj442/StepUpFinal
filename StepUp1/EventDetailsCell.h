//
//  EventDetailsCell.h
//  StepUp
//
//  Created by Sunayna Jain on 2/8/14.
//
//

#import <UIKit/UIKit.h>

@interface EventDetailsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *timeIcon;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *venueIcon;

@property (weak, nonatomic) IBOutlet UITextView *venueTextview;


@property (weak, nonatomic) IBOutlet UITextView *eventDetailsTextView;









@end
