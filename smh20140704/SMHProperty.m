//
//  SMHProperty.m
//  smh20140704
//
//  Created by Current User on 07/07/2014.
//  Copyright (c) 2014 smh20140704. All rights reserved.
//

#import "SMHProperty.h"

@interface SMHProperty ()
{
    BOOL runOnce;
}

@end

@implementation SMHProperty

@dynamic name;
@dynamic imageWidth;
@dynamic imageHeight;
@dynamic imageURL;
@dynamic shortDesc;

@synthesize image;

-(id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    if (self)
    {
        runOnce = NO;
    }
    
    return self;
}

-(void)fetchImageWithCompletion:(void (^)())completion
{
    @synchronized(self)
    {
        if (!runOnce)
        {
            runOnce = YES;
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                NSURL *reqURL = [NSURL URLWithString:self.imageURL];
                NSURLRequest *request = [NSURLRequest requestWithURL:reqURL];
                NSHTTPURLResponse *response;
                NSError *error;
                NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
                
                if (data && !error)
                {
                    self.image = [UIImage imageWithData:data];
                }
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    completion();
                });
            });
        }
    }
}

@end
