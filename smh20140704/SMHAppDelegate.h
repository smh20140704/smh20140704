//
//  SMHAppDelegate.h
//  smh20140704
//
//  Created by Shah Hussain on 07/07/2014.
//  Copyright (c) 2014 Shah Hussain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMHAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
