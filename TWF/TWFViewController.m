//
//  TWF1ViewController.m
//  TWF
//
//  Created by Seema Kamath on 9/2/13.
//  Copyright (c) 2013 Y.CORP.YAHOO.COM\seemakam. All rights reserved.
//


#import <FacebookSDK/FacebookSDK.h>
#import <MobileCoreServices/MobileCoreServices.h>

#import "TWFViewController.h"
#import "TWFImagePickerController.h"
#import "PostViewController.h"


@interface TWFViewController ()


@property(nonatomic, copy) NSArray *tabViewControllers;
-(void) logoutButtonPressed:(id)sender;
-(void) composeButtonPressed;
@end

@implementation TWFViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       self.title = @"Eat Street";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logoutButtonPressed:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"camera.png"] landscapeImagePhone:[UIImage imageNamed:@"camera.png"] style:UIBarButtonItemStylePlain target:self action:@selector(composeButtonPressed)];

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

-(void) composeButtonPressed{
    //Push the compose view controller here.
    PostViewController *postVC = [[PostViewController alloc] init];
    [self.navigationController pushViewController:postVC animated:NO];
    
}

@end
