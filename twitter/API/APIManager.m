//
//  APIManager.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "APIManager.h"
#import "Tweet.h"
#import "AFNetworking.h"
#import "User.h"

static NSString * const baseURLString = @"https://api.twitter.com";
static NSString * const consumerKey = @"mDfbHJSlu1nN1up1HggY92aQ9";
static NSString * const consumerSecret = @"fKSAb4J1aVDjgYXRUNd4r7EjYvp3Zb4IggW9QmSa8L2tBOM5uk";

@interface APIManager()

@end

@implementation APIManager

+ (instancetype)shared {
    static APIManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (instancetype)init {
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    self = [super initWithBaseURL:baseURL consumerKey:consumerKey consumerSecret:consumerSecret];
    if (self) {
       
    }
    return self;
}

- (void)getHomeTimelineWithCompletion:(void(^)(NSArray *tweets, NSError *error))completion {
    
    [self GET:@"1.1/statuses/home_timeline.json"
   parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray *  _Nullable tweetDictionaries) {
       
       // Create Tweets from dictionaries
       //       NSMutableArray *tweets = [NSMutableArray array];
       //       for (NSDictionary *dictionary in tweetDictionaries) {
       //           Tweet *tweet = [[Tweet alloc] initWithDictionary:dictionary];
       //           [tweets addObject:tweet];
       //       }
       
       // Cache it
       //       NSData *data = [NSKeyedArchiver archivedDataWithRootObject:tweetDictionaries];
       [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"hometimeline_tweets"];
       
       
       NSMutableArray *tweets  = [Tweet tweetsWithArray:tweetDictionaries];
       
       if (completion) { completion(tweets, nil); }
       
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
       if (completion) { completion(nil, error); }
   }];
}

- (void)favorite:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion{
    
    //    NSString *url = [NSString stringWithFormat:@"1.1/favorites/create.json?id=%ld", tweet.uid];
    NSString *urlString = @"1.1/favorites/create.json";
    NSDictionary *parameters = @{@"id": [NSNumber numberWithLong:(tweet.uid)]};
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        NSLog(@"%@", tweetDictionary);
        Tweet *tweet = [[Tweet alloc]initWithDictionary:tweetDictionary];
        completion(tweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

- (void)composeTweetWith:(NSString *)text completion:(void (^)(Tweet *, NSError *))completion{
    NSString *urlString = @"1.1/statuses/update.json";
    NSDictionary *parameters = @{@"status": text};
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        NSLog(@"%@", tweetDictionary);
        Tweet *tweet = [[Tweet alloc]initWithDictionary:tweetDictionary];
        completion(tweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}



@end
