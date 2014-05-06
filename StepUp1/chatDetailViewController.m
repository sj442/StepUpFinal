//
//  chatDetailViewController.m
//  StepUp1
//
//  Created by Sunayna Jain on 5/6/14.
//  Copyright (c) 2014 LittleAuk. All rights reserved.
//

#import "chatDetailViewController.h"
#import "CommonClass.h"

@interface chatDetailViewController ()

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UITextView *questionView;

@property (strong, nonatomic) UITextField *chatTextField;

@property (strong, nonatomic) UIView *chatView;

@end

@implementation chatDetailViewController

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
    
    self.view.backgroundColor = [[CommonClass sharedCommonClass] darkOrangeColor];
    
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    self.questionView = [[UITextView alloc]initWithFrame:CGRectMake(0, statusBarHeight, self.view.frame.size.width,130)];
    
    self.questionView.backgroundColor = [[CommonClass sharedCommonClass] darkOrangeColor];
    
    self.questionView.textColor = [UIColor whiteColor];
    
    self.questionView.font = [UIFont fontWithName:@"Futura" size:15];

    self.questionView.text = [NSString stringWithFormat:@"%@:%@", self.post.title, self.post.text];
    
    [self.view addSubview:self.questionView];
    
    self.questionView.userInteractionEnabled = NO;
    
    self.chatView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-70, self.view.frame.size.width, 70)];
    
    [self.view addSubview:self.chatView];
    
    self.chatView.backgroundColor = [UIColor colorWithRed:0.992f green:0.929f blue:0.851f alpha:0.95f];
    
    self.chatTextField = [[UITextField alloc] initWithFrame:CGRectMake(5, 10, 230, 50)];
    
    self.chatTextField.backgroundColor = [UIColor clearColor];
    
    self.chatTextField.placeholder = @"Type a message...";
    
    [self.chatView addSubview:self.chatTextField];
    
    UIButton *sendButton = [[UIButton alloc]initWithFrame:CGRectMake(240, 10, 75, 50)];
    
    [sendButton setTitle:@"Send" forState:UIControlStateNormal];
    
    sendButton.titleLabel.font = [UIFont fontWithName:@"Futura" size:17];
    
    [sendButton setTitleColor:[[CommonClass sharedCommonClass] darkOrangeColor] forState:UIControlStateNormal];
    
    [sendButton addTarget:self action:@selector(sendButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

    sendButton.layer.borderWidth = 3.0f;
    
    sendButton.layer.borderColor = [[CommonClass sharedCommonClass] darkOrangeColor].CGColor;
    
    [self.chatView addSubview:sendButton];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, statusBarHeight+self.questionView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-statusBarHeight-self.questionView.frame.size.height-self.chatView.frame.size.height) style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];

    // Do any additional setup after loading the view.
}

-(void)sendButtonPressed:(id)sender
{
    

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
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
