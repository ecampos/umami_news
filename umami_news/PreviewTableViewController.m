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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"previewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.backgroundColor =[UIColor colorWithRed:236/255.0f green:236/255.0f blue:231/255.0f alpha:1.0];
    cell.textLabel.textColor = [UIColor colorWithRed:15/255.0f green:61/255.0f blue:72/255.0f alpha:1.0];
    cell.detailTextLabel.textColor = [UIColor colorWithRed:54/255.0f green:103/255.0f blue:116/255.0f alpha:1.0];

    
    if (self.service.resultDictionary != nil) {
    cell.textLabel.text = self.service.serviceName;
    cell.detailTextLabel.text = self.service.serviceName;

    } else {
        NSLog(@"%@", self.service);
        cell.textLabel.text = @"Nothing to see here";
        cell.detailTextLabel.text = @"please go back and search again";
    }
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

#pragma mark - Table view delegate



@end
