//
//  SMHDataController.h
//  smh20140704
//
//  Created by Shah Hussain on 07/07/2014.
//  Copyright (c) 2014 Shah Hussain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMHDataController : NSObject

+(id)sharedController;

-(void)fetchDataWithCompletionHandler:(void(^)(NSArray*))completion;

@end
