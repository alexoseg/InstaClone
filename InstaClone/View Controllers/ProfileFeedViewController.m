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

#pragma mark - Interface

@interface ProfileFeedViewController () <UITableViewDelegate, UITableViewDataSource>

#pragma mark - Properties

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray<PFObject *> *postsArray;
@property (strong, nonatomic) UIRefreshControl* refreshControl;

@end

#pragma mark - Implementation

@implementation ProfileFeedViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpViews];
    [MBProgressHUD showHUDAddedTo:self.view
                         animated:YES];
    [self fetchProfilePosts];
}

#pragma mark - Networking

- (void)fetchProfilePosts
{
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

#pragma mark - Tableview Setup

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView
                 cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    InstaCell *const cell = [tableView dequeueReusableCellWithIdentifier:@"InstaCell"];
    PFObject *const object = self.postsArray[indexPath.row];
    Post *const post = [PostBuilder buildPostFromPFObject:object];
    [cell setUpInstaCellWithPost:post];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return _postsArray.count;
}

#pragma mark - Setup

- (void)setUpViews
{
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self
                            action:@selector(fetchProfilePosts)
                  forControlEvents:UIControlEventValueChanged];
    [_tableView insertSubview:_refreshControl
                          atIndex:0];
}

@end
