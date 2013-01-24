//
//  DetailView.m
//  umami_news
//
//  Created by Emanuel Campos on 21.01.13.
//  Copyright (c) 2013 bitter. All rights reserved.
//

#import "DetailView.h"
#import "Service.h"
#import "PreviewTableViewController.h"

@implementation DetailViewController
@synthesize contentTextView, detailItem, message, heroImage, imageCarrier, linkTextView, sourceLink;

-(void)viewDidLoad
{
    UIColor *backColor = [UIColor colorWithRed:236/255.0f green:236/255.0f blue:231/255.0f alpha:1.0];
    UIColor *txtColor = [UIColor colorWithRed:15/255.0f green:61/255.0f blue:72/255.0f alpha:1.0];
    
    _dtailView.backgroundColor = backColor;
    
    contentTextView.backgroundColor = backColor;
    contentTextView.dataDetectorTypes = UIDataDetectorTypeLink;
    contentTextView.textColor = txtColor;
    
    linkTextView.dataDetectorTypes = UIDataDetectorTypeLink;
    linkTextView.backgroundColor =backColor;
    linkTextView.textColor = txtColor;
    
   // [contentTextView sizeToFit];
   if (!sourceLink){
       linkTextView.hidden = TRUE;
   }
    
    contentTextView.text = message;
    linkTextView.text = sourceLink;
    heroImage.image = imageCarrier;
    
    NSLog(@"%@", heroImage);
    
    [super viewDidLoad];
}


@end
