//
//  Service.h
//  umami_news
//
//  Created by Emanuel Campos on 17.01.13.
//  Copyright (c) 2013 bitter. All rights reserved.
//

#import <Foundation/Foundation.h>
// Service Attributes
NSDictionary *twitterResponse;
NSDictionary *daylifeResponse;
NSDictionary *facebookResponse;

NSDictionary *twitterNames;
NSDictionary *daylifeNames;
NSDictionary *facebookNames;

NSDictionary *twitterContent;
NSDictionary *daylifeContent;
NSDictionary *facebookContent;


NSString *query;

@interface Service : NSObject

@property (strong)NSDictionary *resultDictionary;
@property (strong)NSDictionary *nameDictionary;
@property (strong)NSDictionary *contentDictionary;

@property (strong)NSString *serviceName;

-(id)initServiceName:(NSString *)aServiceName  resultDictionary:(NSDictionary *)aResultDictionary nameDictionary:(NSDictionary *)aNameDictionary contentDictionary:(NSDictionary *)aContentDictionary;

+(void) getTwitter:(NSString *)aQuery;
+(void) getNews:(NSString *)aQuery;
+(void) getFacebook:(NSString *)aQuery;


@end
