//
//  TWFImagePickerController.m
//  TWF
//  Allow user to either take a photo or select from album. Only 1 image can be selected at a time
//  Created by Seema Kamath on 9/2/13.
//  Copyright (c) 2013 Y.CORP.YAHOO.COM\seemakam. All rights reserved.
//
#import <MobileCoreServices/MobileCoreServices.h>

#import "TWFImagePickerController.h"
#import "PostViewController.h"

@interface TWFImagePickerController ()

@property (nonatomic, strong)  UIImage *imageToUse;

@end

@implementation TWFImagePickerController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIImage* anImage = [UIImage imageNamed:@"camera.png"];
        UITabBarItem* theItem = [[UITabBarItem alloc] initWithTitle:nil image:anImage tag:0];
        
        [self setTabBarItem:theItem];

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

- (void) viewDidAppear:(BOOL)animated{
    NSLog(@"test");
    PostViewController *postVC = [[PostViewController alloc] initWithImage:self.imageToUse];
    postVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:postVC animated:YES completion:nil];
}

@end
