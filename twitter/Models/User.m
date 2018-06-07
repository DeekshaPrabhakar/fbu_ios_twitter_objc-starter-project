//
//  User.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "User.h"


@implementation User

static User *_current;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.dictionary = dictionary;
        if(dictionary[@"profile_image_url"]){
            NSMutableString *profileUrlStr = [dictionary[@"profile_image_url"] mutableCopy];
            
            [profileUrlStr replaceOccurrencesOfString:@"normal" withString:@"200x200" options: NSLiteralSearch range:NSMakeRange(0, profileUrlStr.length)];
            self.profileUrl = [[NSURL alloc]initWithString:profileUrlStr];
        }
    }
    return self;
}

+ (void)setCurrent:(User *)newUser{
    _current = newUser;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(newUser != nil)
    {
        NSData *data = [NSJSONSerialization dataWithJSONObject:newUser.dictionary options:0 error:nil];
        if(data != nil){
            [defaults setObject:data forKey:@"currentUserData"];
        }
    }
    else{
        [defaults removeObjectForKey:@"currentUserData"];
    }
}

+ (User *)current{
    if(_current == nil){
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *userData = [defaults dataForKey:@"currentUserData"];
        
        if(userData != nil){
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:userData options:NSJSONReadingMutableContainers error:nil];
            if(dictionary){
                _current = [[User alloc] initWithDictionary:dictionary];
            }
        }
    }
    return _current;
}


@end
