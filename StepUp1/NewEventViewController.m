//
//  NewEventViewController.m
//  StepUp
//
//  Created by Sunayna Jain on 2/8/14.

#import "NewEventViewController.h"
#import "CalendarCell.h"
#import "EventDetailsCell.h"
#import "CalendarListViewController.h"
#import "CommonClass.h"
#import "EventManager.h"
#import "EventCreateVC.h"

@interface NewEventViewController ()
{
    UIView *headerView;
}

@property (strong, nonatomic) UIButton *yesButton;
@property (strong, nonatomic) UIButton *maybeButton;
@property (strong, nonatomic) UIButton *noButton;

@end

@implementation NewEventViewController

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
    [super viewDidLoad];
    
    headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,150)];
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
    
    [self.view addSubview:headerView];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, headerView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-headerView.frame.size.height) style:UITableViewStylePlain];
    
    UINib *nib = [UINib nibWithNibName:@"CalendarCell" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"CalendarCell"];
    
    self.tableView.backgroundColor = [[CommonClass sharedCommonClass] lightOrangeColor];
    
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    [self addingRSVPLabel];
    
    [self addingYesButton];
    
    [self addingMaybeButton];
    
    [self addingNoButton];
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.tableView reloadData];
}

-(void)addingRSVPLabel
{
    UILabel *rsvpLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, self.view.frame.size.height-50, 60, 40)];
    rsvpLabel.text = @"RSVP";
    rsvpLabel.font = [UIFont fontWithName:@"Futura" size:17];
    [self.view addSubview:rsvpLabel];
}

-(void)addingYesButton
{
    UIColor *orange = [[CommonClass sharedCommonClass] darkOrangeColor];

    self.yesButton = [[UIButton alloc]initWithFrame:CGRectMake(90, self.view.frame.size.height-50, 50, 40)];
    self.yesButton.layer.borderColor = [[CommonClass sharedCommonClass] darkOrangeColor].CGColor;
    self.yesButton.layer.borderWidth = 3.0f;
    self.yesButton.titleLabel.font = [UIFont fontWithName:@"Futura" size:17];
    [self.yesButton setTitle:@"yes" forState:UIControlStateNormal];
    [self.yesButton setTitleColor:orange forState:UIControlStateNormal];
    [self.yesButton addTarget:self action:@selector(yesButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.yesButton];
}

-(void)addingMaybeButton
{
    UIColor *orange = [[CommonClass sharedCommonClass] darkOrangeColor];

    self.maybeButton = [[UIButton alloc]initWithFrame:CGRectMake(160, self.view.frame.size.height-50, 60, 40)];
    self.maybeButton.layer.borderColor = [[CommonClass sharedCommonClass] darkOrangeColor].CGColor;
    self.maybeButton.layer.borderWidth = 3.0f;
    self.maybeButton.titleLabel.font = [UIFont fontWithName:@"Futura" size:17];
    [self.maybeButton setTitle:@"maybe" forState:UIControlStateNormal];
    [self.maybeButton setTitleColor:orange forState:UIControlStateNormal];
    [self.maybeButton addTarget:self action:@selector(maybeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.maybeButton];
}

-(void)addingNoButton
{
    UIColor *orange = [[CommonClass sharedCommonClass] darkOrangeColor];

    self.noButton = [[UIButton alloc]initWithFrame:CGRectMake(240, self.view.frame.size.height-50, 50, 40)];
    self.noButton.layer.borderColor = [[CommonClass sharedCommonClass] darkOrangeColor].CGColor;
    self.noButton.layer.borderWidth = 3.0f;
    self.noButton.titleLabel.font = [UIFont fontWithName:@"Futura" size:17];
    [self.noButton setTitle:@"no" forState:UIControlStateNormal];
    [self.noButton setTitleColor:orange forState:UIControlStateNormal];
    [self.noButton addTarget:self action:@selector(noButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.noButton];
}

#pragma mark-TableView DataSource methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0){
        return 66;
    } else {
        return self.view.frame.size.height-66-150-60;
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 120;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 100)];
//    view.backgroundColor = [[CommonClass sharedCommonClass] lightOrangeColor];
//    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    button.backgroundColor = [[CommonClass sharedCommonClass] darkOrangeColor];
//    //button.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
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
//    //label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
//    [view addSubview:label];
//    
//    return view;
//}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger index = [self.eventIndex integerValue];
    Event* this_event = [[[[EventManager sharedInstance] populatedEvents] allValues] objectAtIndex:index];
   // NSString* time_str = [this_event time];

    if (indexPath.row==0){
       CalendarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CalendarCell"];
        
            if (!cell) {
                cell = [[[UINib nibWithNibName:@"CalendarCell" bundle:[NSBundle mainBundle]] instantiateWithOwner:self options:nil] objectAtIndex:0];
            }
        
//        NSRange my_range;
//        my_range.location = 5;
//        my_range.length = 5 ;
//        NSString* short_str = @"";
//        
//        if ([time_str length] > 10) {
//            short_str = [time_str substringWithRange:my_range];
//        }
        
        ((CalendarCell*)cell).headerLabel.text = ([this_event title] != nil) ? [this_event title] : @"Untitled";
        ((CalendarCell*)cell).dateLabel.text = this_event.date;
        ((CalendarCell*)cell).headerLabel.font = [UIFont fontWithName:@"Futura" size:18];
        ((CalendarCell*)cell).dateLabel.font = [UIFont fontWithName:@"Futura" size:18];
        
        return cell;
        }
    
    else {
    
    static NSString *cellIdentifier = @"EventDetails";
    
    EventDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
        if(!cell){
        cell = [[[UINib nibWithNibName:@"EventDetailsCell" bundle:[NSBundle mainBundle]] instantiateWithOwner:self options:nil] objectAtIndex:0];
        }
        cell.timeLabel.text = this_event.time;
        cell.timeLabel.font = [UIFont fontWithName:@"Futura" size:17];
        cell.timeIcon.image = [UIImage imageNamed:@"venueBlack.png"];
        cell.venueIcon.image = [UIImage imageNamed:@"clockBlack.png"];
        NSString *combined = [NSString stringWithFormat:@"%@\n", [this_event location]];
        cell.venueTextview.text = combined;
        cell.venueTextview.backgroundColor = [UIColor clearColor];
        cell.venueTextview.font = [UIFont fontWithName:@"Futura" size:17];
        cell.venueTextview.userInteractionEnabled = NO;
        
        cell.eventDetailsTextView.text = [this_event description];
        cell.eventDetailsTextView.userInteractionEnabled = NO;
        cell.eventDetailsTextView.font = [UIFont fontWithName:@"Futura" size:17];
        cell.eventDetailsTextView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor colorWithRed:248.0/255.0 green:165.0/255.0 blue:66.0/255.0 alpha:0.2];
        
        [cell.checkButton setImage:[UIImage imageNamed:@"trash.png"] forState:UIControlStateNormal];
        
        [cell.checkButton addTarget:self action:@selector(deleteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.editButton setImage:[UIImage imageNamed:@"edit.png"] forState:UIControlStateNormal];
        
        [cell.editButton addTarget:self action:@selector(editButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.contentView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    
        return cell;
    }
}

-(void)deleteButtonPressed:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Are you sure you want to delete this event?" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
    
    [alertView show];
}

-(void)editButtonPressed:(id)sender
{
    EventCreateVC *eventCreateVC = [[EventCreateVC alloc]init];
    
    NSInteger index = [self.eventIndex integerValue];
    
    Event* this_event = [[[[EventManager sharedInstance] populatedEvents] allValues] objectAtIndex:index];
    
    eventCreateVC.editMode = YES;
    
    eventCreateVC.date = this_event.date;
    
    eventCreateVC.title = this_event.title;
    
    eventCreateVC.time = this_event.time;
    
    eventCreateVC.address = this_event.location;
    
    eventCreateVC.description = this_event.description;
    
    eventCreateVC.eventIndex = self.eventIndex;
    
    [self presentViewController:eventCreateVC animated:NO completion:nil];
}


-(void)yesButtonPressed:(UIButton*)yesButton{
    
    UIColor *orange = [[CommonClass sharedCommonClass] darkOrangeColor];
    
    self.yesButton.backgroundColor = [[CommonClass sharedCommonClass] darkOrangeColor];
    
    [self.yesButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.maybeButton.backgroundColor = [UIColor whiteColor];
    
    [self.noButton setTitleColor:orange forState:UIControlStateNormal];
    
    [self.maybeButton setTitleColor:orange forState:UIControlStateNormal];

    self.noButton.backgroundColor = [UIColor whiteColor];
}

-(void)maybeButtonPressed:(UIButton*)maybeButton{
    
    UIColor *orange = [[CommonClass sharedCommonClass] darkOrangeColor];
    
    self.maybeButton.backgroundColor = orange;
    
    [self.maybeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.noButton.backgroundColor = [UIColor whiteColor];
    
    [self.yesButton setTitleColor:orange forState:UIControlStateNormal];

    [self.noButton setTitleColor:orange forState:UIControlStateNormal];

    
    self.yesButton.backgroundColor = [UIColor whiteColor];
}

-(void)noButtonPressed:(UIButton*)noButton{
    
    UIColor *orange = [[CommonClass sharedCommonClass] darkOrangeColor];
    
    noButton.backgroundColor = [[CommonClass sharedCommonClass] darkOrangeColor];
    
    self.yesButton.backgroundColor = [UIColor whiteColor];
    
    [self.yesButton setTitleColor:orange forState:UIControlStateNormal];
    
    self.maybeButton.backgroundColor = [UIColor whiteColor];
    
    [self.maybeButton setTitleColor:orange forState:UIControlStateNormal];
    
    [self.noButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row==0)
    {
    [self dismissViewControllerAnimated:NO completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-UIAlertView Delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
    }
    else
    {
        [alertView dismissWithClickedButtonIndex:1 animated:YES];
        
        NSInteger index = [self.eventIndex integerValue];
        Event* this_event = [[[[EventManager sharedInstance] populatedEvents] allValues] objectAtIndex:index];
        
        [[EventManager sharedInstance] deleteEvent:this_event withCompletionHandler:^(NSError *error) {
            
            if (error)
            {
                NSLog(@"error deleting %@ event", this_event.title);
            }
            
            [self dismissViewControllerAnimated:NO completion:nil];
        }];
    }
}

@end
