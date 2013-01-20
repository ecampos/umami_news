//
//  ServiceContainer.m
//  umami_news
//
//  Created by Emanuel Campos on 17.01.13.
//  Copyright (c) 2013 bitter. All rights reserved.
//

#import "Service.h"
#import "ServiceTableViewController.h"

@implementation Service

@synthesize serviceName;

-(id)initServiceName:(NSString *)aserviceName  resultDictionary:(NSDictionary *)aResultDictionary;
{
    self=[super init];
    if (self) {
        self.serviceName = aserviceName;

        self.resultDictionary = aResultDictionary;
    }
    return self;
    
}



@end
