//
//  DetailView.h
//  umami_news
//
//  Created by Emanuel Campos on 21.01.13.
//  Copyright (c) 2013 bitter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Service.h"


@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>
@property (strong)Service *detailService;
@property (weak, nonatomic) IBOutlet UIImageView *heroImage;
@property (strong, nonatomic) IBOutlet UIView *dtailView;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (strong)NSString *message;

@property (strong, nonatomic) id detailItem;
@end
