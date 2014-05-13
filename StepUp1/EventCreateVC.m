//
//  EventCreateVC.m
//  StepUp1
//
//  Created by Sunayna Jain on 3/25/14.
//  Copyright (c) 2014 LittleAuk. All rights reserved.
//

#import "EventCreateVC.h"
#import "CommonClass.h"
#import "Event.h"
#import "EventManager.h"
#import "CalendarListViewController.h"

@interface EventCreateVC ()

@property (nonatomic, strong) UITextView *eventTitleTV;
@property (nonatomic, strong) UITextView *descTV;
@property (nonatomic, strong) UITextView *addressTV;
@property (strong, nonatomic) UIImageView *timeImageView;
@property (strong, nonatomic) UIImageView *venueImageView;

//textview placeholders

@property (nonatomic, strong) UILabel *eventTitleLabel;
@property (strong, nonatomic) UILabel *descLabel;
@property (nonatomic, strong) UILabel *addressLabel;

@property (strong, nonatomic) UIDatePicker *datePicker;

@property (strong, nonatomic) UIDatePicker *timePicker;

@property (strong, nonatomic) UIButton *dateButton;

@property (strong, nonatomic) UIButton *timeButton;

@property (strong, nonatomic) NSString *dateChosenString;

@property (strong, nonatomic) NSString *timeChosenString;

@property CGRect hiddenFrame;
@property CGRect visibleFrame;

@property BOOL datePickerOpen;
@property BOOL timePickerOpen;

@end

@implementation EventCreateVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.tableView.backgroundColor = [[CommonClass sharedCommonClass] lightOrangeColor];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.hiddenFrame = CGRectMake(10, 568, 300, 80);
    
    self.visibleFrame = CGRectMake(10, 355, 300, 80);
    
    [self addDatePicker];
    
    [self addTimePicker];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addDatePicker
{
    self.datePicker = [[UIDatePicker alloc]initWithFrame:self.hiddenFrame];
    
    self.datePicker.hidden = YES;
    
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    
    self.datePicker.userInteractionEnabled = YES;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"MM/dd"];
    
    self.dateChosenString = [formatter stringFromDate:self.datePicker.date];
    
    [self.datePicker addTarget:self action:@selector(changeDateTitle:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:self.datePicker];
}

-(void)addTimePicker
{
    self.timePicker = [[UIDatePicker alloc]initWithFrame:self.hiddenFrame];
    
    self.timePicker.hidden = YES;
    
    self.timePicker.datePickerMode = UIDatePickerModeTime;
    
    self.timePicker.userInteractionEnabled = YES;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"hh:mm a"];
    
    self.timeChosenString = [formatter stringFromDate:self.timePicker.date];
    
    [self.timePicker addTarget:self action:@selector(changeTimeTitle:) forControlEvents:UIControlEventValueChanged];
    
    [self.view  addSubview:self.timePicker];
}

#pragma mark-UITableView DataSource methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 150;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
    return 66;
        
    } else if (indexPath.row==1)
    {
        return 50;
    }
    else if (indexPath.row==2)

    {
        return 100;
    }
    else if (indexPath.row==3)
    {
        return self.tableView.frame.size.height-150-70 - 66 -100-50;
    }
    else
    {
        return 70;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 100)];
//    view.backgroundColor = [[CommonClass sharedCommonClass]lightOrangeColor];
//    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    button.backgroundColor = [[CommonClass sharedCommonClass] darkOrangeColor];
//    button.titleLabel.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:24];
//    [button setTitle:@"upcoming" forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
//    button.frame = CGRectMake(20, 20, 200, 60);
//    [view addSubview:button];
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(80, 80, 200, 40)];
//    label.textColor = [UIColor whiteColor];
//    label.text = @"events";
//    label.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:24];
//    [view addSubview:label];
    
//    return view;
    
     UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,150)];
    
    headerView.backgroundColor = [[CommonClass sharedCommonClass] lightOrangeColor];
    
    UIButton *eventsButton = [[UIButton alloc]initWithFrame:CGRectMake(51, 30, 180, 63)];
    
    [eventsButton setBackgroundColor:[[CommonClass sharedCommonClass] darkOrangeColor]];
    
    [eventsButton setTitle:@"upcoming" forState:UIControlStateNormal];
    
    [eventsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    eventsButton.titleLabel.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:32];
    
    eventsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    eventsButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    [headerView addSubview:eventsButton];
    
    UILabel *eventsLabel = [[UILabel alloc]initWithFrame:CGRectMake(61, 92, 180, 63)];
    
    eventsLabel.text = @"events";
    
    eventsLabel.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:32];
    
    eventsLabel.textColor = [UIColor whiteColor];
    
    [headerView addSubview:eventsLabel];
    
    return headerView;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (indexPath.row==0)
    {
        //adding date button
        
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            
            self.dateButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 60, 66)];
            
            [self.dateButton addTarget:self action:@selector(dateButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            if (self.date.length!=0)
            {
                [self.dateButton setTitle:self.date forState:UIControlStateNormal];
                
                [self.dateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            else
            {
                
                [self.dateButton setTitle:@"Date" forState:UIControlStateNormal];
                
                UIColor *greyColor = [[CommonClass sharedCommonClass] textGreyColor];
                
                [self.dateButton setTitleColor:greyColor forState:UIControlStateNormal];
                
            }
            self.dateButton.titleLabel.font = [UIFont fontWithName:@"Futura" size:17];
            
            [cell addSubview:self.dateButton];
            
            //adding event title textview
            
            self.eventTitleTV = [[UITextView alloc]initWithFrame:CGRectMake(80, 10, 240, 46)];
            
            self.eventTitleTV.delegate =self;
            
            self.eventTitleTV.font = [UIFont fontWithName:@"Futura" size:17];
            
            self.eventTitleTV.textColor = [UIColor blackColor];
            
            if (self.title)
            {
                self.eventTitleTV.text = self.title;
            }
            else
            {
                [self addingTitlePlaceholderToTextView:self.eventTitleTV];
            }
            [cell addSubview:self.eventTitleTV];
        }
    }
    else if (indexPath.row==3)
    {
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            
            self.descTV = [[UITextView alloc]initWithFrame:CGRectMake(10, 0, self.view.frame.size.width, 100)];
            
            if (self.description.length!=0)
                
            {
                self.descTV.text = self.description;
            }
            else
            {
                [self addingDescriptionPlaceholderToTextview:self.descTV];
            }
            self.descTV.textColor = [UIColor blackColor];
            
            self.descTV.font = [UIFont fontWithName:@"Futura" size:17];;
            
            self.descTV.delegate = self;
            
            [cell addSubview:self.descTV];
        }
    }
    else if (indexPath.row==1)
    {
        //time button
        
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            
            self.timeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
            
            self.timeImageView.image = [UIImage imageNamed:@"clockGrey.png"];
            
            [cell addSubview:self.timeImageView];
            
            self.timeButton = [[UIButton alloc]initWithFrame:CGRectMake(40, 10, 90, 30)];
            
            if (self.time.length!=0)
                
            {
                [self.timeButton setTitle:self.time forState:UIControlStateNormal];
                
                [self.timeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
                self.timeImageView.image = [UIImage imageNamed:@"clockBlack.png"];
            }
            else
            {
                
                [self.timeButton setTitle:@"Time" forState:UIControlStateNormal];
                
                UIColor *greyColor = [[CommonClass sharedCommonClass] textGreyColor];
                
                [self.timeButton setTitleColor:greyColor forState:UIControlStateNormal];
            }
            
            [self.timeButton addTarget:self action:@selector(timeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            self.timeButton.titleLabel.font = [UIFont fontWithName:@"Futura" size:17];
            
            [cell addSubview:self.timeButton];
        }
    }
    else if (indexPath.row==2)
    {
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            
            self.venueImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 20, 32)];
            
            self.venueImageView.image = [UIImage imageNamed:@"venueGrey.png"];
            
            [cell addSubview:self.venueImageView];
            
            //Address Textview
            
            self.addressTV = [[UITextView alloc]initWithFrame:CGRectMake(50, 10, 200, 50)];
            
            self.addressTV.font = [UIFont fontWithName:@"Futura" size:17];
            
            if (self.address.length !=0)
                
            {
                self.addressTV.text = self.address;
                
                self.venueImageView.image = [UIImage imageNamed:@"venueBlack.png"];
            }
            else
            {
            [self addingAddressPlaceholderToTextview:self.addressTV];
            }
            
            self.addressTV.textColor = [UIColor blackColor];
            
            self.addressTV.delegate = self;
            
            [cell addSubview:self.addressTV];
        }
    }
    else
    {
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            
            UIButton *saveButton = [[UIButton alloc]initWithFrame:CGRectMake(240, 10, 70, 50 )];
            
            [saveButton setTitle:@"Save" forState:UIControlStateNormal];
            
            saveButton.layer.borderColor = [[CommonClass sharedCommonClass] lightOrangeColor].CGColor;
            
            saveButton.layer.borderWidth = 3.0f;
            
            saveButton.backgroundColor = [UIColor clearColor];
            
            saveButton.titleLabel.font = [UIFont fontWithName:@"Futura" size:17];
            
            [saveButton setTitleColor:[[CommonClass sharedCommonClass] lightOrangeColor] forState:UIControlStateNormal];
                        
            [saveButton addTarget:self action:@selector(saveButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.contentView addSubview:saveButton];
            
            UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 90, 50 )];
            
            [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
            
            [cancelButton setTitleColor:[[CommonClass sharedCommonClass] lightOrangeColor] forState:UIControlStateNormal];
            
            cancelButton.layer.borderColor = [[CommonClass sharedCommonClass] lightOrangeColor].CGColor;
            
            cancelButton.layer.borderWidth = 3.0f;
            
            cancelButton.backgroundColor = [UIColor clearColor];
            
            cancelButton.titleLabel.font = [UIFont fontWithName:@"Futura" size:17];
            
            [cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.contentView addSubview:cancelButton];
         }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(void)saveButtonPressed:(id)Sender
{
    if (self.eventTitleTV.text.length!=0)
    {
        NSDate *date = self.datePicker.date;
        
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:date];
        
        NSInteger year = [components year];
        NSInteger month = [components month];
        NSInteger day = [components day];
        
        NSDate *time = self.timePicker.date;
        
        NSDateComponents *timeComponents = [[NSCalendar currentCalendar] components:NSHourCalendarUnit| NSMinuteCalendarUnit fromDate:time];
        
        NSInteger hour = [timeComponents hour];
        NSInteger minute = [timeComponents minute];
        
        NSDate *eventDate = [self createDateFromComponentsYear:year andMonth:month andDay:day andHour:hour andMinute:minute];
        
        NSNumber *eventTimeStamp = [NSNumber numberWithDouble:[eventDate timeIntervalSinceReferenceDate]];
        
        Event *newEvent = [[Event alloc]initWithEventId:@"" andType:EVENT_NETWORKING andStatus:EVENT_SCHEDULED andTitle:self.eventTitleTV.text andDescription:self.descTV.text andTime:self.timeChosenString andDate:self.dateChosenString andEventTimeStamp:eventTimeStamp andDuration:[[NSNumber alloc] initWithInt:1] andUrl:@"" andLocation:self.addressTV.text andUserResponse:@{}];
        
        EventManager *em = [EventManager sharedInstance];
        
        if (self.editMode==YES)
            
        {
            Event* this_event = [[[[EventManager sharedInstance] populatedEvents] allValues] objectAtIndex:[self.eventIndex integerValue]];
            
            [em modifyEvent:this_event andNewEvent:newEvent withCompletionHandler:^(NSError *error) {
                if (error)
                {
                    NSLog(@"error saving new event!");
                }
                else
                {
                    NSLog(@"event modified with title %@, desc %@, time %@, date %@, timestamp %@, location %@", newEvent.title, newEvent.description, newEvent.time, newEvent.date, newEvent.eventTimeStamp, newEvent.location);
                    
                    [self dismissViewControllerAnimated:NO completion:nil];
                }
            }];
        }
        else
        {
        
        [em addNewEvent:newEvent withcompletionHandler:^(NSError *error) {
            
            if (error)
            {
                NSLog(@"error saving new event!");
            }
            else
            {
                NSLog(@"new event title %@, desc %@, time %@, date %@, timestamp %@, location %@", newEvent.title, newEvent.description, newEvent.time, newEvent.date, newEvent.eventTimeStamp, newEvent.location);
                
                [self dismissViewControllerAnimated:NO completion:nil];
            }
        }];
            
        }
    }
    else
    {
        UIAlertView *alertivew = [[UIAlertView alloc]initWithTitle:@"Cannot save event" message:@"Event must have a title" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alertivew show];
    }
}

-(void)cancelButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)changeDateTitle:(id)sender
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"MM/dd"];
    
    self.dateChosenString = [formatter stringFromDate:self.datePicker.date];
    
    [self.dateButton setTitle:self.dateChosenString forState:UIControlStateNormal];
}

-(void)changeTimeTitle:(id)sender
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"hh:mm a"];
    
    self.timeChosenString = [formatter stringFromDate:self.timePicker.date];
    
    [self.timeButton setTitle:self.timeChosenString forState:UIControlStateNormal];
}

-(void)dateButtonPressed:(UIButton*)sender
{
    [self.view endEditing:YES];
    
    self.descTV.hidden = YES;
    
    if (!self.datePickerOpen)
    {
        [self datePickerAnimation];
        
        [self.dateButton setTitle:self.dateChosenString forState:UIControlStateNormal];
    }
    else
    {
        [self dismissDatePicker];
    }
}

-(void)datePickerAnimation
{
    [UIView animateWithDuration:0.5f animations:^{
        self.datePicker.frame = self.visibleFrame;
        self.datePicker.hidden = NO;
    } completion:^(BOOL finished) {
        self.datePickerOpen = YES;
        NSLog(@"datePicker done going to main view");
    }];
}

-(void)dismissDatePicker
{
    [UIView animateWithDuration:0.5f animations:^{
        self.datePicker.frame = self.hiddenFrame;
        self.datePicker.hidden = YES;
    } completion:^(BOOL finished)
    {
        NSLog(@"datePicker done going to hidden view");
        self.datePickerOpen = NO;
        
        self.descTV.hidden = NO;

    }];
    [self.dateButton setTitle:self.dateChosenString forState:UIControlStateNormal];
    [self.dateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

-(void)timeButtonPressed:(UIButton*)sender
{
    [self.view endEditing:YES];
    
    
    self.descTV.hidden = YES;

    
    if (!self.timePickerOpen)
    {
        [self timePickerAnimation];
        
        [self.timeButton setTitle:self.timeChosenString forState:UIControlStateNormal];
    } else
    {
        [self dismissTimePicker];
    }
}

-(void)timePickerAnimation
{
    [UIView animateWithDuration:0.5f animations:^{
        self.timePicker.frame = self.visibleFrame;
        self.timePicker.hidden = NO;
    } completion:^(BOOL finished) {
        self.timePickerOpen = YES;
        NSLog(@"datePicker done going to main view");
    }];
}

-(void)dismissTimePicker
{
    [UIView animateWithDuration:0.5f animations:^{
        self.timePicker.frame = self.hiddenFrame;
        self.timePicker.hidden = YES;
    } completion:^(BOOL finished){
        NSLog(@"datePicker done going to hidden view");
        self.timePickerOpen = NO;
        
        self.descTV.hidden = NO;
        
        [self.timeImageView setImage:[UIImage imageNamed:@"clockBlack.png"]];
        
        [self.timeButton setTitle:self.timeChosenString forState:UIControlStateNormal];
        [self.timeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }];
    
}

-(void)addingTitlePlaceholderToTextView:(UITextView*)textview
{
    self.eventTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 240, 46)];
    
    self.eventTitleLabel.text = @"Event Title";
    
    UIColor *greyColor = [[CommonClass sharedCommonClass] textGreyColor];
    
    self.eventTitleLabel.textColor = greyColor;
    
    self.eventTitleLabel.font = [UIFont fontWithName:@"Futura" size:17];
    
    [textview addSubview:self.eventTitleLabel];
}

-(void)addingDescriptionPlaceholderToTextview:(UITextView*)textview
{
    self.descLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 25, 100, 50 )];
    
    self.descLabel.text = @"Description";
    
    UIColor *greyColor = [[CommonClass sharedCommonClass] textGreyColor];
    
    self.descLabel.textColor = greyColor;
    
    self.descLabel.font = [UIFont fontWithName:@"Futura" size:17];
    
    [textview addSubview:self.descLabel];
}

-(void)addingAddressPlaceholderToTextview:(UITextView*)textview
{
    self.addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 30 )];
    
    self.addressLabel.text = @"Address";
    
    UIColor *greyColor = [[CommonClass sharedCommonClass] textGreyColor];
    
    self.addressLabel.textColor = greyColor;
    
    self.addressLabel.font = [UIFont fontWithName:@"Futura" size:17];
    
    [textview addSubview:self.addressLabel];
}

#pragma mark- UITextView Delegate methods

-(void)checkForPlaceholderLabel:(UILabel*)label inTextView:(UITextView*)textview
{
    if (textview.text.length ==0)
    {
        [textview addSubview:label];
        
        if (textview==self.addressTV)
        {
            self.venueImageView.image = [UIImage imageNamed:@"venueGrey.png"];
        }
        
    } else if (textview.text.length>0)
    {
        [label removeFromSuperview];
        
        if (textview==self.addressTV)
        {
            self.venueImageView.image = [UIImage imageNamed:@"venueBlack.png"];
        }
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"])
    {
        if (textView == self.eventTitleTV)
        {
            [textView resignFirstResponder];
            
            [self.descTV becomeFirstResponder];
            
            [self checkForPlaceholderLabel:self.eventTitleLabel  inTextView:self.eventTitleTV];
            
            return NO;
            
        } else if (textView==self.descTV)
        {
            [textView resignFirstResponder];
            
            [self checkForPlaceholderLabel:self.descLabel inTextView:self.descTV];
            return NO;
        }
        else if (textView ==self.addressTV)
        {
            [textView resignFirstResponder];
            [self checkForPlaceholderLabel:self.addressLabel inTextView:self.addressTV];
            
            return NO;
        }
    }
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (textView==self.eventTitleTV)
    {
        [self checkForPlaceholderLabel:self.eventTitleLabel inTextView:self.eventTitleTV];
    }
    else if (textView==self.descTV)
    {
        [self checkForPlaceholderLabel:self.descLabel inTextView:self.descTV];
    }
    else if (textView==self.addressTV)
    {
        [self checkForPlaceholderLabel:self.addressLabel inTextView:self.addressTV];
    }
}

-(NSDate*)createDateFromComponentsYear:(NSInteger)year andMonth:(NSInteger)month andDay:(NSInteger)day andHour:(NSInteger)hour andMinute:(NSInteger)minute
{
    NSDate *date;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc]init];
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    [components setHour:hour];
    [components setMinute:minute];
    date = [calendar dateFromComponents:components];
    
    return date;
}

@end
