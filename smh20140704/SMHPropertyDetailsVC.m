//
//  SMHPropertyDetailsVC.m
//  smh20140704
//
//  Created by Current User on 07/07/2014.
//  Copyright (c) 2014 smh20140704. All rights reserved.
//

#import "SMHPropertyDetailsVC.h"
#import "SMHProperty.h"

@interface SMHPropertyDetailsVC ()

@property (weak, nonatomic) IBOutlet UIImageView *propertyImage;
@property (weak, nonatomic) IBOutlet UITextView *propertyShortDesc;

@end

@implementation SMHPropertyDetailsVC
@synthesize property, propertyImage, propertyShortDesc;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSAssert(property, @"No property data");
    [self.navigationItem setTitle:property.name];
    [propertyImage setImage:property.image];
    [propertyShortDesc setText:property.shortDesc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
