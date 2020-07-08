//
//  LoginViewController.m
//  InstaClone
//
//  Created by Alex Oseguera on 7/6/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "MBProgressHUD.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) displayAlertWithMessage:(NSString *)alertMessage andTitle:(NSString *)titleMessage{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:titleMessage message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
      style:UIAlertActionStyleDefault
    handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:^{
    }];
}

-(void) performLogin{
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    typeof(self) __weak weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * _Nullable user, NSError * _Nullable error) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        if(error != nil){
            [weakSelf displayAlertWithMessage:error.localizedDescription andTitle:@"Login Error"];
        } else {
            NSLog(@"Login Success");
            [weakSelf performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}

- (IBAction)loginUser:(id)sender {
    [self performLogin];
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
