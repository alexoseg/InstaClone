//
//  HomeViewController.m
//  InstaClone
//
//  Created by Alex Oseguera on 7/6/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "HomeViewController.h"
#import <Parse/Parse.h>
#import "SceneDelegate.h"
#import "InstaCell.h"
#import "InstaDetailsViewContoller.h"
#import "MBProgressHUD.h"
#import "PostBuilder.h"
#import "ParseGetter.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray<PFObject *> *posts;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (assign, nonatomic) BOOL isMoreDataLoading;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    [self.refreshControl addTarget:self
                            action:@selector(fetchPosts)
                  forControlEvents:UIControlEventValueChanged];
    
    [self.tableView insertSubview:self.refreshControl
                          atIndex:0];
    
    [MBProgressHUD showHUDAddedTo:self.view
                         animated:YES];
    [self fetchPosts];
}

-(void) fetchPosts {
    typeof(self) __weak weakSelf = self;
    [ParseGetter fetchAllPostsWithCompletion:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) {
            return;
        }
        
        [MBProgressHUD hideHUDForView:weakSelf.view
                             animated:YES];
        if (error != nil) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            NSLog(@"Successfully Fetched Posts!");
            strongSelf.posts = objects;
            [strongSelf.tableView reloadData];
        }
        [strongSelf.refreshControl endRefreshing];
    }];
}

#pragma mark - TABLEVIEW CODE

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    InstaCell *const cell = [tableView dequeueReusableCellWithIdentifier:@"InstaCell"];
    PFObject *const object = self.posts[indexPath.row];
    Post *const post = [PostBuilder buildPostFromPFObject:object];
    [cell setUpInstaCellWithPost:post];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    [tableView reloadRowsAtIndexPaths:[[NSArray alloc] initWithObjects: indexPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - OTHER FEATURES

- (IBAction)onLogout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        
        SceneDelegate *const sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
        UIStoryboard *const storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                                   bundle:nil];
        
        UIViewController *const viewController = [storyboard instantiateViewControllerWithIdentifier:@"EntryViewController"];
        sceneDelegate.window.rootViewController = viewController;
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(!self.isMoreDataLoading){
        
        int const scrollViewContentHeight = self.tableView.contentSize.height;
        int const scrollOffsetThreshold = scrollViewContentHeight - self.tableView.bounds.size.height;
        
        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.tableView.isDragging) {
            self.isMoreDataLoading = YES;
            [self loadMoreData];
        }
    }
}

- (void)loadMoreData {
    PFObject *const lastObject = self.posts[self.posts.count - 1];
    typeof(self) __weak weakSelf = self;
    
    [ParseGetter fetchPostsBefore:lastObject.createdAt
                   withCompletion:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) {
            return;
        }
        
        if (error != nil) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            NSLog(@"Successfully Fetched More Posts!");
            strongSelf.posts = [strongSelf.posts arrayByAddingObjectsFromArray:objects];
            strongSelf.isMoreDataLoading = NO;
            [strongSelf.tableView reloadData];
        }
    }];
}

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"detailsSegue"]) {
        UITableViewCell *const tappedCell = sender;
        NSIndexPath *const indexPath = [self.tableView indexPathForCell:tappedCell];
        PFObject *const object = self.posts[indexPath.row];
        Post *const post = [PostBuilder buildPostFromPFObject:object];
        InstaDetailsViewContoller *const destinationViewController = [segue destinationViewController];
        destinationViewController.post = post;
    }
}


@end
