//
//  SMHProperty.h
//  smh20140704
//
//  Created by Shah Hussain on 07/07/2014.
//  Copyright (c) 2014 Shah Hussain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SMHProperty : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * imageWidth;
@property (nonatomic, retain) NSNumber * imageHeight;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * shortDesc;
@property (nonatomic, strong) UIImage *image;

-(void)fetchImageWithCompletion:(void(^)())completion;

@end
