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
#import <FacebookSDK/FacebookSDK.h>
#import "TWFProtocols.h"

@interface PostViewController ()

@property (weak, nonatomic) IBOutlet UIButton *yuckButton;
@property (weak, nonatomic) IBOutlet UIButton *yumButton;
@property (nonatomic, strong) UIImage *imageToUse;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UIScrollView *postScrollView;

- (IBAction)postButtonPressed;
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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Post" style:UIBarButtonItemStylePlain target:self action:@selector(postButtonPressed)];
    
    self.descriptionTextView.delegate = self;
    
    self.descriptionTextView.layer.borderWidth = 0.5F;
    self.descriptionTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    //self.imageForPost.layer.borderWidth = 0.5F;
    //self.imageForPost.layer.borderColor = [[UIColor grayColor] CGColor];
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
    // [self.imageForPost setBounds:CGRectMake(self.imageForPost.bounds.origin.x,self.imageForPost.bounds.origin.y, self.imageToUse.size.width, self.imageToUse.size.width)];
    [self.imageForPost initWithImage:self.imageToUse];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextView Delegate

- (void) textViewDidBeginEditing:(UITextView *)textView
{
    //Scroll to show the text box in view
    CGPoint pt;
    CGRect rc = [self.descriptionTextView bounds];
    rc = [self.descriptionTextView convertRect:rc toView:self.postScrollView];
    pt = rc.origin;
    pt.x = 0;
    pt.y -= 60;
    [self.postScrollView setContentOffset:pt animated:YES];
    
    
}


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


- (id<TWFFood>)mealObjectForMeal:(NSString*)meal
{
    // This URL is specific to this sample, and can be used to
    // create arbitrary OG objects for this app; your OG objects
    // will have URLs hosted by your server.
    NSString *format =
    @"https://floating-inlet-6797.herokuapp.com/index.php?"
    @"fb:app_id=596713447033481&og:type=%@&"
    @"og:title=%@&og:description=%%22%@%%22&"
    @"og:image=https://s-static.ak.fbcdn.net/images/devsite/attachment_blank.png&"
    @"body=%@";
    
    // We create an FBGraphObject object, but we can treat it as
    // an SCOGMeal with typed properties, etc. See <FacebookSDK/FBGraphObject.h>
    // for more details.
    id<TWFFood> result = (id<TWFFood>)[FBGraphObject graphObject];
    
    // Give it a URL that will echo back the name of the meal as its title,
    // description, and body.
    result.url = [NSString stringWithFormat:format,
                  @"twithfriends:food", meal, meal, meal];
    
    return result;
}

- (void)postPhotoThenOpenGraphAction
{
    FBRequestConnection *connection = [[FBRequestConnection alloc] init];
    
    // First request uploads the photo.
    FBRequest *request1 = [FBRequest
                           requestForUploadPhoto:self.imageToUse];
    [connection addRequest:request1
         completionHandler:
     ^(FBRequestConnection *connection, id result, NSError *error) {
         if (!error) {
         }
     }
            batchEntryName:@"photopost"
     ];
    
    // Second request retrieves photo information for just-created
    // photo so we can grab its source.
    FBRequest *request2 = [FBRequest
                           requestForGraphPath:@"{result=photopost:$.id}"];
    [connection addRequest:request2
         completionHandler:
     ^(FBRequestConnection *connection, id result, NSError *error) {
         if (!error &&
             result) {
             NSString *source = [result objectForKey:@"source"];
             [self postOpenGraphActionWithPhotoURL:source];
         }
     }
     ];
    
    [connection start];
}

- (void)postOpenGraphActionWithPhotoURL:(NSString*)photoURL
{
    // First create the Open Graph meal object for the meal we ate.
    id<TWFFood> mealObject = [self mealObjectForMeal:@"Pizza"];
    
    // Now create an Open Graph eat action with the meal, our location,
    // and the people we were with.
    id<TWFEatFoodAction> action =
    (id<TWFEatFoodAction>)[FBGraphObject graphObject];
    action.food = mealObject;
//    if (self.selectedPlace) {
//        action.place = self.selectedPlace;
//    }
//    if (self.selectedFriends.count > 0) {
//        action.tags = self.selectedFriends;
//    }
    if (photoURL) {
        NSMutableDictionary *image = [[NSMutableDictionary alloc] init];
        [image setObject:photoURL forKey:@"url"];
        
        NSMutableArray *images = [[NSMutableArray alloc] init];
        [images addObject:image];
        
        action.image = images;
    }
    
    // Create the request and post the action to the
    // "me/<YOUR_APP_NAMESPACE>:eat" path.
    [FBRequestConnection startForPostWithGraphPath:@"me/twithfriends:eat"
                                       graphObject:action
                                 completionHandler:
     ^(FBRequestConnection *connection, id result, NSError *error) {
         NSString *alertText;
         if (!error) {
             alertText = [NSString stringWithFormat:
                          @"Posted Open Graph action, id: %@",
                          [result objectForKey:@"id"]];
         } else {
             alertText = [NSString stringWithFormat:
                          @"error: domain = %@, code = %d",
                          error.domain, error.code];
         }
         [[[UIAlertView alloc] initWithTitle:@"Result"
                                     message:alertText
                                    delegate:nil
                           cancelButtonTitle:@"Thanks!"
                           otherButtonTitles:nil]
          show];
     }
     ];
}


#pragma mark - Private methods
- (IBAction)postButtonPressed {
    
    if ([FBSession.activeSession.permissions
         indexOfObject:@"publish_actions"] == NSNotFound) {
        
        [FBSession.activeSession
         requestNewPublishPermissions:[NSArray arrayWithObject:@"publish_actions"]
         defaultAudience:FBSessionDefaultAudienceFriends
         completionHandler:^(FBSession *session, NSError *error) {
             if (!error) {
                 // re-call assuming we now have the permission
                 [self postButtonPressed];
             }
         }];
    } else {
        if (self.imageToUse) {
            [self postPhotoThenOpenGraphAction];
        } else {
            [self postOpenGraphActionWithPhotoURL:nil];
        }
    }
}


- (IBAction)yumButtonPressed:(id)sender {
}

- (IBAction)yuckButtonPressed:(id)sender {
}
    
@end
