//
//  User.h
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (strong, nonatomic) NSString *name;
// For user persistance
@property (strong, nonatomic) NSDictionary *dictionary;

@property (strong, nonatomic) NSURL *profileUrl;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (class, nonatomic) User *current;

@end
