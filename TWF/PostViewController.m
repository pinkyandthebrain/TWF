//
//  PostViewController.m
//  TWF
//  Shows up as a modal view to allow user to create a post
//  Created by Seema Kamath on 9/2/13.
//  Copyright (c) 2013 Y.CORP.YAHOO.COM\seemakam. All rights reserved.
//
#import <MobileCoreServices/MobileCoreServices.h>
#import <QuartzCore/QuartzCore.h>
#import "PostViewController.h"

@interface PostViewController ()

@property (weak, nonatomic) IBOutlet UIButton *yuckButton;
@property (weak, nonatomic) IBOutlet UIButton *yumButton;
@property (nonatomic, strong) UIImage *imageToUse;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

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

- (id) initWithImage:(UIImage *)imageToUse
{
    
    if (self) {
        // Custom initialization
        self.imageForPost = [[UIImageView alloc] initWithImage:imageToUse];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.descriptionTextView.layer.borderWidth = 2.0F;
    self.descriptionTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.imageForPost.layer.borderWidth = 3.0F;
    self.imageForPost.layer.borderColor = [[UIColor grayColor] CGColor];
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    
    if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerSourceTypeCamera]){
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    }else{
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary ];
    }
    imagePicker.allowsEditing = NO;
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void) viewDidAppear:(BOOL)animated
{
    [self.imageForPost initWithImage:self.imageToUse];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextView Delegate
#pragma mark - UIImagePicker Delegate



- (void) imagePickerController: (UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *) info
{
    
    
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    // Handle a still image picked from a photo album
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0)
        == kCFCompareEqualTo) {
        
        self.imageToUse = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
        
        // Do something with imageToUse
        NSLog(@"YAAAY");
        
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}



#pragma mark - Private methods
- (IBAction)postButtonPressed:(id)sender {
    
    //Create a story with image, location, review and post it to Facebook
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)yumButtonPressed:(id)sender {
}

- (IBAction)yuckButtonPressed:(id)sender {
}
@end
