//
//  ServiceTableViewController.h
//  umami_news
//
//  Created by Emanuel Campos on 12.01.13.
//  Copyright (c) 2013 bitter. All rights reserved.
//

#import <UIKit/UIKit.h>
UIActivityIndicatorView *activityIndicator;
@interface ServiceTableViewController : UITableViewController <UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@end
