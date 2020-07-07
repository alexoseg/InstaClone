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

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *posts;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self fetchPosts];
    // Do any additional setup after loading the view.
}

-(void) fetchPosts {
    PFQuery *const query = [PFQuery queryWithClassName:@"Post"];
    [query includeKey:@"caption"];
    [query includeKey:@"commentCount"];
    [query includeKey:@"likeCount"];
    [query includeKey:@"image"];
    [query includeKey:@"author"];
    
    query.limit = 20;
    typeof(self) __weak weakSelf = self;
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if(error != nil){
            NSLog(@"%@", error.localizedDescription);
        } else {
            NSLog(@"Successfully Fetched Posts!");
            weakSelf.posts = objects;
            [weakSelf.tableView reloadData];
        }
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    InstaCell *const cell = [tableView dequeueReusableCellWithIdentifier:@"InstaCell"];
    PFObject *const object = self.posts[indexPath.row];
    Post *post = [[Post alloc] initWithObjectId:object.objectId caption:object[@"caption"] author:object[@"author"] commentCount:object[@"commentCount"] likeCount:object[@"likeCount"] image:object[@"image"]];
    
    cell.descriptionLabel.text = post.caption;
    cell.postImageView.image = nil;
    [post.image getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        UIImage *image = [UIImage imageWithData:data];
        [cell.postImageView setImage:image];
    }];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
