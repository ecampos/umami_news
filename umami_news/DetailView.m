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
    //set Umami coloring
    UIColor *backColor = [UIColor colorWithRed:236/255.0f green:236/255.0f blue:231/255.0f alpha:1.0];
    UIColor *txtColor = [UIColor colorWithRed:15/255.0f green:61/255.0f blue:72/255.0f alpha:1.0];
    _dtailView.backgroundColor = backColor;
    contentTextView.backgroundColor = backColor;
    contentTextView.dataDetectorTypes = UIDataDetectorTypeLink;
    contentTextView.textColor = txtColor;
  
    //Daylife specific block. will display a Link to the original news source
    if (!sourceLink){
        linkTextView.hidden = TRUE;
    }
    linkTextView.dataDetectorTypes = UIDataDetectorTypeLink;
    linkTextView.backgroundColor =backColor;
    linkTextView.textColor = txtColor;
    linkTextView.text = sourceLink;

    //fill the content 
    contentTextView.text = message;
    heroImage.image = imageCarrier;
    [super viewDidLoad];
}
@end
