//
//  ProfileViewController.h
//  twitter
//
//  Created by Deeksha Prabhakar on 6/6/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ProfileViewController : UIViewController
    @property (strong, nonatomic) User *user;
@property (weak, nonatomic) IBOutlet UILabel *userName;

@end
