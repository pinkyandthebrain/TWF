//
//  TWFImagePickerController.m
//  TWF
//
//  Created by Seema Kamath on 9/2/13.
//  Copyright (c) 2013 Y.CORP.YAHOO.COM\seemakam. All rights reserved.
//

#import "TWFImagePickerController.h"

@interface TWFImagePickerController ()

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

@end
