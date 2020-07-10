//
//  CreateAccountViewController.m
//  InstaClone
//
//  Created by Alex Oseguera on 7/6/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "CreateAccountViewController.h"
#import "ParsePoster.h"
#import "MBProgressHUD.h"
#import "SceneDelegate.h"

#pragma mark - Interface

@interface CreateAccountViewController ()

#pragma mark - Properties

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

#pragma mark - Implementation

@implementation CreateAccountViewController

#pragma mark - Alert Controls

- (void) displayAlertWithMessage:(NSString *)alertMessage
                        andTitle:(NSString *)titleMessage
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:titleMessage
                                                                   message:alertMessage
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    [alert addAction:okAction];
    [self presentViewController:alert
                       animated:YES
                     completion:nil];
}

#pragma mark - Networking

- (IBAction)signUpUser:(id)sender
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder)
                                               to:nil
                                             from:nil
                                         forEvent:nil];
    typeof(self) __weak weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view
                         animated:YES];
    
    [ParsePoster createAccountWithUsername:self.usernameTextField.text
                                  password:self.passwordTextField.text
                            withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        
        typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) {
            return;
        }
        
        [MBProgressHUD hideHUDForView:weakSelf.view
                             animated:YES];
        if (error != nil ) {
            NSLog(@"Error: %@", error.localizedDescription);
            [strongSelf displayAlertWithMessage:error.localizedDescription
                                       andTitle:@"Sign up error"];
        } else {
            NSLog(@"User Registed Successfully");
            SceneDelegate *const sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
            UIStoryboard *const storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                                       bundle:nil];
            sceneDelegate.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"tabController"];
        }
    }];
}

@end
