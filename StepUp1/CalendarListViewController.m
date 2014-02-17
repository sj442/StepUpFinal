//
//  CalendarListViewController.m
//  StepUp
//
//  Created by Sunayna Jain on 2/8/14.
//
//

#import "CalendarListViewController.h"
#import "CalendarCell.h"
#import "NewEventViewController.h"
#import "EventCreateViewController.h"
#import "EventManager.h"
#import <EventKit/EventKit.h>
#import "CommonClass.h"

@interface CalendarListViewController ()

@end

@implementation CalendarListViewController

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
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [[CommonClass sharedCommonClass] lightOrangeColor];
    self.view.backgroundColor = [[CommonClass sharedCommonClass] lightOrangeColor];
        
    [self addRightBarButtonItem];
    
    self.title = @"Events";
    
    EventManager* em = [EventManager sharedInstance];
    [em fetchAllEvents];
    
	// Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [self.tableView reloadData];
}

-(void)addRightBarButtonItem{
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPressed:)];
}

-(void)addPressed:(id)sender{
    
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
    //button.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
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

    return view;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
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


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[EventManager sharedInstance] populatedEvents] count];
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   static NSString *CellIdentifier = @"CalendarCell";
    CalendarCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[[UINib nibWithNibName:@"CalendarCell" bundle:[NSBundle mainBundle]] instantiateWithOwner:self options:nil] objectAtIndex:0];
    }
    Event* this_event = [[[[EventManager sharedInstance] populatedEvents] allValues] objectAtIndex:[indexPath row]];
    cell.headerLabel.text = ([this_event title] != nil) ? [this_event title] : @"Untitled";
    NSString* time_str = [this_event time];
    NSRange my_range;
    my_range.location = 5;
    my_range.length = 5;
    NSString* short_str = @"";
    
    if ([time_str length] > 11) {
      short_str = [time_str substringWithRange:my_range];
    }

    cell.dateLabel.text = short_str;
    cell.colorLabel.text = @"";
    cell.headerLabel.font = [UIFont fontWithName:@"Futura" size:18];
    cell.dateLabel.font = [UIFont fontWithName:@"Futura" size:18];
    
    cell.colorLabel.backgroundColor = [[CommonClass sharedCommonClass] lightOrangeColor];
    return cell;
}

-(void)plusButtonPressed:(id)sender{
    
    EventCreateViewController *eventCreateVC = [[EventCreateViewController alloc]initWithNibName:@"EventCreateVC" bundle:nil];
    
    [self presentViewController:eventCreateVC animated:NO completion:nil];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewEventViewController *newEventVC = [[NewEventViewController alloc]initWithNibName:@"NewEventVC" bundle:nil];
    
    newEventVC.eventIndex = [[NSNumber alloc]initWithInt:indexPath.row];
    
    [self presentViewController:newEventVC animated:NO completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
