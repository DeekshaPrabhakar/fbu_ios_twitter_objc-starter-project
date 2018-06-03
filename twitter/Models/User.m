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
    }
    return self;
}

+ (void)setCurrent:(User *)newUser{
    _current = newUser;
}

+ (User *)current{
    return _current;
}


@end
