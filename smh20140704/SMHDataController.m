//
//  SMHDataController.m
//  smh20140704
//
//  Created by Current User on 07/07/2014.
//  Copyright (c) 2014 smh20140704. All rights reserved.
//

#import "SMHAppDelegate.h"
#import "SMHDataController.h"
#import "SMHProperty.h"

NSString *const SourceURL = @"http://www.gingermcninja.com/hw_test/propertylocationsearch.json";

@interface SMHDataController ()
{
    NSMutableArray *_result;
    SMHProperty *_currentProperty;
    NSManagedObjectContext *_backgroundContext;
}

@end

@implementation SMHDataController

+(id)sharedController {
    static SMHDataController *controller;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        controller = [[SMHDataController alloc] init];
    });
    return controller;
}

-(id)init
{
    self = [super init];
    if (self)
    {
        NSManagedObjectContext *context = [(SMHAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
        _backgroundContext = [[NSManagedObjectContext alloc] init];
        [_backgroundContext setPersistentStoreCoordinator:[context persistentStoreCoordinator]];
    }
    return self;
}

-(void)fetchDataWithCompletionHandler:(void(^)(NSArray*))completion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                   ^{
                       [self fetchOnlineData];
                       
                       dispatch_async(dispatch_get_main_queue(),
                                      ^{
                                          completion([_result copy]);
                                      });
                   });
}

-(void)fetchOnlineData
{
    _result = [[NSMutableArray alloc] init];
    NSURL *reqURL = [NSURL URLWithString:SourceURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:reqURL];
    NSHTTPURLResponse *response;
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (data && !error)
    {
        NSFetchRequest *requestAll = [[NSFetchRequest alloc] init];
        [requestAll setEntity:[NSEntityDescription entityForName:@"SMHProperty" inManagedObjectContext:_backgroundContext]];
        [requestAll setIncludesPropertyValues:NO];
        error = nil;
        NSArray *allItems = [_backgroundContext executeFetchRequest:requestAll
                                                              error:&error];
        if (!error)
        {
            for (SMHProperty *property in allItems)
            {
                [_backgroundContext deleteObject:property];
            }
        }
        [self parseData:data];
    } else {
        [self fetchLocalData];
    }
}

-(void)fetchLocalData
{
    NSEntityDescription *description = [NSEntityDescription entityForName:@"SMHProperty" inManagedObjectContext:_backgroundContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:description];
    NSError *error;
    _result = [NSMutableArray arrayWithArray:[_backgroundContext executeFetchRequest:request error:&error]];
}

-(void)parseData:(NSData *) data
{
    NSError *e = nil;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
    
    if (!jsonDict) {
        NSLog(@"Error parsing JSON: %@", e);
    } else {
        for(NSDictionary *item in jsonDict[@"result"][@"Properties"]) {
            NSLog(@"Item: %@", item);
            _currentProperty = [NSEntityDescription
                                insertNewObjectForEntityForName:@"SMHProperty"
                                inManagedObjectContext:_backgroundContext];
            _currentProperty.name = item[@"name"];
            _currentProperty.imageWidth = item[@"images"][0][@"width"];
            _currentProperty.imageHeight = item[@"images"][0][@"height"];
            _currentProperty.imageURL = item[@"images"][0][@"url"];
            _currentProperty.shortDesc = item[@"shortDescription"];
            [_result addObject:_currentProperty];
        }
    }
}

@end
