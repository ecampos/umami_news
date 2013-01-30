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
@synthesize services, activityIndicator;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.activityIndicator.hidden= TRUE;
    [activityIndicator hidesWhenStopped];
    
    //add Search Bar to Navigation View
    self.searchBar.delegate =self;
    self.navigationItem.titleView = self.searchBar;
    
    // Nvigation / Search Bar Color and default value
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:15/255.0f green:61/255.0f blue:72/255.0f alpha:1.0];
    self.searchBar.tintColor = [UIColor colorWithRed:15/255.0f green:61/255.0f blue:72/255.0f alpha:1.0];
    self.searchBar.placeholder = @"what are you interested in?";
    
    //create service objects that contain Data
    Service *twitterService = [[Service alloc] initServiceName:@"twitter" resultDictionary:twitterResponse nameDictionary:twitterNames contentDictionary:twitterContent];
    Service *newsService = [[Service alloc] initServiceName:@"news"  resultDictionary:daylifeResponse nameDictionary:daylifeNames contentDictionary:daylifeContent];    
    Service *facebookService = [[Service alloc] initServiceName:@"facebook"  resultDictionary:facebookResponse nameDictionary:facebookNames contentDictionary:facebookContent];
   
    //create an Array containing the just created objects
    self.services = [NSArray arrayWithObjects:facebookService, twitterService, newsService, nil];
}


// this method will trigger the web requests
-(void) searchBarSearchButtonClicked:(UISearchBar*) searchBar
{
    //remove keyboard and start animating acitvity indicator
    [searchBar resignFirstResponder];
    activityIndicator.hidden = FALSE;
    [activityIndicator startAnimating];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //asynchronous call allows user to work witht the app while the web requests are being called
        query = searchBar.text;
        [Service getFacebook:query];
        [Service getNews:query];
        [Service getTwitter:query];
        
        //result request are moved to "smaller containers" facilitates counting of results and increases readability of code
        twitterNames = [twitterResponse objectForKey:@"results"];
        twitterContent = [twitterResponse objectForKey:@"results"];
        daylifeNames = [[[[daylifeResponse objectForKey:@"response"]objectForKey:@"payload"] objectForKey:@"article"]valueForKey:@"source"];
        daylifeContent = [[[daylifeResponse objectForKey:@"response"]objectForKey:@"payload"] objectForKey:@"article"];
        facebookNames = [[facebookResponse objectForKey:@"data"] valueForKey:@"from"];
        facebookContent = [facebookResponse objectForKey:@"data"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //as soon as the requests are complete the activity indicator will stop moving and hide
            [activityIndicator stopAnimating];
            activityIndicator.hidden = true;
        });
    });
}

// in case of a memory leak all "big" containers will be disposed
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    daylifeResponse = nil;
    facebookResponse = nil;
    twitterResponse = nil;
}

//this will group the cells into one section (side effect: rounded edges and cells look like they belong together)
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//number of rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return services.count;
}
//this method will fill the cells with the Service objects
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[self tableView] reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Service *s = [services objectAtIndex:indexPath.row];
    cell.textLabel.text = s.serviceName;
    cell.backgroundColor = [UIColor colorWithRed:236/255.0f green:236/255.0f blue:231/255.0f alpha:1.0];
    cell.textLabel.textColor = [UIColor colorWithRed:15/255.0f green:61/255.0f blue:72/255.0f alpha:1.0];
    return cell;
}


//definition of data that will be passed to the next view and sets the title to the name of the service that was selected
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
