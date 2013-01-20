//
//  PreviewTableViewController.m
//  umami_news
//
//  Created by Emanuel Campos on 12.01.13.
//  Copyright (c) 2013 bitter. All rights reserved.
//

#import "PreviewTableViewController.h"
#import "ServiceTableViewController.h"
#import "Service.h"

@interface PreviewTableViewController ()

@end

@implementation PreviewTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
        self.tableView.rowHeight = 60.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.service.serviceName == @"twitter"){
        if (twitterResponse != nil){
                return twitterNames.count;
        } else {
            return 1;
        }
    } else if (self.service.serviceName == @"facebook"){
        if (facebookResponse != nil){
            return facebookNames.count;
        } else {
            return 1;
        }
    } else if (self.service.serviceName == @"news"){
        if (daylifeResponse != nil){
            return daylifeNames.count;
        } else {
            return 1;
        }
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"previewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.backgroundColor =[UIColor colorWithRed:236/255.0f green:236/255.0f blue:231/255.0f alpha:1.0];
    cell.textLabel.textColor = [UIColor colorWithRed:15/255.0f green:61/255.0f blue:72/255.0f alpha:1.0];
    cell.detailTextLabel.textColor = [UIColor colorWithRed:54/255.0f green:103/255.0f blue:116/255.0f alpha:1.0];
    
    //case if Twitter
    if (self.service.serviceName == @"twitter") {
        if (twitterResponse!= nil){
            cell.textLabel.text = [[twitterNames valueForKey:@"from_user_name"] objectAtIndex:indexPath.row];
            cell.detailTextLabel.text = [[twitterContent valueForKey:@"text"] objectAtIndex:indexPath.row];
        }else {
            cell.textLabel.text = @"Nothing to see here";
            cell.detailTextLabel.text = @"please go back and search again";
        }
        
        //case if Daylife
    } else if (self.service.serviceName == @"news") {
        if (daylifeResponse!= nil){
            cell.textLabel.text = [[daylifeNames valueForKey:@"name"] objectAtIndex:indexPath.row];
            cell.detailTextLabel.text = [[daylifeContent valueForKey:@"headline"] objectAtIndex:indexPath.row];
        }else {
            cell.textLabel.text = @"Nothing to see here";
            cell.detailTextLabel.text = @"please go back and search again";
              }
    //case if Facebook
    } else if (self.service.serviceName == @"facebook") {
        if (facebookResponse!= nil){
            cell.textLabel.text = [[facebookNames  valueForKey:@"name"] objectAtIndex:indexPath.row];
            cell.detailTextLabel.text = [[facebookContent valueForKey:@"message"] objectAtIndex:indexPath.row];
        }else {
            cell.textLabel.text = @"Nothing to see here";
            cell.detailTextLabel.text = @"please go back and search again";
        }
     
    //case invalid service Name
    } else {
        cell.textLabel.text = @"How did you even get here";
        cell.detailTextLabel.text = @"please go back and try not to break anything";
    }
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
/*    if ([segue.identifier isEqualToString:@"goTodetailView"]) {
        UITableViewCell *cell =(UITableViewCell *)sender;
        NSIndexPath *ip =  [self.tableView indexPathForCell:cell];
        Service *s = [services objectAtIndex:ip.row];
        
        PreviewTableViewController *dest = (PreviewTableViewController *)segue.destinationViewController;
        dest.title = s.serviceName;
        dest.service= s;
        
        
    }
 */
}

#pragma mark - Table view delegate



@end
