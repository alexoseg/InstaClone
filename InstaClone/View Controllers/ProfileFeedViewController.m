//
//  ProfileFeedViewController.m
//  InstaClone
//
//  Created by Alex Oseguera on 7/8/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "ProfileFeedViewController.h"
#import "InstaCell.h"
#import "ParseGetter.h"
#import "MBProgressHUD.h"
#import "PostBuilder.h"

@interface ProfileFeedViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray<PFObject *> *postsArray;
@property (strong, nonatomic) UIRefreshControl* refreshControl;

@end

@implementation ProfileFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    [self.refreshControl addTarget:self
                            action:@selector(fetchProfilePosts)
                  forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl
                          atIndex:0];
    
    [MBProgressHUD showHUDAddedTo:self.view
                         animated:YES];
    [self fetchProfilePosts];
}

- (void)fetchProfilePosts {
    typeof(self) __weak weakSelf = self;
    [ParseGetter fetchPostsFromCurrentUserWithCompletion:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [MBProgressHUD hideHUDForView:weakSelf.view
                             animated:YES];
        typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) {
            return;
        }
        
        if (error != nil) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            NSLog(@"Successfully Fetched Posts!");
            strongSelf.postsArray = objects;
            [strongSelf.tableView reloadData];
        }
        [strongSelf.refreshControl endRefreshing];
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    InstaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InstaCell"];
    PFObject *const object = self.postsArray[indexPath.row];
    Post *post = [PostBuilder buildPostFromPFObject:object];
    [cell setUpInstaCellWithPost:post];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.postsArray.count;
}

@end
