//
//  NewEventViewController.m
//  StepUp
//
//  Created by Sunayna Jain on 2/8/14.
//
//

#import "NewEventViewController.h"
#import "CalendarCell.h"
#import "EventDetailsCell.h"
#import "CalendarListViewController.h"
#import "CommonClass.h"
#import "EventManager.h"

@interface NewEventViewController ()

@property (strong, nonatomic) UIButton *yesButton;
@property (strong, nonatomic) UIButton *maybeButton;
@property (strong, nonatomic) UIButton *noButton;

@end

@implementation NewEventViewController

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
        
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self addingRSVPLabel];
    
    [self addingYesButton];
    
    [self addingMaybeButton];
    
     [self addingNoButton];
    
        	// Do any additional setup after loading the view.
}

-(void)addingRSVPLabel{
    
    UILabel *rsvpLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 520, 60, 40)];
    rsvpLabel.text = @"RSVP";
    rsvpLabel.font = [UIFont fontWithName:@"Futura" size:17];
    [self.view addSubview:rsvpLabel];
    
}

-(void)addingYesButton{
    
    UIColor *orange = [[CommonClass sharedCommonClass] darkOrangeColor];

    self.yesButton = [[UIButton alloc]initWithFrame:CGRectMake(90, 520, 50, 40)];
    self.yesButton.layer.borderColor = [[CommonClass sharedCommonClass] darkOrangeColor].CGColor;
    self.yesButton.layer.borderWidth = 3.0f;
    self.yesButton.titleLabel.font = [UIFont fontWithName:@"Futura" size:17];
    [self.yesButton setTitle:@"yes" forState:UIControlStateNormal];
    [self.yesButton setTitleColor:orange forState:UIControlStateNormal];
    [self.yesButton addTarget:self action:@selector(yesButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.yesButton];
    
}

-(void)addingMaybeButton{
    
    UIColor *orange = [[CommonClass sharedCommonClass] darkOrangeColor];

    
    self.maybeButton = [[UIButton alloc]initWithFrame:CGRectMake(160, 520, 60, 40)];
    self.maybeButton.layer.borderColor = [[CommonClass sharedCommonClass] darkOrangeColor].CGColor;
    self.maybeButton.layer.borderWidth = 3.0f;
    self.maybeButton.titleLabel.font = [UIFont fontWithName:@"Futura" size:17];
    [self.maybeButton setTitle:@"maybe" forState:UIControlStateNormal];
    [self.maybeButton setTitleColor:orange forState:UIControlStateNormal];
    [self.maybeButton addTarget:self action:@selector(maybeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.maybeButton];
}


-(void)addingNoButton{
    
    UIColor *orange = [[CommonClass sharedCommonClass] darkOrangeColor];

    self.noButton = [[UIButton alloc]initWithFrame:CGRectMake(240, 520, 50, 40)];
    self.noButton.layer.borderColor = [[CommonClass sharedCommonClass] darkOrangeColor].CGColor;
    self.noButton.layer.borderWidth = 3.0f;
    self.noButton.titleLabel.font = [UIFont fontWithName:@"Futura" size:17];
    [self.noButton setTitle:@"no" forState:UIControlStateNormal];
    [self.noButton setTitleColor:orange forState:UIControlStateNormal];
    [self.noButton addTarget:self action:@selector(noButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.noButton];
    

}
#pragma mark-TableView DataSource methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0){
        return 66;
    } else {
        return self.view.frame.size.height-66-120-60;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 120;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 100)];
    view.backgroundColor = [[CommonClass sharedCommonClass] lightOrangeColor];
    
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


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger index = [self.eventIndex integerValue];
    Event* this_event = [[[[EventManager sharedInstance] populatedEvents] allValues] objectAtIndex:index];
    NSString* time_str = [this_event time];

    if (indexPath.row==0){
       CalendarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CalendarCell"];
        
            if (!cell) {
                cell = [[[UINib nibWithNibName:@"CalendarCell" bundle:[NSBundle mainBundle]] instantiateWithOwner:self options:nil] objectAtIndex:0];
            }
        NSRange my_range;
        my_range.location = 5;
        my_range.length = 5 ;
        NSString* short_str = @"";
        
        if ([time_str length] > 10) {
            short_str = [time_str substringWithRange:my_range];
        }
        
        cell.dateLabel.text = short_str;

        ((CalendarCell*)cell).headerLabel.text = ([this_event title] != nil) ? [this_event title] : @"Untitled";
        ((CalendarCell*)cell).dateLabel.text = short_str;
        ((CalendarCell*)cell).colorLabel.text = @"";
        ((CalendarCell*)cell).headerLabel.font = [UIFont fontWithName:@"Futura" size:18];
        ((CalendarCell*)cell).dateLabel.font = [UIFont fontWithName:@"Futura" size:18];
        
        return cell;
        }
    
    else {
    
    static NSString *cellIdentifier = @"EventDetails";
    
    EventDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
        if(!cell){
        cell = [[[UINib nibWithNibName:@"EventDetailsCell" bundle:[NSBundle mainBundle]] instantiateWithOwner:self options:nil] objectAtIndex:0];
        }
        cell.timeLabel.text = @"6 PM";
        cell.timeLabel.font = [UIFont fontWithName:@"Futura" size:17];
        cell.timeIcon.image = [UIImage imageNamed:@"venueBlack.png"];
        cell.venueIcon.image = [UIImage imageNamed:@"clockBlack.png"];
//        NSString *address =
//        NSString *firstLine = @"Macy's Hearld Square";
//        NSString *secondLine = @"151 W 34th Street";
//        NSString *thirdLine = @"New York, 10010";
        NSString *combined = [NSString stringWithFormat:@"%@\n", [this_event location]];
        cell.venueTextview.text = combined;
        cell.venueTextview.backgroundColor = [UIColor clearColor];
        cell.venueTextview.font = [UIFont fontWithName:@"Futura" size:17];
        cell.eventDetailsTextView.text = [this_event description];
        cell.eventDetailsTextView.font = [UIFont fontWithName:@"Futura" size:17];
        cell.eventDetailsTextView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor colorWithRed:248.0/255.0 green:165.0/255.0 blue:66.0/255.0 alpha:0.2];
//        cell.rsvpLabel.text = @"RSVP";
//        cell.rsvpLabel.font = [UIFont fontWithName:@"Futura" size:17];
//        cell.yesButton.layer.borderColor = [UIColor blueColor].CGColor;
//        cell.yesButton.layer.borderWidth = 3.0f;
//        cell.yesButton.titleLabel.font = [UIFont fontWithName:@"Futura" size:17];
//        [cell.yesButton addTarget:self action:@selector(yesButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//        cell.maybeButton.layer.borderColor = [UIColor blueColor].CGColor;
//        cell.maybeButton.layer.borderWidth = 3.0f;
//        cell.maybeButton.titleLabel.font = [UIFont fontWithName:@"Futura" size:17];
//        [cell.maybeButton addTarget:self action:@selector(maybeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//        cell.noButton.layer.borderColor = [UIColor blueColor].CGColor;
//        cell.noButton.layer.borderWidth = 3.0f;
//        [cell.noButton addTarget:self action:@selector(noButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//        cell.noButton.titleLabel.font = [UIFont fontWithName:@"Futura" size:17];
        
        return cell;
    }
    
}

-(void)yesButtonPressed:(UIButton*)yesButton{
    
    UIColor *orange = [[CommonClass sharedCommonClass] darkOrangeColor];
    
    self.yesButton.backgroundColor = [[CommonClass sharedCommonClass] darkOrangeColor];
    
    [self.yesButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.maybeButton.backgroundColor = [UIColor whiteColor];
    
    [self.noButton setTitleColor:orange forState:UIControlStateNormal];
    
    [self.maybeButton setTitleColor:orange forState:UIControlStateNormal];

    self.noButton.backgroundColor = [UIColor whiteColor];
}

-(void)maybeButtonPressed:(UIButton*)maybeButton{
    
    UIColor *orange = [[CommonClass sharedCommonClass] darkOrangeColor];
    
    self.maybeButton.backgroundColor = orange;
    
    [self.maybeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.noButton.backgroundColor = [UIColor whiteColor];
    
    [self.yesButton setTitleColor:orange forState:UIControlStateNormal];

    [self.noButton setTitleColor:orange forState:UIControlStateNormal];

    
    self.yesButton.backgroundColor = [UIColor whiteColor];
}

-(void)noButtonPressed:(UIButton*)noButton{
    
    UIColor *orange = [[CommonClass sharedCommonClass] darkOrangeColor];
    
    noButton.backgroundColor = [[CommonClass sharedCommonClass] darkOrangeColor];
    
    self.yesButton.backgroundColor = [UIColor whiteColor];
    
    [self.yesButton setTitleColor:orange forState:UIControlStateNormal];
    
    self.maybeButton.backgroundColor = [UIColor whiteColor];
    
    [self.maybeButton setTitleColor:orange forState:UIControlStateNormal];
    
    [self.noButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
