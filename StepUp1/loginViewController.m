//
//  loginViewController.m
//  StepUp1
//
//  Created by Sachin Jindal on 2/9/14.
//  Copyright (c) 2014 LittleAuk. All rights reserved.
//

#import "loginViewController.h"
#import "CommonClass.h"
#import "CalendarListVC.h"
#import "EventManager.h"
#import "chatViewController.h"
#import "chatVC.h"

@interface loginViewController ()

@end

@implementation loginViewController

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
    
    //EventManager* em = [EventManager sharedInstance];
    //[em fetchAllEvents];
    
    self.view.backgroundColor = [[CommonClass sharedCommonClass] darkOrangeColor];
    
    UIImageView *logoView = [[UIImageView alloc]initWithFrame:CGRectMake(70,0 ,180, self.view.frame.size.height-280)];
    
    logoView.image = [UIImage imageNamed:@"login-background"];
    
    [self.view addSubview:logoView];
    
    UIView *container = [[UIView alloc]initWithFrame:CGRectMake(0, 280, self.view.frame.size.width, 60)];
	// Do any additional setup after loading the view.
    
    container.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:container];
    
    UITextField *code =[[UITextField alloc]initWithFrame:CGRectMake(10,0, 180,60)];
    
    code.userInteractionEnabled = YES;
    
    code.font = [UIFont systemFontOfSize:15];
    
    code.delegate = self;
    
    code.placeholder = @"enter registration code";
    
    [container addSubview:code];
    
    UIButton *sendButton = [[UIButton alloc]initWithFrame:CGRectMake(240, 5, 60, 50)];
    
    [sendButton addTarget:self action:@selector(sendButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [sendButton setTitle:@"Send" forState:UIControlStateNormal];
    
    sendButton.backgroundColor = [[CommonClass sharedCommonClass] darkOrangeColor];
    
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    sendButton.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [container addSubview:sendButton];
}

-(void)sendButtonPressed:(id)sender{
    
//    CalendarListViewController *calendarListVC = [[CalendarListViewController alloc]initWithNibName:@"CalendarListVC" bundle:nil];
//    
//    [self presentViewController:calendarListVC animated:YES completion:nil];
    
//    chatViewController *chatVC = [[chatViewController alloc]init];
//    
//    [self presentViewController:chatVC animated:YES completion:nil];
    
    CalendarListVC *calendarList = [[CalendarListVC alloc]init];
    
  //  chatVC *vc = [[chatVC alloc]init];
    
    [self presentViewController:calendarList animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-UITextField Delegate methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
