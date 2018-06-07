//
//  TweetCell.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "Tweet.h"
#import "APIManager.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"

@interface TweetCell()

@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
- (IBAction)didTapFavorite:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *favoriteCount;
@property (weak, nonatomic) IBOutlet UIButton *heartButton;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@end

@implementation TweetCell

Tweet *_tweet = nil;

- (Tweet *)tweet{
    return _tweet;
}

- (void)setTweet:(Tweet *)tweet{
    _tweet = tweet;
    [self refreshData];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapUserProfile:)];
//    [self.profileImageView setUserInteractionEnabled:YES];
//    [self.profileImageView addGestureRecognizer:profileTapGestureRecognizer];
}

-(void)viewDidLoad{
    UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapUserProfile:)];
    [self.profileImageView setUserInteractionEnabled:YES];
    [self.profileImageView addGestureRecognizer:profileTapGestureRecognizer];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) didTapUserProfile:(UITapGestureRecognizer *)sender{
    // TODO: Call method on delegate
    [self.delegate tweetCell:self didTap:self.tweet.user];
}


- (IBAction)didTapFavorite:(id)sender {
   
    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
        }
//        if(tweet){
//            self.tweet.favorited = YES;
//            self.tweet.favoriteCount += 1;
//            [self refreshData];
//        }
//        else{
//            NSLog(@"Error getting home timeline: %@", error.localizedDescription);
//        }
    }];
}

- (void)refreshData{
    if(self.tweet.favorited){
        [self.heartButton setImage: [UIImage imageNamed:@"favor-icon-red"] forState: UIControlStateNormal];
    }else{
        [self.heartButton setImage: [UIImage imageNamed:@"favor-icon"] forState: UIControlStateNormal];
    }
    self.favoriteCount.text = [NSString stringWithFormat:@"%d",self.tweet.favoriteCount];
    self.tweetTextLabel.text = self.tweet.text;
    if(self.tweet.user.profileUrl != nil){
//         NSData *data = [NSData dataWithContentsOfURL:self.tweet.user.profileUrl];
//        UIImage *img = [[UIImage alloc]initWithData:data];
//        [self.profileImageView setImage:img];
        [self.profileImageView setImageWithURL:self.tweet.user.profileUrl];
    }
}

- (void)setImagefrom: (NSURL *)URL{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSession *session  = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *requestError) {
        if (requestError != nil) {
            NSLog(@"error");
        }
        else
        {
            UIImage *img = [[UIImage alloc]initWithData:data];
            [self.profileImageView setImage:img];
        }
    }];
    [dataTask resume];
}
@end
