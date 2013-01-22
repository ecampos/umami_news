//
//  DetailView.m
//  umami_news
//
//  Created by Emanuel Campos on 21.01.13.
//  Copyright (c) 2013 bitter. All rights reserved.
//

#import "DetailView.h"
#import "Service.h"

@implementation DetailViewController
@synthesize contentTextView, detailItem, message, heroImage, imageCarrier;

-(void)viewDidLoad
{
    
    _dtailView.backgroundColor = [UIColor colorWithRed:236/255.0f green:236/255.0f blue:231/255.0f alpha:1.0];
    contentTextView.backgroundColor = [UIColor colorWithRed:236/255.0f green:236/255.0f blue:231/255.0f alpha:1.0];
    contentTextView.dataDetectorTypes = UIDataDetectorTypeLink ;
    contentTextView.textColor = [UIColor colorWithRed:15/255.0f green:61/255.0f blue:72/255.0f alpha:1.0];
    [contentTextView sizeToFit];
    contentTextView.text = message;
    heroImage.image = imageCarrier;
    NSLog(@"%@", heroImage);
    
    [super viewDidLoad];
}


@end
