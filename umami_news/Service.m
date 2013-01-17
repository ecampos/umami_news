//
//  ServiceContainer.m
//  umami_news
//
//  Created by Emanuel Campos on 17.01.13.
//  Copyright (c) 2013 bitter. All rights reserved.
//

#import "Service.h"

@implementation Service

@synthesize serviceName,serviceTitle;

-(id)initServiceName:(NSString *)aserviceName serviceTitle:(NSString *)aServiceTitle; //resultDictionary:(NSDictionary *)aResultDictionary
{
    self=[super init];
    if (self) {
        self.serviceName = aserviceName;
        self.serviceTitle = aServiceTitle;
   //     self.resultDictionary = aResultDictionary;
    }
    return self;
    
}

@end
