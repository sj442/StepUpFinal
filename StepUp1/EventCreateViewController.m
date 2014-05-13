//
//  EventCreateViewController.m
//  StepUp
//
//  Created by Sunayna Jain on 2/8/14.
//
//

#import "EventCreateViewController.h"
#import "Event.h"
#import "EventManager.h"
#import "CommonClass.h"

@interface EventCreateViewController ()

@property (strong, nonatomic) UIDatePicker *datePicker;

@property (strong, nonatomic) UIDatePicker *timePicker;

@property (strong, nonatomic) UIButton *dateButton;

@property (strong, nonatomic) UIButton *timeButton;

@property (strong, nonatomic) NSString *dateChosenString;

@property (strong, nonatomic) NSString *timeChosenString;

@property (strong, nonatomic) NSDate *dateChosen;

@property (strong, nonatomic) NSDate *timeChosen;

@property (strong, nonatomic) NSDate *eventDate;

@property CGRect hiddenFrame;
@property CGRect visibleFrame;

@property BOOL datePickerOpen;

@property BOOL timePickerOpen;

@property (strong, nonatomic) UITextView *eventNameTextView;

@property (strong, nonatomic) UITextView *eventDetailsTextView;

@property (strong, nonatomic) UITextView *addressTextView;

@property (strong, nonatomic) UILabel *namePlaceHolderLabel;

@property (strong, nonatomic) UILabel *descriptionPlaceHolderLabel;

@property (strong, nonatomic) UILabel *addressPlaceHolderLabel;

@property (strong, nonatomic) NSString *eventName;

@property (strong, nonatomic) NSString *eventDetails;

@property (strong, nonatomic) NSString *address;

@end

@implementation EventCreateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    self.hiddenFrame = CGRectMake(10, 568, 300, 80);
    
    self.visibleFrame = CGRectMake(10, 150, 300, 80);
    
    self.view.backgroundColor = [[CommonClass sharedCommonClass] lightOrangeColor];
    
    [super viewDidLoad];
    
    [self addingHeaderView];
    
    //[self addingEventDetailsTextView];
    
    //[self addingEventNameTextView];
    
   // [self addingTimeButton];
    
    //[self addingAddressTextView];
    
    //[self addingDateButton];
    
    //[self addingIcons];
    
    //[self addingDatePicker];
    
   // [self addingTimePicker];
    
    //[self addingSaveButton];
    
   // [self addingCancelButton];
    
    [self addingDateAndNameContainer];
    
    [self eventContainer];
    
    }


-(void)addingDateAndNameContainer{
    
    UIView *dateContainer = [[UIView alloc]initWithFrame:CGRectMake(0, 120, 320, 60)];
    
    dateContainer.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:dateContainer];
    
    self.dateButton = [[UIButton alloc]initWithFrame:CGRectMake(5,10, 60, 40)];
    
    [self.dateButton setTitle:@"Date" forState:UIControlStateNormal];
    
    UIColor *greyColor = [[CommonClass sharedCommonClass] textGreyColor];
    
    [self.dateButton setTitleColor:greyColor forState:UIControlStateNormal];
    
    self.dateButton.titleLabel.font = [UIFont fontWithName:@"Futura" size:17];
    
    [self.dateButton addTarget:self action:@selector(dateButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [dateContainer addSubview:self.dateButton];
    
    self.eventNameTextView = [[UITextView alloc]initWithFrame:CGRectMake(80, 10, 250, 40)];
    
    self.eventNameTextView.delegate =self;
    
    self.eventNameTextView.font = [UIFont fontWithName:@"Futura" size:17];
    
    self.namePlaceHolderLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 0, 120, 40)];
    
    self.namePlaceHolderLabel.text = @"Event Title";
    
    self.namePlaceHolderLabel.textColor = [[CommonClass sharedCommonClass] textGreyColor];
    
    self.namePlaceHolderLabel.font = [UIFont fontWithName:@"Futura" size:17];
    
    [self.eventNameTextView addSubview:self.namePlaceHolderLabel];
    
    [dateContainer addSubview:self.eventNameTextView];
}

-(void)eventContainer{
    
    UIView *eventContainer = [[UIView alloc]initWithFrame:CGRectMake(0, 180, 320, self.view.frame.size.height-180)];
    
    eventContainer.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    
    UIImageView *clockIcon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 80, 24, 24)];
    clockIcon.image = [UIImage imageNamed:@"clockGrey.png"];
    
    UIImageView *venueIcon = [[UIImageView alloc]initWithFrame:CGRectMake(14, 110, 18, 24)];
    
    venueIcon.image = [UIImage imageNamed:@"venueGrey"];
    
    [eventContainer addSubview:clockIcon];
    [eventContainer addSubview:venueIcon];
    
    self.timeButton = [[UIButton alloc]initWithFrame:CGRectMake(50, 70, 60, 40)];
    
    UIColor *greyColor = [[CommonClass sharedCommonClass] textGreyColor];
    
    [self.timeButton setTitle:@"Time" forState:UIControlStateNormal];
    
    [self.timeButton setTitleColor:greyColor forState:UIControlStateNormal];
    
    self.timeButton.titleLabel.font = [UIFont fontWithName:@"Futura" size:17];
    
    [self.timeButton addTarget:self action:@selector(timeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [eventContainer addSubview:self.timeButton];
    
    self.addressTextView = [[UITextView alloc]initWithFrame:CGRectMake(50, 100, 250, 80)];
    
    self.addressTextView.backgroundColor = [UIColor clearColor];
    
    self.addressTextView.delegate = self;
    
    self.addressTextView.font = [UIFont fontWithName:@"Futura" size:17];
    
    self.addressPlaceHolderLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 0, 120, 40)];
    
    self.addressPlaceHolderLabel.text = @"Address";
    
    self.addressPlaceHolderLabel.textColor = [[CommonClass sharedCommonClass] textGreyColor];
    
    self.addressPlaceHolderLabel.font = [UIFont fontWithName:@"Futura" size:17];
    
    [self.addressTextView addSubview:self.addressPlaceHolderLabel];
    
    [eventContainer addSubview:self.addressTextView];
    
    self.eventDetailsTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 10, 300, 60)];
    
    self.eventDetailsTextView.backgroundColor = [UIColor clearColor];
    
    self.eventDetailsTextView.delegate = self;
    
    self.eventDetailsTextView.font = [UIFont fontWithName:@"Futura" size:17];
    
    [eventContainer addSubview:self.eventDetailsTextView];
    
    self.descriptionPlaceHolderLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 0, 300, 40)];
    
    self.descriptionPlaceHolderLabel.text = @"Description";
    
    self.descriptionPlaceHolderLabel.font = [UIFont fontWithName:@"Futura" size:17];

    self.descriptionPlaceHolderLabel.textColor = [[CommonClass sharedCommonClass] textGreyColor];
    
    [self.eventDetailsTextView addSubview:self.descriptionPlaceHolderLabel];
    
    [self.view addSubview:eventContainer];
    
    UIButton *saveButton = [[UIButton alloc]initWithFrame:CGRectMake(240, 300, 70, 40)];
    
    [saveButton setTitle:@"Save" forState:UIControlStateNormal];
    
    UIColor *orangeColor = [[CommonClass sharedCommonClass] lightOrangeColor];
    
    [saveButton setTitleColor:orangeColor forState:UIControlStateNormal];
    
    saveButton.layer.borderColor = [[CommonClass sharedCommonClass] lightOrangeColor].CGColor;
    
    saveButton.layer.borderWidth = 3.0f;
    
    saveButton.titleLabel.font = [UIFont fontWithName:@"Futura" size:17];
    
    [saveButton addTarget:self action:@selector(saveButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [eventContainer addSubview:saveButton];
    
    UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 300, 70, 40)];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    
    [cancelButton setTitleColor:orangeColor forState:UIControlStateNormal];
    
    cancelButton.layer.borderWidth = 3.0f;
    
    cancelButton.layer.borderColor = [[CommonClass sharedCommonClass] lightOrangeColor].CGColor;
    
    cancelButton.titleLabel.font = [UIFont fontWithName:@"Futura" size:17];
    
    [cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [eventContainer addSubview:cancelButton];
    
    self.timePicker = [[UIDatePicker alloc]initWithFrame:self.hiddenFrame];
    
    self.timePicker.datePickerMode = UIDatePickerModeTime;
    
    self.timePicker.userInteractionEnabled = YES;
    
    self.timeChosen = self.timePicker.date;
    
   // NSTimeInterval timeInterval = [self.timeChosen timeIntervalSince1970];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"hh:mm"];
    
    self.timeChosenString = [formatter stringFromDate:self.timeChosen];
    
    [self.timePicker addTarget:self action:@selector(changeTimeTitle:) forControlEvents:UIControlEventValueChanged];
    
    [eventContainer  addSubview:self.timePicker];
    
    self.datePicker = [[UIDatePicker alloc]initWithFrame:self.hiddenFrame];
    
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    
    self.datePicker.userInteractionEnabled = YES;
    
    self.dateChosen = self.datePicker.date;
    
   // NSTimeInterval dateInterval = [self.dateChosen timeIntervalSince1970];
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
    
    [timeFormatter setDateFormat:@"MM/dd"];
    
    self.dateChosenString = [timeFormatter stringFromDate:self.dateChosen];
    
    [self.datePicker addTarget:self action:@selector(changeDateTitle:) forControlEvents:UIControlEventValueChanged];
    
    [eventContainer addSubview:self.datePicker];

}


-(void)addingHeaderView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 120)];
    view.backgroundColor = [[CommonClass sharedCommonClass] lightOrangeColor];
    [self.view addSubview:view];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = [[CommonClass sharedCommonClass] darkOrangeColor];
    button.titleLabel.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:24];
    [button setTitle:@"upcoming" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    button.frame = CGRectMake(20, 20, 200, 60);
    [view addSubview:button];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(80, 80, 200, 40)];
    label.textColor = [UIColor whiteColor];
    label.text = @"events";
    label.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:24];
    //label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    [view addSubview:label];
}

-(void)addingSaveButton{
    
    UIButton *saveButton = [[UIButton alloc]initWithFrame:CGRectMake(240, 520, 70, 40)];
    
    [saveButton setTitle:@"Save" forState:UIControlStateNormal];
    
    [saveButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    saveButton.layer.borderColor = [UIColor blueColor].CGColor;
    
    saveButton.layer.borderWidth = 3.0f;
    
    saveButton.titleLabel.font = [UIFont fontWithName:@"Futura" size:17];
    
    [saveButton addTarget:self action:@selector(saveButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:saveButton];
}

-(void)addingCancelButton{
    
    UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 520, 70, 40)];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    
    [cancelButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    cancelButton.layer.borderWidth = 3.0f;
    
    cancelButton.layer.borderColor = [UIColor blueColor].CGColor;
    
    cancelButton.titleLabel.font = [UIFont fontWithName:@"Futura" size:17];
    
    [cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:cancelButton];
}

//-(void)addingDatePicker{
//    
//    self.datePicker = [[UIDatePicker alloc]initWithFrame:self.hiddenFrame];
//    
//    self.datePicker.datePickerMode = UIDatePickerModeDate;
//    
//    self.datePicker.userInteractionEnabled = YES;
//    
//    self.dateChosen = self.datePicker.date;
//    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    
//    [formatter setDateFormat:@"MM/dd"];
//    
//    self.dateChosenString = [formatter stringFromDate:self.dateChosen];
//    
//    [self.datePicker addTarget:self action:@selector(changeDateTitle:) forControlEvents:UIControlEventValueChanged];
//    
//    [self.view addSubview:self.datePicker];
//
//}

//-(void)addingTimePicker{
//    
//    self.timePicker = [[UIDatePicker alloc]initWithFrame:self.hiddenFrame];
//    
//    self.timePicker.datePickerMode = UIDatePickerModeTime;
//    
//    self.timePicker.userInteractionEnabled = YES;
//    
//    self.timeChosen = self.timePicker.date;
//    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    
//    [formatter setDateFormat:@"hh:mm"];
//    
//    self.timeChosenString = [formatter stringFromDate:self.timeChosen];
//    
//    [self.timePicker addTarget:self action:@selector(changeTimeTitle:) forControlEvents:UIControlEventValueChanged];
//    
//    [self.eventcon  addSubview:self.timePicker];
//}

-(void)changeDateTitle:(id)sender{
    
    self.dateChosen = self.datePicker.date;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"MM/dd"];
    
    self.dateChosenString = [formatter stringFromDate:self.dateChosen];
    
    [self.dateButton setTitle:self.dateChosenString forState:UIControlStateNormal];
}

-(void)changeTimeTitle:(id)sender{
    
    self.timeChosen = self.timePicker.date;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"hh:mm"];
    
    self.timeChosenString = [formatter stringFromDate:self.timeChosen];
    
    [self.timeButton setTitle:self.timeChosenString forState:UIControlStateNormal];
}

-(void)dateButtonPressed:(UIButton*)sender{
    
    if (!self.datePickerOpen){
        
        [self datePickerAnimation];
        
        [self.dateButton setTitle:self.dateChosenString forState:UIControlStateNormal];
    
    } else {
        
        [self dismissDatePicker];
    }
}


-(void)datePickerAnimation{
    
    self.addressTextView.userInteractionEnabled =NO;
    self.eventDetailsTextView.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:0.5f animations:^{
        self.datePicker.frame = self.visibleFrame;
    } completion:^(BOOL finished) {
        self.datePickerOpen = YES;
        NSLog(@"datePicker done going to main view");

    }];
    
}

-(void)dismissDatePicker{
    [UIView animateWithDuration:0.5f animations:^{
        self.datePicker.frame = self.hiddenFrame;
    } completion:^(BOOL finished) {
        NSLog(@"datePicker done going to hidden view");
        self.datePickerOpen = NO;
        self.addressTextView.userInteractionEnabled =YES;
        self.eventDetailsTextView.userInteractionEnabled = YES;
    }];
    
    [self.dateButton setTitle:self.dateChosenString forState:UIControlStateNormal];
    [self.dateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

-(void)timeButtonPressed:(UIButton*)sender{
    
    if (!self.timePickerOpen){
        
        [self timePickerAnimation];
        
        [self.timeButton setTitle:self.timeChosenString forState:UIControlStateNormal];
        
    } else {
        
        [self dismissTimePicker];
    }
}

-(void)timePickerAnimation{
    
    self.addressTextView.userInteractionEnabled = NO;
    self.eventDetailsTextView.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:0.5f animations:^{
        self.timePicker.frame = self.visibleFrame;
    } completion:^(BOOL finished) {
        self.timePickerOpen = YES;
        NSLog(@"datePicker done going to main view");
    }];
    
}

-(void)dismissTimePicker{
    [UIView animateWithDuration:0.5f animations:^{
        self.timePicker.frame = self.hiddenFrame;
    } completion:^(BOOL finished) {
        NSLog(@"datePicker done going to hidden view");
        self.timePickerOpen = NO;
        self.addressTextView.userInteractionEnabled = YES;
        self.eventDetailsTextView.userInteractionEnabled = YES;
    }];
    
    [self.timeButton setTitle:self.timeChosenString forState:UIControlStateNormal];
    [self.timeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

-(void)newDateFromDateAndTimeChosen{
    
    NSTimeInterval timeInterval = [self.timeChosen timeIntervalSinceDate:[NSDate date]];
    
    NSTimeInterval dateInterval = [self.dateChosen timeIntervalSince1970];
    
    self.eventDate = [NSDate dateWithTimeIntervalSince1970:timeInterval+dateInterval];
    
//    NSCalendar *calendar = [[NSCalendar alloc]init];
//    
//    NSDateComponents *dateComponents = [calendar components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:self.dateChosen];
//    
//    NSDateComponents *timeComponents = [calendar components:NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:self.timeChosen];
//    
//    NSInteger year = [dateComponents year];
//    
//    NSInteger month = [dateComponents month];
//    
//    NSInteger day = [dateComponents day];
//    
//    NSInteger hour = [timeComponents hour];
//    
//    NSInteger minute = [timeComponents minute];
//    
//    NSInteger seconds = [timeComponents second];
//    
//    NSDateComponents *eventComponents = [[NSDateComponents alloc]init];
//    
//    [eventComponents setYear:year];
//    
//    [eventComponents setMonth:month];
//    
//    [eventComponents setDay:day];
//    
//    [eventComponents setHour:hour];
//    
//    [eventComponents setMinute:minute];
//    
//    [eventComponents setSecond:seconds];
//        
//    self.eventDate = [calendar dateFromComponents:eventComponents];
    
    NSLog(@"event date %@", self.eventDate);
}

-(void)saveButtonPressed:(id)sender{
    NSLog(@"ButtonPressed to save a new event");
    
    [self newDateFromDateAndTimeChosen];
    //NSString* time_str = [self.eventDate descriptionWithCalendarFormat:@"%Y-%m-%d %H:%M:%S %z" timeZone:[NSTimeZone timeZoneWithAbbreviation:@"EST"] locale:nil];
    //NSString* time_str = [self.eventDate description];
    
//    Event *newEvent = [[Event alloc]initWithEventId:@"" andType:EVENT_NETWORKING andStatus:EVENT_SCHEDULED andTitle:self.eventName andDescription:self.eventDetails andTime:time_str andDuration:[[NSNumber alloc] initWithInt:1] andUrl:@"" andLocation:self.address andUserResponse:@{}];
//    
//    NSLog(@"New Event Created with title as %@", [newEvent title]);
//    
//      [[EventManager sharedInstance] addNewEvent:newEvent withcompletionHandler:^(NSError *error) {
//          NSLog(@"Button Pressed to save a new event: trying to dismiss now");
//          
//          [self dismissViewControllerAnimated:NO completion:nil];
//      }];
}

-(void)cancelButtonPressed:(id)sender{
    
    [self dismissViewControllerAnimated:NO completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-UITextviewDelegate methods

-(void)checkForPlaceholderLabelInEventNameTextview{
    if (self.eventNameTextView.text.length ==0){
        [self.eventNameTextView addSubview:self.namePlaceHolderLabel];
    } else if (self.eventNameTextView.text.length>0) {
        [self.namePlaceHolderLabel removeFromSuperview];
    }
}

-(void)checkForPlaceholderLabelInEventDetailsTextview{
    if (self.eventDetailsTextView.text.length ==0){
        [self.eventDetailsTextView addSubview:self.descriptionPlaceHolderLabel];
    } else if (self.eventDetailsTextView.text.length>0) {
        [self.descriptionPlaceHolderLabel removeFromSuperview];
    }
}

-(void)checkForPlaceholderLabelInAddressTextview{
    if (self.addressTextView.text.length ==0){
        [self.addressTextView addSubview:self.addressPlaceHolderLabel];
    } else if (self.addressTextView.text.length>0) {
        [self.addressPlaceHolderLabel removeFromSuperview];
    }
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]) {
        if (textView == self.eventNameTextView){
            [textView resignFirstResponder];
            self.eventName = textView.text;
            [self.eventDetailsTextView becomeFirstResponder];
            [self checkForPlaceholderLabelInEventNameTextview];
            return NO;
        } else if (textView==self.eventDetailsTextView){
            [textView resignFirstResponder];
            self.eventDetails = textView.text;
            [self checkForPlaceholderLabelInEventDetailsTextview];
        }
        else if (textView ==self.addressTextView){
            [textView resignFirstResponder];
            [self checkForPlaceholderLabelInAddressTextview];
            self.address = textView.text;
        }
    }
    return YES;
}


-(void)textViewDidChange:(UITextView *)textView{
    
    if (textView==self.eventNameTextView){
        [self checkForPlaceholderLabelInEventNameTextview];
    } else if (textView == self.eventDetailsTextView){
        [self checkForPlaceholderLabelInEventDetailsTextview];
    } else if (textView==self.addressTextView){
        [self checkForPlaceholderLabelInAddressTextview];
    }
}


@end
