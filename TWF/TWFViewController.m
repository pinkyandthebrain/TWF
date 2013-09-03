//
//  TWF1ViewController.m
//  TWF
//
//  Created by Seema Kamath on 9/2/13.
//  Copyright (c) 2013 Y.CORP.YAHOO.COM\seemakam. All rights reserved.
//


#import <FacebookSDK/FacebookSDK.h>
#import "TWFViewController.h"
#import "TWFImagePickerController.h"
#import "TWFStreamViewController.h"


@interface TWFViewController ()


@property(nonatomic, copy) NSArray *tabViewControllers;
-(void) logoutButtonPressed:(id)sender;

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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleBordered target:self action:@selector(logoutButtonPressed:)];
    
    //Allocate the view controllers here
    TWFStreamViewController *twfStreamViewController = [[TWFStreamViewController alloc] init];
    TWFImagePickerController *twfImagePickerController = [[TWFImagePickerController alloc] init];
    
    self.tabViewControllers = [[NSArray alloc] initWithObjects:twfStreamViewController,twfImagePickerController, nil];
    [self setViewControllers:self.tabViewControllers animated:YES];
    

    
    

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
