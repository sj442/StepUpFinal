//
//  chatDetailViewController.h
//  StepUp1
//
//  Created by Sunayna Jain on 5/6/14.
//  Copyright (c) 2014 LittleAuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "GrowingTextView.h"


@interface chatDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UITextViewDelegate>

@property (strong, nonatomic) Post *post;

@end
