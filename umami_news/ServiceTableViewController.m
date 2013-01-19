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


@interface ServiceTableViewController ()
@property (strong) NSArray *services;

@end

@implementation ServiceTableViewController
@synthesize services;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.searchBar.delegate =self;

    
    //create service objects that contain Data
    Service *facebookService = [[Service alloc] initServiceName:@"facebook"  resultDictionary:facebookResponse];
    Service *twitterService = [[Service alloc] initServiceName:@"twitter" resultDictionary:twitterResponse];
    Service *newsService = [[Service alloc] initServiceName:@"news"  resultDictionary:daylifeResponse];
    
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
        NSString *limit =@"10"; //Daylife Specific
        NSString *accessKey = @"4d68ec63b744eec43fffad2fa9af98d1"; //Daylife Specific
        NSString *signature = @"02919f7064f10403310460de2737b7ab"; //Daylife Specific
        
        
        // request perparation
        
        NSString *daylifeURLString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@", daylife,@"query=", query, @"&limit=",limit, @"&accesskey=", accessKey, @"&signature=", signature];
        NSURL *daylifeURL =[NSURL URLWithString:daylifeURLString];
        NSData *daylifeData = [NSData dataWithContentsOfURL:daylifeURL];
        
        NSString *twitterURLString = [NSString stringWithFormat:@"%@%@", twitter, query];
        NSURL *twitterURL = [NSURL URLWithString:twitterURLString];
        NSData *twitterData = [NSData dataWithContentsOfURL:twitterURL];
        
        NSString *facebookURLString = [NSString stringWithFormat:@"%@%@%@", facebook, query, facebookObjectType];
        NSURL *facebookURL = [NSURL URLWithString:facebookURLString];
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
     //   [services objectAtIndex:@"facebook"
        NSLog(@"%@", facebookResponse);
        
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
        NSIndexPath *ip =  [self.tableView indexPathForCell:cell];
        Service *s = [self.services objectAtIndex:ip.row];
        
        PreviewTableViewController *dest = (PreviewTableViewController *)segue.destinationViewController;
        dest.service= s;
        if(cell.textLabel.text ==@"twitter"){
            dest.service.resultDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@"hello", nil];// twitterResponse;
            
        } else if (cell.textLabel.text ==@"news"){
            dest.service.resultDictionary = daylifeResponse;
        }
}
}
  

#pragma mark - Table view delegate

@end
