//
//  ServiceTableViewController.h
//  umami_news
//
//  Created by Emanuel Campos on 12.01.13.
//  Copyright (c) 2013 bitter. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ServiceTableViewController : UITableViewController <UISearchBarDelegate, UITableViewDelegate> 

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@end
