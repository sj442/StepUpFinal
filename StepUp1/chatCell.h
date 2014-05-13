//
//  chatCell.h
//  StepUp1
//
//  Created by Sunayna Jain on 2/17/14.
//  Copyright (c) 2014 LittleAuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface chatCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextView *questionTextView;

@property (weak, nonatomic) IBOutlet UILabel *nameTextField;

@property (weak, nonatomic) IBOutlet UILabel *dateTextField;

@property (weak, nonatomic) IBOutlet UIButton *trashButton;



@end
