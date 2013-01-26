//
//  ServiceContainer.m
//  umami_news
//
//  Created by Emanuel Campos on 17.01.13.
//  Copyright (c) 2013 bitter. All rights reserved.
//

#import "Service.h"
#import "ServiceTableViewController.h"
#import "MD5.h"

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
+(NSDictionary*)getTwitter:(NSString *)query
{
    NSError *error;
    NSString *twitter = @"http://search.twitter.com/search.json?q=";
    NSString *twitterURLString = [NSString stringWithFormat:@"%@%@%@", twitter, aquery, @"&lang=en"];
    NSString *escapedTwitter = [twitterURLString stringByAddingPercentEscapesUsingEncoding:
                                NSUTF8StringEncoding];
    NSURL *twitterURL = [NSURL URLWithString:escapedTwitter];
    NSData *twitterData = [NSData dataWithContentsOfURL:twitterURL];
    twitterResponse = [NSJSONSerialization JSONObjectWithData:twitterData
                                                      options:kNilOptions
                                                        error:&error];
    return twitterResponse;
}

+(NSDictionary*)getFacebook:(NSString *)query
{
    
    NSError *error;
    NSString *facebook = @"https://graph.facebook.com/search?q=";
    
    NSString *facebookObjectType = @"&type=post&filter=message&fields=description,message,from";
    
    NSString *facebookURLString = [NSString stringWithFormat:@"%@%@%@", facebook, query, facebookObjectType];
    NSString *escapedFacebook = [facebookURLString stringByAddingPercentEscapesUsingEncoding:
                                 NSUTF8StringEncoding];
    NSURL *facebookURL = [NSURL URLWithString:escapedFacebook];
    NSData *facebookData = [NSData dataWithContentsOfURL:facebookURL];
    
    facebookResponse = [NSJSONSerialization JSONObjectWithData:facebookData
                                                       options:kNilOptions error:&error];
    
    return facebookResponse;
}

+(NSDictionary*)getNews:(NSString *)query
{
        NSError *error;
      NSString *daylife  = @"http://freeapi.daylife.com/jsonrest/publicapi/4.10/search_getRelatedArticles?";
    NSString *accessKey = @"4d68ec63b744eec43fffad2fa9af98d1"; //Daylife Specific
    NSString *signatureCombiner = [NSString stringWithFormat:@"%@%@%@", accessKey, @"fd6167e10d2a54abe0206789adbaac09", aquery];
    NSString *allCapsSignature = [signatureCombiner MD5String];
    NSString *signature = [allCapsSignature lowercaseString];
    // changing an all Caps String to lowercase
    NSString *daylifeURLString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@", daylife,@"query=", aquery, @"&has_image=1&include_image=1", @"&accesskey=", accessKey, @"&signature=", signature];
    NSString *escapedDaylife = [daylifeURLString stringByAddingPercentEscapesUsingEncoding:
                                NSUTF8StringEncoding];
    NSURL *daylifeURL =[NSURL URLWithString:escapedDaylife];
    NSData *daylifeData = [NSData dataWithContentsOfURL:daylifeURL];
    daylifeResponse = [NSJSONSerialization JSONObjectWithData:daylifeData
                                                      options:kNilOptions
                                                        error:&error];
    
    return daylifeResponse;
}


@end
