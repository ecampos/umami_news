//
//  ServiceContainer.h
//  umami_news
//
//  Created by Emanuel Campos on 17.01.13.
//  Copyright (c) 2013 bitter. All rights reserved.
//

#import <Foundation/Foundation.h>
NSDictionary *twitterResponse;
NSDictionary *daylifeResponse;
NSDictionary *facebookResponse;
@interface Service : NSObject

@property (strong)NSString *serviceName;
@property (strong)NSDictionary *resultDictionary;
@property (strong)NSString *query;
@property (strong)NSDictionary *twitterResponse;
@property (strong)NSDictionary *daylifeResponse;
@property (strong)NSDictionary *facebookResponse;

-(id)initServiceName:(NSString *)aServiceName  resultDictionary:(NSDictionary *)aResultDictionary;
-(NSDictionary *) fetchResultDictionary;


@end
