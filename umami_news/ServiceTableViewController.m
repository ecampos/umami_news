//
//  ServiceTableViewController.m
//  umami_news
//
//  Created by Emanuel Campos on 12.01.13.
//  Copyright (c) 2013 bitter. All rights reserved.
//

#import "ServiceTableViewController.h"
#import "PreviewTableViewController.h"
#import "Service.h"
#import "MD5.h"



@interface ServiceTableViewController ()
@property (strong) NSArray *services;

@end

@implementation ServiceTableViewController
@synthesize services, spinner;

- (void)viewDidLoad
{

    [super viewDidLoad];
    
    self.spinner.hidden= TRUE;
    [spinner hidesWhenStopped];
    
    //add Search Bar to Navigation View
    self.searchBar.delegate =self;
    self.navigationItem.titleView = self.searchBar;
    self.searchBar.tintColor = [UIColor colorWithRed:15/255.0f green:61/255.0f blue:72/255.0f alpha:1.0];
    self.searchBar.placeholder = @"what are you interested in?";
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:15/255.0f green:61/255.0f blue:72/255.0f alpha:1.0];
    
    //create service objects that contain Data
    Service *twitterService = [[Service alloc] initServiceName:@"twitter" resultDictionary:twitterResponse nameDictionary:twitterNames contentDictionary:twitterContent];
    Service *newsService = [[Service alloc] initServiceName:@"news"  resultDictionary:daylifeResponse nameDictionary:daylifeNames contentDictionary:daylifeContent];    
    Service *facebookService = [[Service alloc] initServiceName:@"facebook"  resultDictionary:facebookResponse nameDictionary:facebookNames contentDictionary:facebookContent];
   
    //create an Array containing the just created objects
    self.services = [NSArray arrayWithObjects:facebookService, twitterService, newsService, nil];

}



-(void) searchBarSearchButtonClicked:(UISearchBar*) searchBar
{
    
    [searchBar resignFirstResponder];
    
    spinner.hidden = FALSE;
    [spinner startAnimating];
    if(![self connected])
    {
        // not connected
    } else
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            
            
            [self.tableView reloadData];
            query = searchBar.text;
            [Service getFacebook:query];
            
            [Service getNews:query];
            
            [Service getTwitter:query];
            
            
            twitterNames = [twitterResponse objectForKey:@"results"];
            twitterContent = [twitterResponse objectForKey:@"results"];
            NSLog(@"%@", @"twitter done");
            daylifeNames = [[[[daylifeResponse objectForKey:@"response"]objectForKey:@"payload"] objectForKey:@"article"]valueForKey:@"source"];
            daylifeContent = [[[daylifeResponse objectForKey:@"response"]objectForKey:@"payload"] objectForKey:@"article"];
            NSLog(@"%@", @"news done");
            facebookNames = [[facebookResponse objectForKey:@"data"] valueForKey:@"from"];
            facebookContent = [facebookResponse objectForKey:@"data"];
            NSLog(@"%@", @"facebook done");
            dispatch_async(dispatch_get_main_queue(), ^{
                [spinner stopAnimating];
                spinner.hidden = true;
                
                
            });
            
            
        });

    }
    

       [self.tableView reloadData];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //number of rows
    return services.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //

    [[self tableView] reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
   
    Service *s = [services objectAtIndex:indexPath.row];
    cell.textLabel.text = s.serviceName;
    cell.backgroundColor = [UIColor colorWithRed:236/255.0f green:236/255.0f blue:231/255.0f alpha:1.0];
    cell.textLabel.textColor = [UIColor colorWithRed:15/255.0f green:61/255.0f blue:72/255.0f alpha:1.0];
    return cell;

}

- (BOOL)connected
{
/*    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);*/
    return false;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"goToPreview"]) {
        UITableViewCell *cell =(UITableViewCell *)sender;
        NSIndexPath *indexPath =  [self.tableView indexPathForCell:cell];
        Service *informationSource = [self.services objectAtIndex:indexPath.row];
        
        PreviewTableViewController *destination = (PreviewTableViewController *)segue.destinationViewController;
        destination.title = informationSource.serviceName;
        destination.service= informationSource;
        
    }
}


@end
