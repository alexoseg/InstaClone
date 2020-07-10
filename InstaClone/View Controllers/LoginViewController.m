//
//  LoginViewController.m
//  InstaClone
//
//  Created by Alex Oseguera on 7/6/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "LoginViewController.h"
#import "MBProgressHUD.h"
#import "ParsePoster.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void) displayAlertWithMessage:(NSString *)alertMessage andTitle:(NSString *)titleMessage{
    UIAlertController *const alert = [UIAlertController alertControllerWithTitle:titleMessage
                                                                         message:alertMessage
                                                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *const okAction = [UIAlertAction actionWithTitle:@"OK"
                                                             style:UIAlertActionStyleDefault
                                                           handler:nil];
    [alert addAction:okAction];
    [self presentViewController:alert
                       animated:YES
                     completion:nil];
}

- (IBAction)loginUser:(id)sender {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder)
                                               to:nil
                                             from:nil
                                         forEvent:nil];
    
    typeof(self) __weak weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view
                         animated:YES];
    [ParsePoster loginAccountWithUsername:self.usernameTextField.text
                                 password:self.passwordTextField.text
                           withCompletion:^(PFUser * _Nullable user, NSError * _Nullable error) {
        typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) {
            return;
        }
        [MBProgressHUD hideHUDForView:weakSelf.view
                             animated:YES];
        if(error != nil){
            [strongSelf displayAlertWithMessage:error.localizedDescription
                                       andTitle:@"Login Error"];
        } else {
            NSLog(@"Login Success");
            [strongSelf performSegueWithIdentifier:@"loginSegue"
                                            sender:nil];
        }
    }];
}

@end
