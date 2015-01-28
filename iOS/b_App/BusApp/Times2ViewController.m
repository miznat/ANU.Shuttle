//
//  Times2ViewController.m
//  BusApp
//
//  Created by lion on 3/19/13.
//  Copyright (c) 2013 lion. All rights reserved.
//

#import "Times2ViewController.h"
#import "AppDelegate.h"
#import "SecondViewController.h"
#import "BusDBManager.h"
#import "GAI.h"

@interface Times2ViewController ()

@end

@implementation Times2ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = NSLocalizedString(@"Fenner Bus", @"Fenner Bus");
    }
    
      return self;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view from its nib.
    m_nSelectedIdx = 0;
    UIColor* NormalColor = [UIColor colorWithRed:169/255.0f green:169/255.0f blue:169/255.0f alpha:1];
    UIColor* selectedColor = [UIColor colorWithRed:0.0f green:1.0f blue:0.0f alpha:1];
    
    [lbToUni setBackgroundColor:[UIColor blackColor]]; // transparent label background
    [lbToUni setFont:[UIFont fontWithName:@"LithosPro-Black" size:18]];
    //            [routeLabel setFont:[UIFont boldSystemFontOfSize:25.0]];
    [lbToUni setTextColor:selectedColor];
    [lbToUni setTextAlignment:NSTextAlignmentCenter];
    [lbToUni setText:@"To Uni"];
    
    [lbTOFenner setBackgroundColor:[UIColor blackColor]]; // transparent label background
    [lbTOFenner setFont:[UIFont fontWithName:@"LithosPro-Black" size:18]];
    //            [routeLabel setFont:[UIFont boldSystemFontOfSize:25.0]];
    [lbTOFenner setTextColor:NormalColor];
    [lbTOFenner setTextAlignment:NSTextAlignmentCenter];
    [lbTOFenner setText:@"To Fenner"];
   
    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(selectorUpdate)
                                   userInfo:nil
                                    repeats:YES];
    /**/
    [self GetCurrentTime];
    [self GetShowData];
    [TimetableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	// Flurry Analytics
	[Flurry logEvent:@"FennerBus"];
    
    
    // Google Analytics
    
    
    id<GAITracker> googleTracker = [[GAI sharedInstance] trackerWithTrackingId:@"UA-39220154-2"];
    [googleTracker trackView:@"FennerBus"];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self GetCurrentTime];
    [self GetShowData];
    [TimetableView reloadData];
}

-(void)GetShowData
{
    if(m_arrayShow)
    {
        [m_arrayShow removeAllObjects];
        [m_arrayShow release];
    }
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if(m_nSelectedIdx == 0)
        m_arrayShow = [[appDelegate m_pBusDBManager] GetReminYList:m_nCurrentHour minute:m_nCurrentMin];
    else
        m_arrayShow = [[appDelegate m_pBusDBManager] GetReminXList:m_nCurrentHour minute:m_nCurrentMin];
}

-(void)GetCurrentTime
{
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[[NSCalendar alloc]
                              initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSDateComponents *components =
    [gregorian components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:today];
    
    m_nCurrentHour = [components hour];
    m_nCurrentMin  = [components minute];
}


- (void) selectorUpdate{
    
    [self GetCurrentTime];

    if(m_nCurrentMin != m_nPrevMin)
    {
        [self GetShowData];
        [TimetableView reloadData];
        m_nPrevHour = m_nCurrentHour;
        m_nPrevMin = m_nCurrentMin;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    
    [m_arrayShow removeAllObjects];
    [m_arrayShow release];
    [super dealloc];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
     
    if([m_arrayShow count] > 0)
        return [m_arrayShow count];
    else
        return 1;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"%d-%d", indexPath.section, indexPath.row];
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    UIColor* timecolor = [UIColor colorWithRed:8/255.0 green:174/255.0f blue:243/255.0f alpha:1.0f];
    UIColor* firsttimecolor = [UIColor colorWithRed:232/255.0 green:45/255.0f blue:92/255.0f alpha:1.0f];
    
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
        [cell setBackgroundColor:[UIColor blackColor]];
        UILabel *dataLabel;
        UIColor* timecolor = [UIColor colorWithRed:8/255.0 green:174/255.0f blue:243/255.0f alpha:1.0f];
        if(indexPath.row == 0)
        {
            dataLabel= [[UILabel alloc] initWithFrame:CGRectMake(20.0, 8.0, 280.0, 70.0)];
            [dataLabel setBackgroundColor:[UIColor blackColor]]; // transparent label background
            [dataLabel setFont:[UIFont fontWithName:@"LithosPro-Black" size:25]];
            [dataLabel setTextColor:firsttimecolor];
        }
        else
        {
             dataLabel= [[UILabel alloc] initWithFrame:CGRectMake(20.0, 8.0, 280.0, 30.0)];
            [dataLabel setBackgroundColor:[UIColor blackColor]]; // transparent label background
            [dataLabel setFont:[UIFont fontWithName:@"LithosPro-Black" size:15]];
            [dataLabel setTextColor:timecolor];

        }
       
        [dataLabel setTag:1];
        [dataLabel setTextAlignment:NSTextAlignmentCenter];
        // custom views should be added as subviews of the cell's contentView:
        [cell.contentView addSubview:dataLabel];
        [dataLabel release];
    }
    if([m_arrayShow count] > 0)
    {
        StopTime* time;
        time = [m_arrayShow objectAtIndex:indexPath.row];
        int nHour = time.nHour;
        int nMin = time.nMin;
        if(nHour > 12)
            nHour = nHour - 12;
        NSString* szShowString;
        szShowString = [NSString stringWithFormat:@"%d:%02d", nHour, nMin];
        
        [(UILabel *)[cell.contentView viewWithTag:1] setText:szShowString];

    }
    else
    {
        NSString* szShowString;
        if(m_nSelectedIdx == 0)
        {
            szShowString = @"8:00"; //Check again Tomorrow
        }
        else
            szShowString = @"8:10";  // Check again Tomorrow
        
        [(UILabel *)[cell.contentView viewWithTag:1] setText:szShowString];
        
    }
   
    
      
    return cell;
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat rHeight = 44.0f;
    if(indexPath.row == 0)
        return 80.0f;
    else
        return rHeight;
    return rHeight;
}
-(IBAction)changeSelectedIdx:(id)sender
{

    UIColor* NormalColor = [UIColor colorWithRed:169/255.0f green:169/255.0f blue:169/255.0f alpha:1];
    UIColor* selectedColor = [UIColor colorWithRed:0.0f green:1.0f blue:0.0f alpha:1];
    if(sender == btnToUni)
    {
        m_nSelectedIdx = 0;
        [btnToUni setSelected:YES];
        [btnToFenner setSelected:NO];
        [lbTOFenner setTextColor:NormalColor];
        [lbToUni setTextColor:selectedColor];
    }
    else
    {
        m_nSelectedIdx = 1;
        [btnToFenner setSelected:YES];
        [btnToUni setSelected:NO];
        [lbTOFenner setTextColor:selectedColor];
        [lbToUni setTextColor:NormalColor];

    }
    [self GetCurrentTime];
    [self GetShowData];
    [TimetableView reloadData];
//    [self tableView:up heightForHeaderInSection:<#(NSInteger)#>]

}


@end
