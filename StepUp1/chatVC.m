//
//  chatVC.m
//  StepUp1
//
//  Created by Sunayna Jain on 5/7/14.
//  Copyright (c) 2014 LittleAuk. All rights reserved.
//

#import "chatVC.h"
#import "Post.h"
#import "CommonClass.h"
#import "postCell.h"
#import "PostManager.h"
#import "CalendarListVC.h"
#import "MenteePostCreate.h"
#import "AdminPostCreate.h"
#import "chatDetailViewController.h"
#import "AAPullToRefresh.h"

@interface chatVC ()
{
    UIView *headerView;
    
    NSMutableArray *filteredPosts;
    
    NSNumber *selectedPostType;
}

@end

@implementation chatVC

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
    
    self.view.backgroundColor = [[CommonClass sharedCommonClass] lightOrangeColor];
    
    headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,150)];
    
    headerView.backgroundColor = [[CommonClass sharedCommonClass] lightOrangeColor];
    
    UIButton *calendarButton = [[UIButton alloc]initWithFrame:CGRectMake(280, 45, 36, 36)];
    
    [calendarButton setBackgroundImage:[UIImage imageNamed:@"chatIcon"] forState:UIControlStateNormal];
    
    [calendarButton addTarget:self action:@selector(calendarButtonPressed:)  forControlEvents:UIControlEventTouchUpInside];
    
    [headerView addSubview:calendarButton];
    
    UIButton *eventsButton = [[UIButton alloc]initWithFrame:CGRectMake(51, 30, 220, 63)];
    
    [eventsButton addTarget:self action:@selector(eventsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [eventsButton setBackgroundColor:[[CommonClass sharedCommonClass] darkOrangeColor]];
    
    [eventsButton setTitle:@"discussion" forState:UIControlStateNormal];
    
    selectedPostType = [[NSNumber alloc]initWithInteger:1];
    
    [eventsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    eventsButton.titleLabel.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:32];
    
    eventsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    eventsButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    [headerView addSubview:eventsButton];
    
    UILabel *eventsLabel = [[UILabel alloc]initWithFrame:CGRectMake(61, 92, 180, 63)];
    
    eventsLabel.text = @"posts";
    
    eventsLabel.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:32];
    
    eventsLabel.textColor = [UIColor whiteColor];
    
    [headerView addSubview:eventsLabel];
    
    [self.view addSubview:headerView];
    
    [self setupTableView];
    
    UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-25, self.view.frame.size.height/2-25, 50, 50)];
    
    view.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    
    [self.view addSubview:view];
    
    [view startAnimating];
    
    PostManager* pm = [PostManager sharedInstance];
    [pm fetchAllPostsWithCompletionHandler:^(NSMutableDictionary *dictionary) {
        [view stopAnimating];
        [self.tableView reloadData];
        self.tableView.hidden = NO;
    }];
    // Do any additional setup after loading the view.
}

-(void)setupTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, headerView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-headerView.frame.size.height) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = [[CommonClass sharedCommonClass] lightOrangeColor];
    
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    self.tableView.hidden = YES;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    
    UINib *nib = [UINib nibWithNibName:@"postCell" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"postCell"];
    
    UITableView *tableview = self.tableView;
    
    AAPullToRefresh *refresh = [self.tableView addPullToRefreshPosition:AAPullToRefreshPositionTop actionHandler:^(AAPullToRefresh *v) {
        
        [tableview reloadData];
        
        [v performSelector:@selector(stopIndicatorAnimation) withObject:nil afterDelay:1.0f];
    }];
    
    refresh.imageIcon = [UIImage imageNamed:@"rsz_1refreshicon"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark-UITableView DataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if ([[[PostManager sharedInstance] populatedPosts] count]==0)
//    {
//        return 1;
//    }
//    
//    else
//    {
//        return [[[PostManager sharedInstance] populatedPosts] count];
//    }
    
    if ([[self filteredPostsForPostType:selectedPostType] count]==0)
    {
        return 1;
    }
    else
    {
        return [[self filteredPostsForPostType:selectedPostType] count];
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"postCell";
    
    postCell *cell= [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.postTextView.text = @"";
    
    if (!cell)
    {        
        cell = [[postCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    cell.postTextView.backgroundColor = [[CommonClass sharedCommonClass] lightOrangeColor];
    
    cell.postTextView.userInteractionEnabled = NO;
    
//    if ([[[PostManager sharedInstance] populatedPosts] count]==0)
//    {
//        cell.postTextView.text = @"No Posts";
//    }
    
    if ([[self filteredPostsForPostType:selectedPostType] count]==0)
    {
        cell.postTextView.text = @"No Posts";
        
        cell.postTextView.textColor = [UIColor whiteColor];
        
        cell.postTextView.font = [UIFont fontWithName:@"Futura" size:15];
    }
    
    else
    {
        //if (indexPath.row<[[[PostManager sharedInstance] populatedPosts] count])
            
          if (indexPath.row< [[self filteredPostsForPostType:selectedPostType] count])
        {
            //Post *this_post = [[[[PostManager sharedInstance] populatedPosts] allValues] objectAtIndex:indexPath.row];
            
            Post *this_post = [[self filteredPostsForPostType:selectedPostType] objectAtIndex:indexPath.row];
            
            NSString *postString;
            
            if (this_post.title.length!=0)
            {
            postString = [NSString stringWithFormat:@"%@:%@", this_post.title, this_post.text];
            }
            else
            {
                postString = this_post.text;
            }
            
            cell.postTextView.text = postString;
            
            cell.postTextView.textColor = [UIColor whiteColor];
            
            cell.postTextView.font = [UIFont fontWithName:@"Futura" size:15];
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    chatDetailViewController *chatDetail = [[chatDetailViewController alloc]init];
    
    chatDetail.post = [[[[PostManager sharedInstance] populatedPosts] allValues] objectAtIndex:indexPath.row];
    
    [self presentViewController:chatDetail animated:NO completion:^{
        //any task ot be done on completion
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 138;
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

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 70;
}

-(void)plusButtonPressed:(id)sender
{
    //MenteePostCreate *postCreate = [[MenteePostCreate alloc]init];
    
    AdminPostCreate *postCreate = [[AdminPostCreate alloc]init];
    
    [self presentViewController:postCreate animated:NO completion:nil];
}

-(void)calendarButtonPressed:(id)sender
{
    [self dismissMe];
}

-(void)eventsButtonPressed:(id)sender
{
    UIButton *button = (UIButton*)sender;
    
    if ([selectedPostType isEqualToNumber:[NSNumber numberWithInteger:0]])
    {
        selectedPostType =[NSNumber numberWithInteger:1];
        
        [button setTitle:@"discussion" forState:UIControlStateNormal];
        
        //show discussion posts
        
       
        
        return;
    }
    else if ([selectedPostType isEqualToNumber:[NSNumber numberWithInteger:1]])
    {
        selectedPostType =[NSNumber numberWithInteger:2];
        
        [button setTitle:@"general" forState:UIControlStateNormal];
        
        //show general posts
    }
    else
    {
        selectedPostType =[NSNumber numberWithInteger:0];
        //show event updates
        
        [button setTitle:@"event updates" forState:UIControlStateNormal];
    }
    
    [self filteredPostsForPostType:selectedPostType];
    
    [self.tableView reloadData];
}

-(NSMutableArray*)filteredPostsForPostType:(NSNumber*) postType
{
    if (filteredPosts)
    {
        [filteredPosts removeAllObjects];
    }
    else
    {
        filteredPosts = [[NSMutableArray alloc]init];
    }
    
    for (Post *post in [[[PostManager sharedInstance] populatedPosts] allValues])
    {
        if (post.type==[postType integerValue])
        {
            [filteredPosts addObject:post];
        }
    }
    
    NSLog(@"filtered posts now are %@", [filteredPosts description]);
    
    return filteredPosts;
}

#pragma mark- Custom Modal Transitions

-(void) presentModalView:(UIViewController *)controller
{
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
