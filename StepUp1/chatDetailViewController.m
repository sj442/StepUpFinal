//
//  chatDetailViewController.m
//  StepUp1
//
//  Created by Sunayna Jain on 5/6/14.
//  Copyright (c) 2014 LittleAuk. All rights reserved.
//

#import "chatDetailViewController.h"
#import "PostManager.h"
#import "CommonClass.h"
#import "chatCell.h"
#import "CommentManager.h"

@interface chatDetailViewController ()
{
    UIButton *sendButton;
}

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UITextView *questionView;

@property (strong, nonatomic) UITextField *chatTextField;

@property (strong, nonatomic) UIView *chatView;

-(void) registerForKeyboardNotifications;

-(void) keyboardWasShown:(NSNotification*)aNotification;

-(void) keyboardWillHide:(NSNotification*)aNotification;

@end

@implementation chatDetailViewController

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
    
    [self registerForKeyboardNotifications];
    
    self.view.backgroundColor = [[CommonClass sharedCommonClass] darkOrangeColor];
    
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    self.questionView = [[UITextView alloc]initWithFrame:CGRectMake(0, statusBarHeight, self.view.frame.size.width,130)];
    
    self.questionView.backgroundColor = [[CommonClass sharedCommonClass] darkOrangeColor];
    
    self.questionView.textColor = [UIColor whiteColor];
    
    self.questionView.font = [UIFont fontWithName:@"Futura" size:15];

    self.questionView.text = [NSString stringWithFormat:@"%@:%@", self.post.title, self.post.text];
    
    [self.view addSubview:self.questionView];
    
    self.questionView.editable = NO;
    
    UIButton *questionButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.questionView.frame.size.width, self.questionView.frame.size.height)];
    
    questionButton.backgroundColor = [UIColor clearColor];
    
    [questionButton addTarget:self action:@selector(questionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.questionView addSubview:questionButton];
    
    self.chatView = [[UIView alloc]initWithFrame:CGRectMake(0, 498, self.view.frame.size.width, 70)];
    
    [self.view addSubview:self.chatView];
    
    self.chatView.backgroundColor = [UIColor colorWithRed:0.992f green:0.929f blue:0.851f alpha:0.95f];
    
    self.chatTextField = [[UITextField alloc] initWithFrame:CGRectMake(5, 10, 230, 50)];
    
    self.chatTextField.backgroundColor = [UIColor clearColor];
    
    self.chatTextField.placeholder = @"Type a message...";
    
    self.chatTextField.delegate = self;
    
    [self.chatView addSubview:self.chatTextField];
    
    sendButton = [[UIButton alloc]initWithFrame:CGRectMake(240, 10, 75, 50)];
    
    [sendButton setTitle:@"Send" forState:UIControlStateNormal];
    
    sendButton.titleLabel.font = [UIFont fontWithName:@"Futura" size:17];
    
    [sendButton setTitleColor:[[CommonClass sharedCommonClass] darkOrangeColor] forState:UIControlStateNormal];
    
    [sendButton addTarget:self action:@selector(sendButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

    sendButton.layer.borderWidth = 3.0f;
    
    sendButton.layer.borderColor = [[CommonClass sharedCommonClass] darkOrangeColor].CGColor;
    
    [self.chatView addSubview:sendButton];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, statusBarHeight+self.questionView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-statusBarHeight-self.questionView.frame.size.height-self.chatView.frame.size.height) style:UITableViewStylePlain];
    
    UINib *nib = [UINib nibWithNibName:@"chatCell" bundle:[NSBundle mainBundle]];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"chatCell"];
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.hidden = YES;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [self.view addSubview:self.tableView];
    
    UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-25, self.view.frame.size.height/2-25, 50, 50)];
    
    view.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    
    [self.view addSubview:view];
    
    [view startAnimating];
    
    CommentManager* cm= [CommentManager sharedInstance];
    
    [cm fetchAllCommentsWithPostID:self.post.postId withcompletionhandler:^(NSMutableDictionary *dictionary) {
        [view stopAnimating];
        self.tableView.hidden = NO;
        [self.tableView reloadData];
    }];
     
    // Do any additional setup after loading the view.
}

-(void)questionButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)sendButtonPressed:(id)sender
{
    [self.chatTextField resignFirstResponder];
    
    NSDate *date = [NSDate date];
    
    int timeInterval = [date timeIntervalSince1970];
        
    Comment *comment = [[Comment alloc]initWithCommentId:@"" andUser:@"Sunayna Jain" andCommentText:self.chatTextField.text andTimeStamp:[NSNumber numberWithInt:timeInterval] andPostID:self.post.postId];

    [self.post addComment:comment];
    
    [[CommentManager sharedInstance] addNewComment:comment toPost:self.post withCompletionHandler:^(NSError *error) {
        
        [self.tableView reloadData];
        
        self.chatTextField.text = @"";
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-UITableView DataSource methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[[[CommentManager sharedInstance] populatedComments] allKeys]count]>0)
    {
        return [[[[CommentManager sharedInstance] populatedComments] allKeys]count];
    }
    else
    {
        return 1;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    chatCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"chatCell"];
    
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    if (!cell)
    {
        cell = [[chatCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"chatCell"];
    }
    cell.questionTextView.userInteractionEnabled = NO;
    
    if ([[[[CommentManager sharedInstance] populatedComments] allKeys] count]==0)
    {
        cell.questionTextView.text = @"No comments yet. Start a conversation!";
    }
    
    else
    {
        Comment *this_comment = [[[[CommentManager sharedInstance] populatedComments] allValues] objectAtIndex:indexPath.row];
        
        cell.questionTextView.text = this_comment.commentText;
        
        cell.nameTextField.text = this_comment.userName;
        
        NSDate *commentDate = [NSDate dateWithTimeIntervalSince1970:this_comment.commentTimeStamp.intValue];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        
        [dateFormatter setDateFormat:@"MM/dd"];
        
        cell.dateTextField.text =  [dateFormatter stringFromDate:commentDate];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

#pragma mark - Chat textfield

-(IBAction) textFieldDoneEditing : (id) sender
{
    NSLog(@"the text content%@",self.chatTextField.text);
    [sender resignFirstResponder];
    [self.chatTextField resignFirstResponder];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
//    if (self.chatTextField.text.length>0)
//    {
//        [sendButton setBackgroundColor:[[CommonClass sharedCommonClass] darkOrangeColor]];
//        
//        [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    }
//    else
//    {
//        [sendButton setBackgroundColor:[UIColor clearColor]];
//        
//        [sendButton setTitleColor:[[CommonClass sharedCommonClass] darkOrangeColor] forState:UIControlStateNormal];
//    }
    return YES;
}

-(IBAction) backgroundTap:(id) sender
{
    [self.chatTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"the text content%@",self.chatTextField.text);
    
    [textField resignFirstResponder];
   
    return YES;
}

#pragma mark-Keyboard handling methods

-(void) registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void) keyboardWasShown:(NSNotification*)aNotification
{
    NSLog(@"Keyboard was shown");
    NSDictionary* info = [aNotification userInfo];
    
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardFrame;
    
    [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] getValue:&keyboardFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    NSLog(@"chat view y origin %f", self.chatView.frame.origin.y);
    
    [self.chatView setFrame:CGRectMake(self.chatView.frame.origin.x, self.chatView.frame.origin.y- keyboardFrame.size.height, self.chatView.frame.size.width, self.chatView.frame.size.height)];
    
    [self.view addSubview:self.chatView];
    
    [UIView commitAnimations];
}

-(void) keyboardWillHide:(NSNotification*)aNotification
{
    NSLog(@"Keyboard will hide");
    NSDictionary* info = [aNotification userInfo];
    
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardFrame;
    [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] getValue:&keyboardFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    [self.chatView setFrame:CGRectMake(self.chatView.frame.origin.x, self.chatView.frame.origin.y+keyboardFrame.size.height, self.chatView.frame.size.width, self.chatView.frame.size.height)];
    
    [self.view addSubview:self.chatView];
    
    [UIView commitAnimations];
}

@end
