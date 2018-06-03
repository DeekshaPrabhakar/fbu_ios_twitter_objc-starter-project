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

@interface TweetCell()

@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
- (IBAction)didTapFavorite:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *favoriteCount;
@property (weak, nonatomic) IBOutlet UIButton *heartButton;

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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)didTapFavorite:(id)sender {
   
    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(tweet){
            [self refreshData];
        }
        else{
            NSLog(@"Error getting home timeline: %@", error.localizedDescription);
        }
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
}
@end
