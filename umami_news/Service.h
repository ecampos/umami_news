//
//  ServiceContainer.h
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
NSString *aquery;

@interface Service : NSObject

@property (strong)NSDictionary *resultDictionary;
@property (strong)NSDictionary *nameDictionary;
@property (strong)NSDictionary *contentDictionary;

@property (strong)NSString *serviceName;
@property (strong)NSString *aquery;

@property (strong)NSDictionary *twitterResponse;
@property (strong)NSDictionary *daylifeResponse;
@property (strong)NSDictionary *facebookResponse;

@property (strong)NSDictionary *twitterNames;
@property (strong)NSDictionary *daylifeNames;
@property (strong)NSDictionary *facebookNames;

@property (strong)NSDictionary *twitterContent;
@property (strong)NSDictionary *daylifeContent;
@property (strong)NSDictionary *facebookContent;

-(id)initServiceName:(NSString *)aServiceName  resultDictionary:(NSDictionary *)aResultDictionary nameDictionary:(NSDictionary *)aNameDictionary contentDictionary:(NSDictionary *)aContentDictionary;

+(NSDictionary*) getTwitter:(NSString *)query;
+(NSDictionary*) getNews:(NSString *)query;
+(NSDictionary*) getFacebook:(NSString *)query;


@end
