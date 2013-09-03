//
//  PostViewController.m
//  TWF
//  Shows up as a modal view to allow user to create a post
//  Created by Seema Kamath on 9/2/13.
//  Copyright (c) 2013 Y.CORP.YAHOO.COM\seemakam. All rights reserved.
//

#import "PostViewController.h"

@interface PostViewController ()

@property (weak, nonatomic) IBOutlet UIButton *yuckButton;
@property (weak, nonatomic) IBOutlet UIButton *yumButton;

- (IBAction)postButtonPressed:(id)sender;
- (IBAction)yumButtonPressed:(id)sender;
- (IBAction)yuckButtonPressed:(id)sender;


@end

@implementation PostViewController

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

#pragma mark - UITextView Delegate



#pragma mark - Private methods
- (IBAction)postButtonPressed:(id)sender {
    
    //Create a story with image, location, review and post it to Facebook
    
    
}


- (IBAction)yumButtonPressed:(id)sender {
}

- (IBAction)yuckButtonPressed:(id)sender {
}
@end
