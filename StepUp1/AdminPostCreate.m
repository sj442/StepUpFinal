//
//  AdminPostCreate.m
//  StepUp1
//
//  Created by Sunayna Jain on 5/7/14.
//  Copyright (c) 2014 LittleAuk. All rights reserved.
//

#import "AdminPostCreate.h"
#import "CommonClass.h"
#import "PostManager.h"

@interface AdminPostCreate ()
{
    UIView *headerView;
    
    CGRect hiddenFrame;
    
    CGRect visibleFrame;
    
    NSArray *postTypes;
    
    UIPickerView *postPicker;
    
    UIButton *pickTypeButton;
    
    UITextView *postTextView;
    
    BOOL postPickerIsOpen;
}

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation AdminPostCreate

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
    
    [self registerForKeyboardNotifications];
    
    self.view.backgroundColor = [[CommonClass sharedCommonClass] lightOrangeColor];
    
    headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,150)];
    
    headerView.backgroundColor = [[CommonClass sharedCommonClass] lightOrangeColor];
    
    UIButton *eventsButton = [[UIButton alloc]initWithFrame:CGRectMake(51, 30, 220, 63)];
    
    [eventsButton setBackgroundColor:[[CommonClass sharedCommonClass] darkOrangeColor]];
    
    [eventsButton setTitle:@"discussion" forState:UIControlStateNormal];
    
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
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, headerView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-headerView.frame.size.height)];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    self.tableView.hidden = NO;
    
    postPicker = [[UIPickerView alloc]initWithFrame:hiddenFrame];
    
    postPicker.dataSource = self;
    
    postPicker.delegate = self;
    
    postPicker.hidden = YES;
    
    [self.tableView addSubview:postPicker];
    
    [postPicker selectRow:1 inComponent:0 animated:NO];
    
    postTypes = [[NSArray alloc]initWithObjects:@"Event Updates", @"Discussion", @"General", nil];
    
    hiddenFrame = CGRectMake(0, self.tableView.frame.size.height, 320, 162);
    
    visibleFrame = CGRectMake(0, self.tableView.frame.size.height-250, 320, 162);
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-UITableView Delegate & DataSource methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        return 60;
    }
    else if (indexPath.row==1)
    {
        return 70;
    }
    else if (indexPath.row==2)
    {
        return self.tableView.frame.size.height-200;
    }
    else
    {
        return 70;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    if (indexPath.row==0)
    {
        pickTypeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
        
        [pickTypeButton setTitle:@"Pick Post Type" forState:UIControlStateNormal];
        
        pickTypeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        [pickTypeButton setContentEdgeInsets:UIEdgeInsetsMake(0, 10.0f, 0, 0)];
        
        pickTypeButton.titleLabel.font = [UIFont fontWithName:@"Futura" size:17];
        
        [pickTypeButton addTarget:self action:@selector(pickTypeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [pickTypeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [cell.contentView addSubview:pickTypeButton];
    }
    
    else if (indexPath.row==1)
    {
        cell.textLabel.text = @"Pick an event";
        
        cell.textLabel.font = [UIFont fontWithName:@"Futura" size:17];
        
        cell.textLabel.textColor = [UIColor blackColor];
        
        cell.detailTextLabel.text = @"If post is event related";
        
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        
        cell.detailTextLabel.font = [UIFont fontWithName:@"Futura" size:15];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    else if (indexPath.row==2)
    {
        postTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, self.tableView.frame.size.height-200)];
        
        postTextView.backgroundColor = [UIColor colorWithRed:0.992f green:0.929f blue:0.851f alpha:0.95f];
        
        postTextView.font = [UIFont fontWithName:@"Futura" size:15];
        
        postTextView.contentInset = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
        
        postTextView.delegate = self;
        
        [cell.contentView addSubview:postTextView];
    }
    
    else
    {
        UIButton *saveButton = [[UIButton alloc]initWithFrame:CGRectMake(240, 10, 70, 50 )];
        
        [saveButton setTitle:@"Save" forState:UIControlStateNormal];
        
        saveButton.layer.borderColor = [[CommonClass sharedCommonClass] lightOrangeColor].CGColor;
        
        saveButton.layer.borderWidth = 3.0f;
        
        saveButton.backgroundColor = [UIColor clearColor];
        
        saveButton.titleLabel.font = [UIFont fontWithName:@"Futura" size:17];
        
        [saveButton setTitleColor:[[CommonClass sharedCommonClass] lightOrangeColor] forState:UIControlStateNormal];
        
        [saveButton addTarget:self action:@selector(saveButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.contentView addSubview:saveButton];
        
        UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 90, 50 )];
        
        [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        
        [cancelButton setTitleColor:[[CommonClass sharedCommonClass] lightOrangeColor] forState:UIControlStateNormal];
        
        cancelButton.layer.borderColor = [[CommonClass sharedCommonClass] lightOrangeColor].CGColor;
        
        cancelButton.layer.borderWidth = 3.0f;
        
        cancelButton.backgroundColor = [UIColor clearColor];
        
        cancelButton.titleLabel.font = [UIFont fontWithName:@"Futura" size:17];
        
        [cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.contentView addSubview:cancelButton];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row==1)
    {
        CalendarListVC *listVC = [[CalendarListVC alloc]init];
        
        listVC.fromAdminPost = YES;
        
        listVC.myDelegate = self;
        
        [self presentModalView:listVC];
    }
}

-(void)pickTypeButtonPressed:(id)sender
{
    if (postPickerIsOpen)
    {
        [UIView animateWithDuration:0.3 animations:^{
            
            postPicker.frame = hiddenFrame;
            
            postPicker.hidden = YES;
            
            postPickerIsOpen= NO;
        }];
    }
    
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
            
            postPicker.frame = visibleFrame;
            
            NSLog(@"going to visible view");
            
            postPicker.hidden = NO;
            
            postPickerIsOpen = YES;
        }];
    }
    
    NSInteger row = [postPicker selectedRowInComponent:0];
    
    [pickTypeButton setTitle:postTypes[row] forState:UIControlStateNormal];
}

-(void)saveButtonPressed:(id)sender
{
    NSInteger selectedRow = [postPicker selectedRowInComponent:0];
    
    NSLog(@"selected post type row %d", selectedRow);
    
    NSLog(@"event selected is %@", self.eventSelected);
    
    NSString *postTitle;
    
    NSString *eventID;
    
    if (selectedRow==0 &&self.eventSelected)
    {
        postTitle = [NSString stringWithFormat:@"UPDATE %@", self.eventSelected.title];
    }
    
    else
    {
        postTitle = @"";
    }
    
    if (self.eventSelected)
    {
        eventID = self.eventSelected.eventId;
    }
    else
    {
        eventID = @"";
    }
    
    Post *newPost = [[Post alloc]initWithPostId:@"" andType:selectedRow andTitle:postTitle   andText:postTextView.text andTime:[NSDate date] andUserId:@"" andEventId:eventID];
    
    [[PostManager sharedInstance] addNewPost:newPost withcompletionHandler:^(NSError *error) {
        if (error)
        {
            NSLog(@"error saving new post!");
        }
        else
        {
            NSLog(@"new post saved successfully!");
        }
        
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

-(void)cancelButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark-UIPickerView Delegate & DataSoure

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 3;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return postTypes[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [pickTypeButton setTitle: postTypes[row] forState:UIControlStateNormal];
    
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 54;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 300;
}

#pragma mark- Keyboard Notifications

-(void) registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardWasShown:(NSNotification*)aNotification
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
    
    [self.tableView setFrame:CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y-keyboardFrame.size.height, self.tableView.frame.size.width, self.tableView.frame.size.height)];
    
    [UIView commitAnimations];
}

-(void)keyboardWillHide:(NSNotification*)aNotification
{
    NSLog(@"Keyboard was hidden");
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
    
    [self.tableView setFrame:CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y+keyboardFrame.size.height, self.tableView.frame.size.width, self.tableView.frame.size.height)];
    
    [UIView commitAnimations];
}

#pragma mark-UITextView Delegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark- EventSelectDelegate methods

-(void)eventPassedBackFromEventList:(Event *)event
{
    NSIndexPath *ip = [NSIndexPath indexPathForRow:1 inSection:0];
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:ip];
    
    self.eventSelected = event;
    
    cell.textLabel.text = event.title;
    
    cell.detailTextLabel.text = @"";
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
