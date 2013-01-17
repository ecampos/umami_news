//
//  ServiceContainer.h
//  umami_news
//
//  Created by Emanuel Campos on 17.01.13.
//  Copyright (c) 2013 bitter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Service : NSObject

@property (strong)NSString *serviceName;
@property (strong)NSString *serviceTitle;
@property (strong)NSDictionary *resultDictionary;

-(id)initServiceName:(NSString *)aserviceName serviceTitle:(NSString *)aServiceTitle; //resultDictionary:(NSDictionary *)aResultDictionary;

@end
