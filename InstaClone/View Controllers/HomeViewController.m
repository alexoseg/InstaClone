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
#import "Post.h"
#import "InstaDetailsViewContoller.h"
#import "MBProgressHUD.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *posts;
@property (strong, nonatomic) UIRefreshControl* refreshControl;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self fetchPosts];
}

-(void) fetchPosts {
    PFQuery *const query = [PFQuery queryWithClassName:@"Post"];
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
            weakSelf.posts = objects;
            [weakSelf.tableView reloadData];
        }
        [weakSelf.refreshControl endRefreshing];
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    InstaCell *const cell = [tableView dequeueReusableCellWithIdentifier:@"InstaCell"];
    PFObject *const object = self.posts[indexPath.row];
    Post *post = [[Post alloc] initWithObjectId:object.objectId caption:object[@"caption"] author:object[@"author"] commentCount:object[@"commentCount"] likeCount:object[@"likeCount"] image:object[@"image"] createdAtDate:object.createdAt];
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

- (IBAction)onLogout:(id)sender {
    NSLog(@"Logout pressed");
      [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
          SceneDelegate *const sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
          
          UIStoryboard *const storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
          UIViewController *const viewController = [storyboard instantiateViewControllerWithIdentifier:@"EntryViewController"];
          sceneDelegate.window.rootViewController = viewController;
      }];
}



#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"detailsSegue"]){
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        PFObject *const object = self.posts[indexPath.row];
        Post *post = [[Post alloc] initWithObjectId:object.objectId caption:object[@"caption"] author:object[@"author"] commentCount:object[@"commentCount"] likeCount:object[@"likeCount"] image:object[@"image"] createdAtDate:object.createdAt];
        InstaDetailsViewContoller *const destinationViewController = [segue destinationViewController];
        destinationViewController.post = post;
    }
}


@end
