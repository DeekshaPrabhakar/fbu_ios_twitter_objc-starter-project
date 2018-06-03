//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "APIManager.h"
#import "User.h"

@interface TimelineViewController () < UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *tweets;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize tweets array
    self.tweets = [NSMutableArray array];
    
    // Setup table view
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //self.tableView.rowHeight = UITableViewAutomaticDimension;
   // self.tableView.estimatedRowHeight = 300.0;
    
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            [self.tweets setArray:tweets];
            [self.tableView reloadData];
        } else {
            NSLog(@"Error getting home timeline: %@", error.localizedDescription);
        }
    }];
}

- (void)getHomeTimelineWithCompletion:(void(^)(NSArray *tweets, NSError *error))completion{
    //TODO: Call AFNetworking request method
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell" forIndexPath:indexPath];
    Tweet *tweet = self.tweets[indexPath.row];
    cell.tweet = tweet;
    //[cell updateWithTweet:tweet];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

- (IBAction)didTapLogout:(id)sender {
    // 1. Clear current user
    User.current = nil;
    
    // TODO: 2. Deauthorize OAuth tokens
    [[APIManager shared] logout];
    
    // 3. Post logout notification
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didLogout" object:nil];
    
    
}


+ (void)logout {
    // 1. Clear current user
    User.current = nil;
    
    // TODO: 2. Deauthorize OAuth tokens
    [[APIManager shared] logout];
    
    // 3. Post logout notification
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didLogout" object:nil];
}

@end
