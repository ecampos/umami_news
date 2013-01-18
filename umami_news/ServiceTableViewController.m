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
    
    Service *facebook = [[Service alloc] initServiceName:@"facebook" serviceTitle:@"facebook"];//  resultDictionary:(NSDictionary *)
    Service *twitter = [[Service alloc] initServiceName:@"twitter" serviceTitle:@"twitter"];
    Service *news = [[Service alloc] initServiceName:@"news" serviceTitle:@"news"];
    
    self.services = [NSArray arrayWithObjects:facebook, twitter, news, nil];

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

    return services.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
   
    Service *s = [services objectAtIndex:indexPath.row];
    cell.textLabel.text = s.serviceTitle;
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
    }
}
  

#pragma mark - Table view delegate

@end
