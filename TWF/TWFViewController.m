//
//  TWFViewController.m
//  TWF
//
//  Created by Seema Kamath on 9/1/13.
//  Copyright (c) 2013 Y.CORP.YAHOO.COM\seemakam. All rights reserved.
//

#import "TWFViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface TWFViewController ()

-(void) logoutButtonPressed:(id)sender;

@end

@implementation TWFViewController

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
	// Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleBordered target:self action:@selector(logoutButtonPressed:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods
-(void) logoutButtonPressed:(id)sender{
    [FBSession.activeSession closeAndClearTokenInformation];
}
@end
