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

@synthesize serviceName, resultDictionary, nameDictionary, contentDictionary;

-(id)initServiceName:(NSString *)aServiceName  resultDictionary:(NSDictionary *)aResultDictionary nameDictionary:(NSDictionary *)aNameDictionary contentDictionary:(NSDictionary *)aContentDictionary;
{
    self=[super init];
    if (self) {
        self.serviceName = aServiceName;
        self.resultDictionary = aResultDictionary;
        self.nameDictionary = aNameDictionary;
        self.contentDictionary = aContentDictionary;
    }
    return self;
    
}



@end
