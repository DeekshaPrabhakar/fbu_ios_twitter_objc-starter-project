//
//  APIManager.h
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "BDBOAuth1SessionManager.h"
#import "BDBOAuth1SessionManager+SFAuthenticationSession.h"
#import "Tweet.h"

@interface APIManager : BDBOAuth1SessionManager

+ (instancetype)shared;
- (void)getHomeTimelineWithCompletion:(void(^)(NSArray *tweets, NSError *error))completion;
- (void)favorite:(Tweet *)tweet completion:(void(^)(Tweet *tweet, NSError *error))completion;

@end
