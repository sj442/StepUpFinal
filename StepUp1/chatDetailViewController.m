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
    
    self.questionView.userInteractionEnabled = NO;
    
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
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];

    // Do any additional setup after loading the view.
}

-(void)sendButtonPressed:(id)sender
{
    [self.chatTextField resignFirstResponder];
    
    NSDate *date = [NSDate date];
    
    int timeInterval = [date timeIntervalSince1970];
    
    Comment *comment = [[Comment alloc] initWithCommentId:@"" andUser:@"Sunayna Jain" andCommentText:self.chatTextField.text andTimeStamp:[ NSNumber numberWithInt:timeInterval]];
    
//    Comment *firstComment = [self.post.comments firstObject];
//    
//    if ([firstComment.userName isEqualToString:@""] || [firstComment.commentTimeStamp isEqualToNumber:[NSNumber numberWithInt:0]])
//    {
//        [self.post.comments removeObject:firstComment];
//    }
    
    [self.post addComment:comment];
    
    [[PostManager sharedInstance] addCommentToPost:self.post andComment:comment];
    
    [self.tableView reloadData];
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
    if ([self.post.comments count]>0)
    {
    return [self.post.comments count];
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
    
    if ([((Comment*)self.post.comments[indexPath.row]).userName isEqualToString:@""])
    {
        cell.questionTextView.text = @"No Comments yet. Start a conversation!";
        
        cell.nameTextField.text = @"";
        
        cell.dateTextField.text = @"";
    }
    else
    {
        cell.questionTextView.text = [self.post.comments objectAtIndex:[self.post.comments count]-(indexPath.row+1)];
        
        cell.nameTextField.text = @"Sunayna Jain";
        
        cell.dateTextField.text = @"2:30 PM, Today";
    }
    
    return cell;
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
