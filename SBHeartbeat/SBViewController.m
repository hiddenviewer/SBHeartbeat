//
//  SBViewController.m
//  SBHeartbeat
//
//  Created by hiddenviewer on 2014. 3. 6..
//  Copyright (c) 2014년 1minute2life. All rights reserved.
//

#import "SBViewController.h"
#import "UIView+SBHeartbeat.h"

@interface SBViewController ()

@end

@implementation SBViewController

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [super viewDidLoad];
    [self addControls];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addControls {
    NSArray *itemArray = [NSArray arrayWithObjects:@"heart", @"eyes", @"star", @"smile", @"cry", @"angry", nil];
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    segmentedControl.frame = CGRectMake(0, 30, self.view.frame.size.width, 50);
    [segmentedControl addTarget:self action:@selector(selectOne:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
    
    UIButton *hideButton = [UIButton buttonWithType:UIButtonTypeSystem];
    hideButton.frame = CGRectMake(0, 30+50+10, self.view.frame.size.width, 50);
    [hideButton setTitle:@"hide" forState:UIControlStateNormal];
    [hideButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hideButton];
}

- (void)selectOne:(UISegmentedControl*)sender {
    [self.view showHeartbeatIndicatorWithType:sender.selectedSegmentIndex];
}

- (void)hide {
    [self.view hideHeartbeatIndicator];
}

@end
