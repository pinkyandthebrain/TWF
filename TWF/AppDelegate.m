//
//  AppDelegate.m
//  TWF
//
//  Created by Seema Kamath on 9/1/13.
//  Copyright (c) 2013 Y.CORP.YAHOO.COM\seemakam. All rights reserved.
//



#import "AppDelegate.h"
#import "TWFLoginViewController.h"
#import "TWFViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface AppDelegate ()

@property (nonatomic,strong) UINavigationController *nvc;
- (void) showLoginView;
- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.nvc = [[UINavigationController alloc] initWithRootViewController:[[TWFViewController alloc] init]];
    self.window.rootViewController = self.nvc;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    if(FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded){
        [self openSession];
    }else{
        [self showLoginView];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBSession.activeSession handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [FBSession.activeSession handleOpenURL:url];
}

#pragma mark - Private methods

- (void) showLoginView
{
    UIViewController *topViewController = [self.nvc topViewController];
    
    if(![[topViewController presentedViewController] isKindOfClass:[TWFLoginViewController class]]){
        TWFLoginViewController *loginViewController = [[TWFLoginViewController alloc] initWithNibName:@"TWFLoginViewController" bundle:nil];
        loginViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [topViewController presentViewController:loginViewController animated:YES completion:nil];
        
    }else{
        TWFLoginViewController *loginViewController = (TWFLoginViewController*)[topViewController presentedViewController];
        [loginViewController loginFailed];
    }
}

- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen: {
            UIViewController *topViewController =
            [self.nvc topViewController];
            if([[topViewController presentedViewController] isKindOfClass:[TWFLoginViewController  class]]){
                [topViewController dismissViewControllerAnimated:YES completion:nil];
            }
        }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            // Once the user has logged in, we want them to
            // be looking at the root view.
            [self.nvc popToRootViewControllerAnimated:NO];
            
            [FBSession.activeSession closeAndClearTokenInformation];
            
            [self showLoginView];
            break;
        default:
            break;
    }
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)openSession
{
    [FBSession openActiveSessionWithReadPermissions:nil
                                       allowLoginUI:YES
                                  completionHandler:
     ^(FBSession *session,
       FBSessionState state, NSError *error) {
         [self sessionStateChanged:session state:state error:error];
     }];
}

@end
