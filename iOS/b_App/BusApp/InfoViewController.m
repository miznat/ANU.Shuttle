//
//  InfoViewController.m
//  BusApp
//
//  Created by lion on 3/19/13.
//  Copyright (c) 2013 lion. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"INFO", @"INFO");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Google Analytics
    self.trackedViewName = @"info";
    
    // Do any additional setup after loading the view from its nib.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Demo" ofType:@"html"];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//    UIWebView *webView = [[UIWebView alloc] init];
    [m_webView loadHTMLString:content baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
//    [self.view addSubview:webView];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	// Flurry Analytics
	[Flurry logEvent:@"info"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
