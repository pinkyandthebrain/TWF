//
//  TWFLoginViewController.m
//  TWF
//
//  Created by Seema Kamath on 9/1/13.
//  Copyright (c) 2013 Y.CORP.YAHOO.COM\seemakam. All rights reserved.
//

#import "TWFLoginViewController.h"
#import "AppDelegate.h"

@interface TWFLoginViewController ()


- (IBAction)performLogin:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation TWFLoginViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)performLogin:(id)sender
{
    [self.spinner startAnimating];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate openSession];
    
}
- (void)loginFailed
{
    // User switched back to the app without authorizing. Stay here, but
    // stop the spinner.
    [self.spinner stopAnimating];
}
@end
