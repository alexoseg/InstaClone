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

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
