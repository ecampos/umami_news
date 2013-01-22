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
    self.searchBar.delegate =self;
    self.navigationItem.titleView = self.searchBar;


    
    //create service objects that contain Data
    Service *twitterService = [[Service alloc] initServiceName:@"twitter" resultDictionary:twitterResponse nameDictionary:twitterNames contentDictionary:twitterContent];
    Service *newsService = [[Service alloc] initServiceName:@"news"  resultDictionary:daylifeResponse nameDictionary:daylifeNames contentDictionary:daylifeContent];    
    Service *facebookService = [[Service alloc] initServiceName:@"facebook"  resultDictionary:facebookResponse nameDictionary:facebookNames contentDictionary:facebookContent];


    
    self.services = [NSArray arrayWithObjects:facebookService, twitterService, newsService, nil];

}

-(void) searchBarSearchButtonClicked:(UISearchBar*) searchBar
{

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //input parameters
        NSString *query = searchBar.text;
        
        NSString *twitter = @"http://search.twitter.com/search.json?q=";
        NSString *daylife  = @"http://freeapi.daylife.com/jsonrest/publicapi/4.10/search_getRelatedArticles?";
        NSString *facebook = @"https://graph.facebook.com/search?q=";
        
        NSString *facebookObjectType = @"&type=post"; //Facebook Specific
        //Daylife Specific
        
        NSString *accessKey = @"4d68ec63b744eec43fffad2fa9af98d1"; //Daylife Specific
        NSString *signatureCombiner = [NSString stringWithFormat:@"%@%@%@", accessKey, @"fd6167e10d2a54abe0206789adbaac09", query];
        NSString *capSignature = [signatureCombiner MD5String];
        NSString *signature = [capSignature lowercaseString];
        
        
        // request perparation
        
        NSString *daylifeURLString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@", daylife,@"query=", query, @"&accesskey=", accessKey, @"&signature=", signature];
  //      NSstring *new = [daylifeURLString stringby]
        NSString *escapedDaylife = [daylifeURLString stringByAddingPercentEscapesUsingEncoding:
        NSUTF8StringEncoding];
        NSURL *daylifeURL =[NSURL URLWithString:escapedDaylife];
        NSData *daylifeData = [NSData dataWithContentsOfURL:daylifeURL];

        
        NSString *twitterURLString = [NSString stringWithFormat:@"%@%@", twitter, query];
        NSString *escapedTwitter = [twitterURLString stringByAddingPercentEscapesUsingEncoding:
                                    NSUTF8StringEncoding];
        NSURL *twitterURL = [NSURL URLWithString:escapedTwitter];
        NSData *twitterData = [NSData dataWithContentsOfURL:twitterURL];
        
        NSString *facebookURLString = [NSString stringWithFormat:@"%@%@%@", facebook, query, facebookObjectType];
        NSString *escapedFacebook = [facebookURLString stringByAddingPercentEscapesUsingEncoding:
                                     NSUTF8StringEncoding];
        NSURL *facebookURL = [NSURL URLWithString:escapedFacebook];
        NSData *facebookData = [NSData dataWithContentsOfURL:facebookURL];
        
        NSError *error;
        
        twitterResponse = [NSJSONSerialization JSONObjectWithData:twitterData
                                                          options:kNilOptions
                                                            error:&error];
        daylifeResponse = [NSJSONSerialization JSONObjectWithData:daylifeData
                                                          options:kNilOptions
                                                            error:&error];
        facebookResponse = [NSJSONSerialization JSONObjectWithData:facebookData
                                                           options:kNilOptions error:&error];
        
        
        twitterNames = [twitterResponse objectForKey:@"results"];
        twitterContent = [twitterResponse objectForKey:@"results"];
        daylifeNames = [[[[daylifeResponse objectForKey:@"response"]objectForKey:@"payload"] objectForKey:@"article"]valueForKey:@"source"];
        daylifeContent = [[[daylifeResponse objectForKey:@"response"]objectForKey:@"payload"] objectForKey:@"article"];
        facebookNames = [[facebookResponse objectForKey:@"data"] valueForKey:@"from"];
        facebookContent = [facebookResponse objectForKey:@"data"];
        
 //       NSLog(@"%@", facebookContent);
 //       NSLog(@"%@", facebookNames);
        
        if (facebookContent != nil) {
        [self.activityIndicator stopAnimating];
        }

    });
    [searchBar resignFirstResponder];
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
    //number of rows
    return services.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
   
    Service *s = [services objectAtIndex:indexPath.row];
    cell.textLabel.text = s.serviceName;
    cell.backgroundColor =[UIColor colorWithRed:236/255.0f green:236/255.0f blue:231/255.0f alpha:1.0];
    cell.textLabel.textColor = [UIColor colorWithRed:15/255.0f green:61/255.0f blue:72/255.0f alpha:1.0];
    return cell;

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
  

#pragma mark - Table view delegate

@end
