//
//  CalendarListVC.m
//  StepUp1
//
//  Created by Sunayna Jain on 5/7/14.
//  Copyright (c) 2014 LittleAuk. All rights reserved.
//

#import "CalendarListVC.h"
#import "CommonClass.h"
#import "EventManager.h"
#import "CalendarCell.h"
#import "EventCreateVC.h"
#import "NewEventViewController.h"
#import "chatVC.h"
#import "AAPullToRefresh.h"

@interface CalendarListVC ()

{
    UIView *headerView;
}

@end

@implementation CalendarListVC

@synthesize myDelegate;

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
    
    self.view.backgroundColor = [[CommonClass sharedCommonClass] lightOrangeColor];
    
    headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,150)];
    
    headerView.backgroundColor = [[CommonClass sharedCommonClass] lightOrangeColor];
    
    if (!self.fromAdminPost)
    {
    UIButton *postsButton = [[UIButton alloc]initWithFrame:CGRectMake(5, 45, 36, 36)];
    
    [postsButton setBackgroundImage:[UIImage imageNamed:@"chatIcon.png"] forState:UIControlStateNormal];
    
    [postsButton addTarget:self action:@selector(postsButtonPressed:)  forControlEvents:UIControlEventTouchUpInside];
    
    [headerView addSubview:postsButton];
    }
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
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    
    self.tableView.hidden = YES;
    
    UITableView *tableview = self.tableView;
    
    AAPullToRefresh *refresh = [self.tableView addPullToRefreshPosition:AAPullToRefreshPositionTop actionHandler:^(AAPullToRefresh *v) {
        
        [tableview reloadData];
        
        [v performSelector:@selector(stopIndicatorAnimation) withObject:nil afterDelay:1.0f];
    }];
    
    refresh.imageIcon = [UIImage imageNamed:@"rsz_1refreshicon"];
    
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

-(void)handleRefresh:(id)sender
{
    
}


-(void)postsButtonPressed:(id)sender
{
    chatVC *vc = [[chatVC alloc]init];
    
    [self presentModalView:vc];
}

-(void)eventsButtonPressed:(id)sender
{
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
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
    if ([[[EventManager sharedInstance] populatedEvents] count]==0)
    {
        return 1;
    }
    
    else
    {
        return [[[EventManager sharedInstance] populatedEvents] count];
    }
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CalendarCell";
    
    CalendarCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        cell = [[CalendarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    cell.colorLabel.backgroundColor = [[CommonClass sharedCommonClass] lightOrangeColor];
    
    if (indexPath.row < [[[[EventManager sharedInstance] populatedEvents] allValues] count])
    {
    
    Event* this_event = [[[[EventManager sharedInstance] populatedEvents] allValues] objectAtIndex:indexPath.row];
    
    cell.dateLabel.text = this_event.date;
    
    cell.dateLabel.backgroundColor = [UIColor clearColor];
    
    cell.dateLabel.font = [UIFont fontWithName:@"Futura" size:18];
    
    cell.dateLabel.textColor = [UIColor blackColor];
    
    cell.headerLabel.text = this_event.title;
    
    cell.headerLabel.textColor = [UIColor blackColor];
    
    cell.headerLabel.backgroundColor = [UIColor clearColor];
    
    cell.headerLabel.font = [UIFont fontWithName:@"Futura" size:18];

    }
    return cell;
}

-(void)plusButtonPressed:(id)sender
{
    EventCreateVC *eventCreateVC = [[EventCreateVC alloc]init];
    
    [self presentViewController:eventCreateVC animated:NO completion:nil];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.fromAdminPost)
    {
        Event* this_event = [[[[EventManager sharedInstance] populatedEvents] allValues] objectAtIndex:indexPath.row];
        
        [self.myDelegate eventPassedBackFromEventList: this_event];
        
        [self dismissMe];
    }
    
    NewEventViewController *newEventVC = [[NewEventViewController alloc]initWithNibName:@"NewEventVC" bundle:nil];
    
    newEventVC.eventIndex = [[NSNumber alloc]initWithInteger:indexPath.row];
    
    [self presentViewController:newEventVC animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Custom Modal Transitions

-(void) presentModalView:(UIViewController *)controller {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.35;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    
    UIView *containerView = self.view.window;
    [containerView.layer addAnimation:transition forKey:nil];
    [self presentViewController:controller animated:NO completion:nil];
}

-(void) dismissMe
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.35;
    transition.timingFunction =
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    
    UIView *containerView = self.view.window;
    [containerView.layer addAnimation:transition forKey:nil];
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
