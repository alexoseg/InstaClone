//
//  ProfileFeedViewController.m
//  InstaClone
//
//  Created by Alex Oseguera on 7/8/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "ProfileFeedViewController.h"
#import "InstaCell.h"
#import <Parse/Parse.h>
#import "MBProgressHUD.h"

@interface ProfileFeedViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *postsArray;
@property (strong, nonatomic) UIRefreshControl* refreshControl;

@end

@implementation ProfileFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
     [self.refreshControl addTarget:self action:@selector(fetchProfilePosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self fetchProfilePosts];
}

- (void)fetchProfilePosts {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    NSLog(@"%@", PFUser.currentUser.username);
    [query whereKey:@"author" equalTo:[PFUser currentUser]];
    [query includeKey:@"caption"];
    [query includeKey:@"commentCount"];
    [query includeKey:@"likeCount"];
    [query includeKey:@"image"];
    [query includeKey:@"author"];
    [query orderByDescending:@"createdAt"];
    
    query.limit = 20;
    typeof(self) __weak weakSelf = self;
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        if(error != nil){
            NSLog(@"%@", error.localizedDescription);
        } else {
            NSLog(@"Successfully Fetched Posts!");
            weakSelf.postsArray = objects;
            [weakSelf.tableView reloadData];
        }
        [weakSelf.refreshControl endRefreshing];
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    InstaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InstaCell"];
    PFObject *const object = self.postsArray[indexPath.row];
    Post *post = [[Post alloc] initWithObjectId:object.objectId caption:object[@"caption"] author:object[@"author"] commentCount:object[@"commentCount"] likeCount:object[@"likeCount"] image:object[@"image"] createdAtDate:object.createdAt];
    [cell setUpInstaCellWithPost:post];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.postsArray.count;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
