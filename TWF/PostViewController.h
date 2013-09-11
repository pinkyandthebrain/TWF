//
//  PostViewController.h
//  TWF
//
//  Created by Seema Kamath on 9/2/13.
//  Copyright (c) 2013 Y.CORP.YAHOO.COM\seemakam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <FacebookSDK/FacebookSDK.h>

@interface PostViewController : UIViewController <UITextViewDelegate, CLLocationManagerDelegate, FBPlacePickerDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) NSObject<FBGraphPlace>* selectedPlace;
@property (strong, nonatomic) FBPlacePickerViewController *placePickerController;

@property (strong, nonatomic) IBOutlet UIImageView *imageForPost;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet UIButton *locationBtn;
@property (strong, nonatomic) IBOutlet UITextView *foodDescription;

- (id)initWithImage:(UIImage *)imageToUse;

@end
