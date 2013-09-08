//
//  TWFProtocols.h
//  TWF
//
//  Created by Nimish Manjarekar on 9/8/13.
//  Copyright (c) 2013 Y.CORP.YAHOO.COM\seemakam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

@protocol TWFProtocols <NSObject>

@end

@protocol TWFFood<FBGraphObject>

@property (retain, nonatomic) NSString *id;
@property (retain, nonatomic) NSString *url;

@end

@protocol TWFEatFoodAction<FBOpenGraphAction>

@property (retain, nonatomic) id<TWFFood> food;

@end
