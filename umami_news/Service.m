//
//  Service.m
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

//object constructor
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
//classmethod calling Twitter web request
+(void)getTwitter:(NSString *)aQuery
{

    NSError *error;
    NSString *twitterURLString = [NSString stringWithFormat:@"%@%@%@", @"http://search.twitter.com/search.json?q=", aQuery, @"&lang=en"];
    NSString *escapedTwitter = [twitterURLString stringByAddingPercentEscapesUsingEncoding:
                                NSUTF8StringEncoding];
    NSURL *twitterURL = [NSURL URLWithString:escapedTwitter];
    NSData *twitterData = [NSData dataWithContentsOfURL:twitterURL];
    twitterResponse = [NSJSONSerialization JSONObjectWithData:twitterData
                                                      options:kNilOptions
                                                        error:&error];

}
//classmethod calling Facebook web request
+(void)getFacebook:(NSString *)aQuery
{
    
    NSError *error;
    NSString *facebookObjectType = @"&type=post&filter=message&fields=description,message,from";
    NSString *facebookURLString = [NSString stringWithFormat:@"%@%@%@", @"https://graph.facebook.com/search?q=", aQuery, facebookObjectType];
    NSString *escapedFacebook = [facebookURLString stringByAddingPercentEscapesUsingEncoding:
                                 NSUTF8StringEncoding];
    NSURL *facebookURL = [NSURL URLWithString:escapedFacebook];
    NSData *facebookData = [NSData dataWithContentsOfURL:facebookURL];
    
    facebookResponse = [NSJSONSerialization JSONObjectWithData:facebookData
                                                       options:kNilOptions error:&error];

}
//classmethod calling Daylife web request
+(void)getNews:(NSString *)aQuery
{
    NSError *error;
    NSString *daylife  = @"http://freeapi.daylife.com/jsonrest/publicapi/4.10/search_getRelatedArticles?";
    NSString *accessKey = @"4d68ec63b744eec43fffad2fa9af98d1"; //Daylife Specific
    NSString *signatureCombiner = [NSString stringWithFormat:@"%@%@%@", accessKey, @"fd6167e10d2a54abe0206789adbaac09", aQuery];
    NSString *allCapsSignature = [signatureCombiner MD5String];
      // changing an all Caps String to lowercase (Daylife is case sensitive)
    NSString *signature = [allCapsSignature lowercaseString];
    NSString *daylifeURLString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@", daylife,@"query=", aQuery, @"&has_image=1&include_image=1", @"&accesskey=", accessKey, @"&signature=", signature];
    NSString *escapedDaylife = [daylifeURLString stringByAddingPercentEscapesUsingEncoding:
                                NSUTF8StringEncoding];
    NSURL *daylifeURL =[NSURL URLWithString:escapedDaylife];
    NSData *daylifeData = [NSData dataWithContentsOfURL:daylifeURL];
    daylifeResponse = [NSJSONSerialization JSONObjectWithData:daylifeData
                                                      options:kNilOptions
                                                        error:&error];
    
}


@end
