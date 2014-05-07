//
//  CalendarListViewController.m
//  StepUp
//
//  Created by Sunayna Jain on 2/8/14.

#import "CalendarListViewController.h"
#import "CalendarCell.h"
#import "NewEventViewController.h"
#import "EventCreateViewController.h"
#import "EventManager.h"
#import <EventKit/EventKit.h>
#import "CommonClass.h"
#import "EventCreateVC.h"

@interface CalendarListViewController ()
{
    NSString *thisMonth;
    
    NSString *nextMonth;
    
    NSArray *eventsArray;
}

@end

@implementation CalendarListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self getThisAndNextMonth];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.hidden = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [[CommonClass sharedCommonClass] lightOrangeColor];
    self.view.backgroundColor = [[CommonClass sharedCommonClass] lightOrangeColor];
    [self addRightBarButtonItem];
    
    self.title = @"Events";
    
    UINib *nib = [UINib nibWithNibName:@"CalendarCell" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"CalendarCell"];
    
    UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-25, self.view.frame.size.height/2-25, 50, 50)];
    
    view.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    
    [self.view addSubview:view];
    
    [view startAnimating];
    
    EventManager* em = [EventManager sharedInstance];
    
    [em fetchAllEventsWithCompletionHandler:^(NSMutableDictionary *dictionary) {
        [view stopAnimating];
        self.tableView.hidden = NO;
        [self.tableView reloadData];
    }];
    
	// Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.tableView reloadData];
}

-(void)getThisAndNextMonth
{
    //NSDate *today = [NSDate date];
    
    //NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:today];
    
    //NSInteger thisMonth = [components month];
}

-(void)addRightBarButtonItem
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPressed:)];
}

-(void)addPressed:(id)sender
{
    NewEventViewController *newEventVC = [[NewEventViewController alloc]initWithNibName:@"NewEventVC" bundle:nil];
    
    [self.navigationController pushViewController:newEventVC animated:YES];
}

#pragma mark-UITableView DataSource methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 120;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 100)];
    view.backgroundColor = [[CommonClass sharedCommonClass]lightOrangeColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = [[CommonClass sharedCommonClass] darkOrangeColor];
    button.titleLabel.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:24];
    [button setTitle:@"upcoming" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(upcomingEventsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(20, 20, 200, 60);
    [view addSubview:button];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(80, 80, 200, 40)];
    label.textColor = [UIColor whiteColor];
    label.text = @"events";
    label.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:24];
    [view addSubview:label];

    return view;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 100)];
    
    view.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    
    UIButton *plusButton = [[UIButton alloc]initWithFrame:CGRectMake(130,10, 60, 50)];
    
    [plusButton setTitle:@"+" forState:UIControlStateNormal];
    
    UIColor *color = [[CommonClass sharedCommonClass] lightOrangeColor];
    
    [plusButton setTitleColor:color forState:UIControlStateNormal];
    
    plusButton.titleLabel.font = [UIFont fontWithName:@"Futura" size:50];
    
    [plusButton addTarget:self action:@selector(plusButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:plusButton];
    
    return view;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[EventManager sharedInstance] populatedEvents] count];
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *CellIdentifier = @"CalendarCell";
    
    CalendarCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
//    UIView *subview;
//    
//    UILabel *dateLabel;
//    
//    dateLabel.text = @"";
//    
//    UILabel *titleLabel;
//    
//    titleLabel.text = @"";
    
    if (!cell)
    {
        cell = [[CalendarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    cell.colorLabel.backgroundColor = [[CommonClass sharedCommonClass] lightOrangeColor];
    
    Event* this_event = [[[[EventManager sharedInstance] populatedEvents] allValues] objectAtIndex:indexPath.row];
    
//    subview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, 60)];
//    
//    dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 70, 60)];
//    
//    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 0, 210, 60)];
//    
//    [subview addSubview:dateLabel];
//    
//    [subview addSubview:titleLabel];
//    
//    [cell addSubview:subview];
    
//    dateLabel.backgroundColor = [UIColor clearColor];
//  
//    dateLabel.textColor = [UIColor blackColor];
//    
//    dateLabel.font = [UIFont fontWithName:@"Futura" size:18];
    
//  NSString* time_str = [this_event time];
//  
//    NSRange my_range;
//    my_range.location = 5;
//    my_range.length = 5 ;
//    NSString* short_str = @"";
//    
//    if ([time_str length] > 10) {
//        short_str = [time_str substringWithRange:my_range];
//    }
//    
//    dateLabel.text = short_str;
    
    cell.dateLabel.text = this_event.date;
    
    cell.dateLabel.backgroundColor = [UIColor clearColor];
    
    cell.dateLabel.font = [UIFont fontWithName:@"Futura" size:18];
    
    cell.dateLabel.textColor = [UIColor blackColor];
    
//    dateLabel.text = this_event.date;
    
    cell.headerLabel.text = this_event.title;
    
    cell.headerLabel.textColor = [UIColor blackColor];
    
    cell.headerLabel.backgroundColor = [UIColor clearColor];
    
//    titleLabel.backgroundColor = [UIColor clearColor];
//    
//    titleLabel.text = this_event.title;
//    
//    titleLabel.font = [UIFont fontWithName:@"Futura" size:18];

    cell.headerLabel.font = [UIFont fontWithName:@"Futura" size:18];
    
  //  subview.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

-(void)upcomingEventsButtonPressed:(id)sender
{
    
}

-(void)plusButtonPressed:(id)sender
{
    EventCreateVC *eventCreateVC = [[EventCreateVC alloc]init];
    
    [self presentViewController:eventCreateVC animated:NO completion:nil];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NewEventViewController *newEventVC = [[NewEventViewController alloc]initWithNibName:@"NewEventVC" bundle:nil];
    
    newEventVC.eventIndex = [[NSNumber alloc]initWithInteger:indexPath.row];
    
    [self presentViewController:newEventVC animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
