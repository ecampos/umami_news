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
#import "DetailView.h"

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
    daylifeResponse = nil;
    facebookResponse = nil;
    twitterResponse = nil;
}

// Number of sections (always 1)
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//number of cells for each service
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.service.serviceName == @"twitter"){
        if (twitterResponse != nil && twitterNames.count != 0){
                return twitterNames.count;
        } else {
            return 1;
        }
    } else if (self.service.serviceName == @"facebook"){
        if (facebookResponse != nil && facebookNames.count != 0){
            return facebookNames.count;
        } else {
            return 1;
        }
    } else if (self.service.serviceName == @"news"){
        if (daylifeResponse != nil && daylifeNames.count != 0){
                return daylifeNames.count;
        } else {
            return 1;
        }
    } else {
        return 1;
    }
}

//this method will fill the cells depending on which service was selected in the view before
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"previewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //prepare Umami-specific colors
    cell.backgroundColor =[UIColor colorWithRed:236/255.0f green:236/255.0f blue:231/255.0f alpha:1.0];
    cell.textLabel.textColor = [UIColor colorWithRed:15/255.0f green:61/255.0f blue:72/255.0f alpha:1.0];
    cell.detailTextLabel.textColor = [UIColor colorWithRed:54/255.0f green:103/255.0f blue:116/255.0f alpha:1.0];
    
    //try catch will capture cases where the results are Null or something else went wrong
    @try {
        
        //case if Twitter
        if (self.service.serviceName == @"twitter") {
            if (twitterResponse!= nil){
                cell.textLabel.text = [[twitterNames valueForKey:@"from_user_name"] objectAtIndex:indexPath.row];
                cell.detailTextLabel.text = [[twitterContent valueForKey:@"text"] objectAtIndex:indexPath.row];
            } else {
                cell.textLabel.text = @"Nothing to see here";
                cell.detailTextLabel.text = @"please go back and search again";
            }
            
            //case if Daylife
        } else if (self.service.serviceName == @"news") {
            if (daylifeResponse!= nil){
                cell.textLabel.text = [[daylifeNames valueForKey:@"name"] objectAtIndex:indexPath.row];
                cell.detailTextLabel.text = [[daylifeContent valueForKey:@"headline"] objectAtIndex:indexPath.row];
            } else {
                cell.textLabel.text = @"Nothing to see here";
                cell.detailTextLabel.text = @"please go back and search again";
            }
            
            //case if Facebook
        } else if (self.service.serviceName == @"facebook") {
            if (facebookResponse!= nil){
                NSString *messageValue = [[facebookContent  valueForKey:@"message"] objectAtIndex:indexPath.row];
                NSString *linkValue = [[facebookContent  valueForKey:@"link"] objectAtIndex:indexPath.row];
                
                //Facebook has cases where not all expected fields are returned this block catches these cases -> avoids crash
                
                if (messageValue != ( NSString *) [ NSNull null]){
                    cell.detailTextLabel.text = messageValue;
                } else if (!messageValue && linkValue != ( NSString *) [ NSNull null]){
                    cell.detailTextLabel.text =linkValue;
                } else {
                    cell.detailTextLabel.text = @"no message for this post";
                }
                cell.textLabel.text = [[facebookNames valueForKey:@"name"] objectAtIndex:indexPath.row];
            } else {
                cell.textLabel.text = @"Nothing to see here";
                cell.detailTextLabel.text = @"please go back and search again";
            }
            
            //case invalid service Name
        } else {
            cell.textLabel.text = @"How did you even get here";
            cell.detailTextLabel.text = @"please go back and try not to break anything";
        }
    }
    
    @catch (NSException *exception) {
        if (self.service.serviceName == @"facebook") {
            if (facebookNames.count == 0){
            cell.textLabel.text = @"so many people on Facebook";
                cell.detailTextLabel.text = @"yet nobody seems to think the same as you";
        } else {
            cell.textLabel.text = @"an error occured";
            cell.detailTextLabel.text = @"sorry for that I hope we're still friends";
        }}
        
        if (self.service.serviceName == @"twitter") {
            if (twitterNames.count == 0){
            cell.textLabel.text = @"look for something intersting";
            cell.detailTextLabel.text = @"None on Twitter seems to care about this";
        } else {
            cell.textLabel.text = @"an error occured";
            cell.detailTextLabel.text = @"sorry for that I hope we're still friends";
        }}
        
        if (self.service.serviceName == @"news") {
            if (daylifeNames.count ==0
                ) {
            cell.textLabel.text = @"Your query is not newsworthy";
            cell.detailTextLabel.text = @"think of something else";
        } else {
        cell.textLabel.text = @"an error occured";
        cell.detailTextLabel.text = @"sorry for that I hope we're still friends";
        } }
    }
    @finally {
        return cell;
    }

    
}


 //Data for next View depending on which service is currently displayed

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
 NSError *error;
        if ([[segue identifier] isEqualToString:@"goToDetailView"]) {
           
            DetailViewController *detailViewController = [segue destinationViewController];
            UITableViewCell *cell =(UITableViewCell *)sender;
            NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
            detailViewController.detailItem = indexPath;
            detailViewController.title = cell.textLabel.text;
            
            if (self.service.serviceName == @"news" && daylifeNames != nil){
                detailViewController.message = [[daylifeContent valueForKey:@"excerpt"] objectAtIndex:indexPath.row];
            } else {
            detailViewController.message = cell.detailTextLabel.text;
            }
            //passes twitter specific parameters and queries for the user image based on user id in the original post
            if (self.service.serviceName == @"twitter"){
                if (twitterResponse != nil){
                    NSString *user =  [[[twitterResponse objectForKey:@"results"] valueForKey:@"from_user"] objectAtIndex:indexPath.row];
                    //search for picture and display
                    NSURL *imageURL =  [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", @"http://api.twitter.com/1/users/profile_image?screen_name=",user, @"&size=original"]];
                    NSData *imageData = [NSData dataWithContentsOfURL:imageURL options:NSDataReadingUncached error:&error];
                    detailViewController.imageCarrier = [UIImage imageWithData:imageData];
                } else {
                    NSURL *imageURL = [NSURL URLWithString:@"https://twitter.com/images/resources/twitter-bird-light-bgs.png"];
                    NSData *imageData = [NSData dataWithContentsOfURL:imageURL options:NSDataReadingUncached error:&error];
                    detailViewController.imageCarrier = [UIImage imageWithData:imageData];
             
                }
             //passes facebook specific parameters and queries for the user image based on user id in the original post
            } else if (self.service.serviceName == @"facebook"){
                if (facebookResponse != nil){
                    NSString *user = [[[[facebookResponse objectForKey:@"data"] valueForKey:@"from"] valueForKey:@"id"] objectAtIndex:indexPath.row];
                    NSString *fbURL = [NSString stringWithFormat:@"%@%@%@", @"https://graph.facebook.com/", user, @"/picture?type=large" ];
                    NSURL *imageURL = [NSURL URLWithString:fbURL];
                    NSData *imageData = [NSData dataWithContentsOfURL:imageURL options:NSDataReadingUncached error:&error];
                    detailViewController.imageCarrier = [UIImage imageWithData:imageData];
                    
                } else {
                    NSURL *imageURL = [NSURL URLWithString:@"https://graph.facebook.com/facebook/picture?type=normal"];
                    NSData *imageData = [NSData dataWithContentsOfURL:imageURL options:NSDataReadingUncached error:&error];
                    detailViewController.imageCarrier = [UIImage imageWithData:imageData];
                }
            //passes daylife specific parameters and queries for the image provided in the original post
            } else if (self.service.serviceName == @"news"){
                if (daylifeResponse != nil){
                    NSURL *imageURL = [NSURL URLWithString:[[[[[[daylifeResponse objectForKey:@"response"]objectForKey:@"payload"] objectForKey:@"article"]valueForKey:@"image"] valueForKey:@"url"]objectAtIndex:indexPath.row]];
                    NSData *imageData = [NSData dataWithContentsOfURL:imageURL options:NSDataReadingUncached error:&error];
                    detailViewController.imageCarrier = [UIImage imageWithData:imageData];
                    
                    detailViewController.sourceLink = [[[[[daylifeResponse objectForKey:@"response"]objectForKey:@"payload"] objectForKey:@"article"] valueForKey:@"url"] objectAtIndex:indexPath.row];
                } else {
                    NSURL *imageURL = [NSURL URLWithString:@"https://twimg0-a.akamaihd.net/profile_images/68501526/daylife_sun.png"];
                    NSData *imageData = [NSData dataWithContentsOfURL:imageURL options:NSDataReadingUncached error:&error];
                    detailViewController.imageCarrier = [UIImage imageWithData:imageData];
                }
            } 
        }
         
    }

@end
