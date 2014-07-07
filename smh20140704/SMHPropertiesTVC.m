//
//  SMHPropertiesTVC.m
//  smh20140704
//
//  Created by Current User on 07/07/2014.
//  Copyright (c) 2014 smh20140704. All rights reserved.
//

#import "SMHPropertiesTVC.h"
#import "SMHDataController.h"
#import "SMHProperty.h"

@interface SMHPropertiesTVC ()
{
    UIView *activityIndicatorView;
}

@property (strong, nonatomic) NSArray *properties;

@end

@implementation SMHPropertiesTVC
@synthesize properties;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showActivityIndicator];
    SMHDataController *dataController = [SMHDataController sharedController];
    [dataController fetchDataWithCompletionHandler:^void(NSArray *result){
        properties = result;
        [self.tableView reloadData];
        [self removeActivityIndicator];
    }];
    
    // Refresh control for pull-to-refresh
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor redColor];
    
    [refreshControl addTarget:self action:@selector(updateTable) forControlEvents:UIControlEventValueChanged];
    
    self.refreshControl = refreshControl;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showActivityIndicator
{
    activityIndicatorView = [[UIView alloc] initWithFrame:self.view.frame];
    [activityIndicatorView setBackgroundColor:[UIColor blackColor]];
    [activityIndicatorView setAlpha:0.5];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2)-40, (self.view.frame.size.height/2)-40, 80, 80)];
    [activityIndicatorView addSubview:spinner];
    [spinner startAnimating];
    [self.view addSubview:activityIndicatorView];
}

-(void)removeActivityIndicator
{
    [activityIndicatorView removeFromSuperview];
    activityIndicatorView = nil;
}

-(void)updateTable
{
    SMHDataController *dataController = [SMHDataController sharedController];
    [dataController fetchDataWithCompletionHandler:^void(NSArray *result){
        properties = result;
        // Core Data order is not online order so table needs refresh.
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [properties count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SMHPropertiesTVCell"];
    
    // Configure the cell...
    SMHProperty *tempProperty = [properties objectAtIndex:indexPath.row];
    [cell.textLabel setText:tempProperty.name];
    [cell.imageView setImage:[UIImage imageNamed:@"SMHPropertyPlaceholder"]];
    
    if (tempProperty.image)
    {
        [cell.imageView setImage:tempProperty.image];
    } else {
        [tempProperty fetchImageWithCompletion:^{
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
