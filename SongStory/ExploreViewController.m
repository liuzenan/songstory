//
//  ExploreViewController.m
//  SongStory
//
//  Created by Zenan on 10/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "ExploreViewController.h"

@interface ExploreViewController (){
    NSMutableArray *emotions;
}

@end

@implementation ExploreViewController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    emotions = [NSMutableArray array];
    [emotions addObject:@"Aggressive"];
    [emotions addObject:@"Angsty"];
    [emotions addObject:@"Atomospheic"];
    [emotions addObject:@"Brooding"];
    [emotions addObject:@"Campy"];
    [emotions addObject:@"Celebratory"];
    [emotions addObject:@"Classy"];
    [emotions addObject:@"Cocky"];
    [emotions addObject:@"Cold"];
    [emotions addObject:@"Earthy"];
    [emotions addObject:@"Energetic"];
    [emotions addObject:@"Funky"];
    [emotions addObject:@"Gloomy"];
    [emotions addObject:@"Happy"];
    [emotions addObject:@"Hypnotic"];
    [emotions addObject:@"Introspective"];
    [emotions addObject:@"Lush"];
    [emotions addObject:@"Mellow"];
    [emotions addObject:@"Motivational"];
    [emotions addObject:@"Nocturnal"];
    [emotions addObject:@"Raw"];
    [emotions addObject:@"Rowdy"];
    [emotions addObject:@"Sad"];
    [emotions addObject:@"Seductive"];
    [emotions addObject:@"Sexual"];
    [emotions addObject:@"Soothing"];
    [emotions addObject:@"Spacey"];
    [emotions addObject:@"Sprightly"];
    [emotions addObject:@"Sweet"];
    [emotions addObject:@"Trashy"];
    [emotions addObject:@"Trippy"];
    [emotions addObject:@"Visceral"];
    [emotions addObject:@"Warm"];
    
    
    CALayer * l1 = [self.view layer];
    [l1 setMasksToBounds:YES];
    [l1 setCornerRadius:10.0];
    [l1 setBorderWidth:2.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [emotions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        NSLog(@"here");
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Set up the cell...
    NSString *cellValue = [emotions objectAtIndex:indexPath.row];
    cell.textLabel.text = cellValue;
    [cell.textLabel setFont:[UIFont fontWithName:@"Bariol-Bold" size:22]];
    CALayer * l1 = [cell layer];
    [l1 setBorderWidth:0.5f];
    [l1 setBorderColor:[UIColor colorWithWhite:0.8f alpha:0.8f].CGColor];
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
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
