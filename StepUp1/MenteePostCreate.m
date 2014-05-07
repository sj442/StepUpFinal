//
//  MenteePostCreate.m
//  StepUp1
//
//  Created by Sunayna Jain on 5/7/14.
//  Copyright (c) 2014 LittleAuk. All rights reserved.
//

#import "MenteePostCreate.h"
#import "CommonClass.h"

@interface MenteePostCreate ()
{
    UIView *headerView;
}

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation MenteePostCreate

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
    
    // Do any additional setup after loading the view.
}

#pragma mark-UITableView DataSource & Delegate methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==1)
    {
        return 70;
    }
    
    else if (indexPath.row==2)
    {
        return 70;
    }
    else
    {
        return tableView.frame.size.height-140;
    }
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if (indexPath.row==0)
        {
            
        }
    
    else if (indexPath.row==1)
    {
        cell.textLabel.text = @"post as anonymous";
        
        cell.textLabel.textColor = [UIColor lightGrayColor];
        
        UISwitch *anonymousSwitch = [[UISwitch alloc]init];
        
        [anonymousSwitch setSelected:NO];
        
        cell.accessoryView = anonymousSwitch;
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

-(void)cancelButtonPressed:(id)sender
{
    
}

-(void)saveButtonPressed:(id)sender
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
