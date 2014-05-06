//
//  chatViewController.m
//  StepUp1
//
//  Created by Sunayna Jain on 2/16/14.
//  Copyright (c) 2014 LittleAuk. All rights reserved.
//

#import "chatViewController.h"
#import "chatDetailViewController.h"
#import "chatCell.h"
#import "CommonClass.h"
#import "PostManager.h"
#import "Post.h"

@interface chatViewController ()

{
    BOOL answerRow;
    
}

@end

@implementation chatViewController

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
    
    CGFloat statusBarHeight =[UIApplication sharedApplication].statusBarFrame.size.height;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,statusBarHeight, self.view.frame.size.width, self.view.frame.size.height-statusBarHeight) style:UITableViewStylePlain];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.hidden = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [[CommonClass sharedCommonClass] lightOrangeColor];
    
    self.view.backgroundColor = [[CommonClass sharedCommonClass] lightOrangeColor];
    
    UINib *nib = [UINib nibWithNibName:@"chatCell" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"chatCell"];
    
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    if ([[[PostManager sharedInstance] populatedPosts] count]==0)
    {
        return 1;
    }
    else if (answerRow)
    {
        return ([[[PostManager sharedInstance] populatedPosts] count] +1);
    }
    else
    {
        return [[[PostManager sharedInstance] populatedPosts] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"chatCell";
    
    chatCell *cell= [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.questionTextView.text = @"";
    
    if (!cell)
    {
//        cell = [[[UINib nibWithNibName:@"chatCell" bundle:[NSBundle mainBundle]] instantiateWithOwner:self options:nil] objectAtIndex:0];
        
        cell = [[chatCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    cell.questionTextView.backgroundColor = [[CommonClass sharedCommonClass] lightOrangeColor];
    
    cell.questionTextView.userInteractionEnabled = NO;
    
    if ([[[PostManager sharedInstance] populatedPosts] count]==0)
    {
       cell.questionTextView.text = @"No Posts";
    }
    else
    {
        if (indexPath.row<[[[PostManager sharedInstance] populatedPosts] count])
        {
        Post *this_post = [[[[PostManager sharedInstance] populatedPosts] allValues] objectAtIndex:indexPath.row];
    
        NSString *postString = [NSString stringWithFormat:@"%@:%@", this_post.title, this_post.text];
        
        cell.questionTextView.text = postString;
        
        cell.questionTextView.textColor = [UIColor whiteColor];
        
        cell.questionTextView.font = [UIFont fontWithName:@"Futura" size:15];
        }
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 138;
}

//-(void)commentAddedToCell:(UITableViewCell*)cell{
//
//    CGFloat xOrigin = 0;
//    CGFloat yOrigin = 0;
//    
//    NSString *comment= @"The event to be held on 3/15 has been postponed to 3/19 because of scheduling issues with one of the mentors";
//    
//    UITextView *commentView = [[UITextView alloc]initWithFrame:CGRectMake(xOrigin, yOrigin, cell.frame.size.width, 50)];
//    
//    commentView.text = comment;
//    
//    [((chatCell*)cell).answerView addSubview:commentView];
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    chatDetailViewController *chatDetail = [[chatDetailViewController alloc]init];

    chatDetail.post = [[[[PostManager sharedInstance] populatedPosts] allValues] objectAtIndex:indexPath.row];
    
    [self presentViewController:chatDetail animated:NO completion:^{
        //any task ot be done on completion
    }];
}

@end
