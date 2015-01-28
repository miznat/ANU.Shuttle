//
//  SecondViewController.m
//  BusApp
//
//  Created by Tanzim on 3/19/13.
//  Copyright (c) 2013 Tanzim. All rights reserved.
//

#import "SecondViewController.h"
#import "AppDelegate.h"
#import "RouteInfoManager.h"
#import "BusDBManager.h"
#import "GAI.h"
#import "ECSlidingViewController.h"


@interface SecondViewController ()

@property (weak) IBOutlet UIButton *menuButton;

@end

@implementation SecondViewController

@synthesize m_pArrayTimes;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"UniStops", @"UniStops");
    }
    return self;
}

- (void)viewDidLoad
{
    
    [self setNeedsStatusBarAppearanceUpdate];
    
     [self.menuButton addTarget:self action:@selector(menuButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addGestureRecognizer:[self slidingViewController].panGesture];
    
    m_fShowDetail = NO;
    [m_detailTableView setTag:2];
    [m_OrgTableView setTag:1];
    [m_detailView setFrame:CGRectMake(1024, 0, 320, 480)];
    m_nSelectedIdx = 0;
    [self.view addSubview:m_detailView];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	// Flurry Analytics
	[Flurry logEvent:@"UniStops"];
    // Google Analytics
    self.trackedViewName = @"UniStops";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    int nNumber = 1;
    
    nNumber = [[[appDelegate m_pBusDBManager] m_arrayTextList] count];
    if(tableView.tag == 1)
        return nNumber;
    if(tableView.tag == 2)
        return [m_pArrayTimes count] + 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    UIColor* textcolor = [UIColor colorWithRed:172/255.0 green:141/255.0f blue:193/255.0f alpha:1.0f];
    UIColor* colorLabel = [UIColor colorWithRed:232/255.0f green:45/255.0f blue:92/255.0f alpha:1];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
        
        
        UILabel *dataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 8.0, 320.0, 30.0)];
        [dataLabel setTag:1];
        [dataLabel setBackgroundColor:[UIColor clearColor]]; // transparent label background
        //            [dataLabel setFont:[UIFont boldSystemFontOfSize:25.0]];
        if(tableView.tag == 2 && indexPath.row == 0)
        {
            [dataLabel setTextColor:colorLabel];
            [dataLabel setFont:[UIFont fontWithName:@"LithosPro-Black" size:20]];
            cell.backgroundColor = [UIColor blackColor];
        }
        else
        {
            [dataLabel setTextColor:textcolor];
            [dataLabel setFont:[UIFont fontWithName:@"LithosPro-Black" size:15]];
            cell.backgroundColor = [UIColor blackColor];
            
        }
        [dataLabel setTextAlignment:NSTextAlignmentCenter];
        // custom views should be added as subviews of the cell's contentView:
        [cell.contentView addSubview:dataLabel];
        
    }
    //    Customer *customer = [self.customers objectAtIndex:[indexPath row]];
    //
    if(tableView.tag == 1){
        TextInfo* info = (TextInfo*)[[[appDelegate m_pBusDBManager] m_arrayTextList] objectAtIndex: [indexPath row]];
        [(UILabel *)[cell.contentView viewWithTag:1] setText:info.szText];
    }
    else if(tableView.tag == 2)
    {
        int nDisHour;
        
        if(indexPath.row == 0)
        {
            if([m_pArrayTimes count] > 0)
            {
                TextInfo* info = (TextInfo*)[[[appDelegate m_pBusDBManager] m_arrayTextList] objectAtIndex:m_nSelectedIdx];
                [(UILabel *)[cell.contentView viewWithTag:1] setText:info.szText];
            }
        }
        else{
            TimeListInfo* info = (TimeListInfo*)[m_pArrayTimes objectAtIndex:[indexPath row] - 1];
            if(info.nHour > 12)
                nDisHour = info.nHour - 12;
            else
                nDisHour = info.nHour;
            NSString* szTime = [NSString stringWithFormat:@"%d\t :\t%02d", nDisHour, info.nMin];
            [(UILabel *)[cell.contentView viewWithTag:1] setText:szTime];
        }
    }
    
    
    return cell;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView.tag != 1)
        return;
	
	AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
	
	// Flurry Analytics
	TextInfo* info = (TextInfo*)[[[appDelegate m_pBusDBManager] m_arrayTextList] objectAtIndex: [indexPath row]];
	[Flurry logEvent:[NSString stringWithFormat:@"Tap on %@ cell", info.szText]];

	// Navigation logic -- create and push a new view controller
    int nID = indexPath.row;
    m_nSelectedIdx = nID;
    [self readData:nID + 1];
    [self showDetailView];
    
    //    DetailViewController* viewCotroller = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    //    [viewCotroller SetParents:self];
    //    [viewCotroller SetTitleText:infoRoute.routeName];
    //    [self presentModalViewController:viewCotroller animated:UIModalTransitionStyleFlipHorizontal];
    
    //    [viewCotroller release];
	
}

-(void)readData: (int)nID
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if(m_pArrayTimes != nil)
        [m_pArrayTimes removeAllObjects];
    m_pArrayTimes = [[appDelegate m_pBusDBManager] GetTimeListByText:nID];
    
}

-(void)animationView:(UIView*)view initFrame:(CGRect)sFrame endFrame:(CGRect)eFrame initAlpha:(float)sAlpha endAlpha:(float)eAlpha  animationtime:(float)rTime
{
	[view setFrame:sFrame];
	[view setAlpha:sAlpha];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:rTime];
	[view setFrame:eFrame];
	[view setAlpha:eAlpha];
	[UIView commitAnimations];
}

-(void)showDetailView
{
    CGRect xStartFrame, xEndFrame;
    CGRect xWinSize = [[UIScreen mainScreen] bounds];
    if(m_fShowDetail == YES)
    {
        xStartFrame = CGRectMake(0, 0, xWinSize.size.width, xWinSize.size.height);
        xEndFrame = CGRectMake(xWinSize.size.width, 0, xWinSize.size.width, xWinSize.size.height);
        m_fShowDetail = NO;
        
    }
    else
    {
        xEndFrame = CGRectMake(0, 0, xWinSize.size.width, xWinSize.size.height);
        xStartFrame = CGRectMake(xWinSize.size.width, 0, xWinSize.size.width, xWinSize.size.height);
        m_fShowDetail = YES;
    }
    
    [self animationView:m_detailView initFrame:xStartFrame endFrame:xEndFrame initAlpha:1.0 endAlpha:1.0 animationtime:0.5];
    [m_OrgTableView reloadData];
    [m_detailTableView reloadData];
    
    
}


-(IBAction)onBack:(id)sender
{
    [self showDetailView];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

  

@end