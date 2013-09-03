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


@implementation TWFImagePickerController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIImage* anImage = [UIImage imageNamed:@"camera.png"];
        UITabBarItem* theItem = [[UITabBarItem alloc] initWithTitle:nil image:anImage tag:0];
        
        [self setTabBarItem:theItem];
        self.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerSourceTypeCamera]){
        [self setSourceType:UIImagePickerControllerSourceTypeCamera];
    }else{
        [self setSourceType:UIImagePickerControllerSourceTypePhotoLibrary ];
    }
    self.allowsEditing = NO;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIImagePicker Delegate


- (void) imagePickerController: (UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *) info
{

    
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *imageToUse;
    
    // Handle a still image picked from a photo album
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0)
        == kCFCompareEqualTo) {
        
        imageToUse = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
        
        PostViewController *postVC = [[PostViewController alloc] init];
        [postVC.imageForPost initWithImage:imageToUse];
        postVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:postVC animated:YES completion:nil];
        // Do something with imageToUse
        NSLog(@"YAAAY");
        
    }
    
    [[picker parentViewController] dismissViewControllerAnimated:YES completion:nil];
    
}

@end
