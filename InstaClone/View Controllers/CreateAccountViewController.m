//
//  CreateAccountViewController.m
//  InstaClone
//
//  Created by Alex Oseguera on 7/6/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "CreateAccountViewController.h"
#import <Parse/Parse.h>
#import "MBProgressHUD.h"

@interface CreateAccountViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation CreateAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

-(void)performSignUp{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
    PFUser *newUser = [PFUser user];
    newUser.username = self.usernameTextField.text;
    newUser.password = self.passwordTextField.text;
    
    typeof(self) __weak weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        if(error != nil ){
            NSLog(@"Error: %@", error.localizedDescription);
            [weakSelf displayAlertWithMessage:error.localizedDescription andTitle:@"Sign up error"];
        } else {
            NSLog(@"User Registed Successfully");
            [weakSelf performSegueWithIdentifier:@"signupCompleteSegue" sender:nil];
        }
    }];
}

- (IBAction)signUpUser:(id)sender {
    [self performSignUp];
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
