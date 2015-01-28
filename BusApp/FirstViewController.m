//
//  FirstViewController.m
//  BusApp
//
//  Created by Tanzim on 3/19/13.
//  Copyright (c) 2013 Tanzim. All rights reserved.
//

#import "FirstViewController.h"
#import "AppDelegate.h"
#import "RouteInfoManager.h"
#import "BusDBManager.h"
#import "GAI.h"
#import "ECSlidingViewController.h"


@interface FirstViewController ()

@property (weak) IBOutlet UIButton *menuButton;

@end

@implementation TimeTable

@synthesize szRouteName, nRouteHour,nRouteMin;

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"UniSafe", @"UniSafe");
        
        
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.menuButton addTarget:self action:@selector(menuButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addGestureRecognizer:[self slidingViewController].panGesture];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    
//    m_arrayTime = [[NSMutableArray alloc] init];
	// Do any additional setup after loading the view, typically from a nib.
    [self GetCurrentTime];
    [self GetDisplayData];
    m_nPreveHour = m_nCurrentHour;
    m_nPreveMin = m_nCurrentMin;
    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(selectorUpdate)
                                   userInfo:nil
                                    repeats:YES];
    
    
    
}



- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	// Flurry Analytics
	[Flurry logEvent:@"Uni Safe Bus"];
    
    
    // Google Analytics
    self.trackedViewName = @"First view";
    
    id<GAITracker> googleTracker = [[GAI sharedInstance] trackerWithTrackingId:@"UA-39220154-2"];
    [googleTracker trackView:@"Uni Safe Bus"];
    
}

-(void)viewDidAppear:(BOOL)animated
{
   
    [self GetCurrentTime];
    [self GetDisplayData];
    [timeTableView reloadData];

    
//    if([m_arrayTime count] > 0)
//    {
//        TimeTable* timeInfo = [m_arrayTime objectAtIndex:0];
//        NSString* szTime = [NSString stringWithFormat:@"%d\t:\t%02d", timeInfo.nRouteHour, timeInfo.nRouteMin];
//        NSString* szRouteName = timeInfo.szRouteName;
//        [labelRoute setText:szRouteName];
//        [labelTime setText:szTime];
//    
//        [timeTableView reloadData];
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)GetCurrentTime
{
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc]
                              initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components =
    [gregorian components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:today];
    
    m_nCurrentHour = [components hour];
    m_nCurrentMin  = [components minute];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [m_arrayTime count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"%d-%d", indexPath.section, indexPath.row];
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSLog(@"RowIndex ==== %d", [indexPath row]);
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
//        cell = [[UITableVIewCell alloc] init]
        
          // create a custom label:                                        x    y   width  height
         UIColor* textcolor = [UIColor colorWithRed:172/255.0 green:141/255.0f blue:193/255.0f alpha:1.0f];
         UIColor* timecolor = [UIColor colorWithRed:8/255.0 green:174/255.0f blue:243/255.0f alpha:1.0f];
         cell.backgroundColor = [UIColor blackColor];
        
        if(indexPath.row == 0)
        {
            UIColor* fistColor = [UIColor colorWithRed:232/255.0f green:45/255.0f blue:92/255.0f alpha:1];
            UIColor* firsttimeColor = [UIColor colorWithRed:8/255.0f green:174/255.0f blue:243/255.0f alpha:1];
            UILabel *routeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.0, 320.0, 45)];
            [routeLabel setTag:1];
            [routeLabel setBackgroundColor:[UIColor blackColor]]; // transparent label background
            [routeLabel setFont:[UIFont fontWithName:@"LithosPro-Black" size:25]];
            //            [routeLabel setFont:[UIFont boldSystemFontOfSize:25.0]];
            [routeLabel setTextColor:firsttimeColor];
            [routeLabel setTextAlignment:NSTextAlignmentCenter];
            // custom views should be added as subviews of the cell's contentView:
            [cell.contentView addSubview:routeLabel];
            
            
            UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 45.0, 320, 45)];
            [timeLabel setTag:2];
            [timeLabel setBackgroundColor:[UIColor blackColor]]; // transparent label background
            [timeLabel setFont:[UIFont fontWithName:@"LithosPro-Black" size:20]];
            //            [timeLabel setFont:[UIFont boldSystemFontOfSize:25.0]];
            [timeLabel setTextColor:fistColor];
            [timeLabel setTextAlignment:NSTextAlignmentCenter];
            // custom views should be added as subviews of the cell's contentView:
            [cell.contentView addSubview:timeLabel];
        }
        else
        {
            UILabel *routeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10.0, 80.0, 25.0)];
            [routeLabel setTag:1];
            [routeLabel setBackgroundColor:[UIColor blackColor]]; // transparent label background
            [routeLabel setFont:[UIFont fontWithName:@"LithosPro-Black" size:15]];
//            [routeLabel setFont:[UIFont boldSystemFontOfSize:25.0]];
            [routeLabel setTextColor:timecolor];
            [routeLabel setTextAlignment:NSTextAlignmentLeft];
            // custom views should be added as subviews of the cell's contentView:
            [cell.contentView addSubview:routeLabel];
            
           
            UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10.0, 240.0, 25.0)];
            [timeLabel setTag:2];
            [timeLabel setBackgroundColor:[UIColor blackColor]]; // transparent label background
            [timeLabel setFont:[UIFont fontWithName:@"LithosPro-Black" size:15]];
//            [timeLabel setFont:[UIFont boldSystemFontOfSize:25.0]];
            [timeLabel setTextColor:textcolor];
            [timeLabel setTextAlignment:NSTextAlignmentLeft];
            // custom views should be added as subviews of the cell's contentView:
            [cell.contentView addSubview:timeLabel];
        }
        
      
            
    }
    
    if([m_arrayTime count] > 0){
        TimeListInfo* info = [m_arrayTime objectAtIndex:[indexPath row]];
        int nDisHour = info.nHour;
        if(nDisHour > 12)
            nDisHour = nDisHour - 12;
    
        NSString* szDispTime = [NSString stringWithFormat:@"%d:%02d", nDisHour, info.nMin];
        NSString* szText = [[appDelegate m_pBusDBManager] GetTextFromID:info.nID];
        [(UILabel *)[cell.contentView viewWithTag:1] setText:szDispTime];
        
        [(UILabel *)[cell.contentView viewWithTag:2] setText:szText];
    }

    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0)
        return 90;
    return 44;
}

-(void)GetDisplayData
{
    if(m_arrayTime != nil)
    {
        [m_arrayTime removeAllObjects];
    }
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    m_arrayTime = [[appDelegate m_pBusDBManager] GetReminTimeList:m_nCurrentHour minute:m_nCurrentMin];

    
}


- (void) selectorUpdate{
    
    [self GetCurrentTime];

    if(m_nCurrentMin != m_nPreveMin)
    {
        [self GetDisplayData];
        [timeTableView reloadData];
        m_nPreveHour = m_nCurrentHour;
        m_nPreveMin = m_nCurrentMin;
    }
}

-(void)dealloc
{
    [m_arrayTime removeAllObjects];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
