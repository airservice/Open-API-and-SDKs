//
//  MainViewController.m
//  PresentDemo
//
//  Copyright © 2016 AirService Digital. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController () <AirServiceKitDelegate>

- (IBAction)presentAirService;

@end

@implementation MainViewController

- (instancetype)init
{
    if ((self = [super init]))
    {
        _airServiceKitViewController = [[AirServiceKitViewController alloc] initWithClientID:@"22c7d3fc" clientSecret:@"aada245b93feb5d8e84dfeb49296da8b" collection:@"airservice-qa-sdk" delegate:self];
        _airServiceKitViewController.appName = @"AirServiceKit Basic Demo";
        _airServiceKitViewController.appEnvironment = ASAppEnvironmentQA; //QA Environment. Remove for production
        _airServiceKitViewController.hostAction = ASHostActionTypeClose;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *presentButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [presentButton setTitle:@"Present AirService" forState:UIControlStateNormal];
    presentButton.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    [presentButton addTarget:self action:@selector(presentAirService) forControlEvents:UIControlEventTouchUpInside];
    [presentButton sizeToFit];
    presentButton.center = self.view.center;
    [self.view addSubview:presentButton];
}

#pragma mark - Actions

- (IBAction)presentAirService
{
    [self presentViewController:self.airServiceKitViewController animated:YES completion:nil];
}

#pragma mark - AirServiceKitDelegate Methods

- (void)AirServiceKitDidTriggerHostAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
