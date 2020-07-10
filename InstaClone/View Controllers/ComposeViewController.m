//
//  ComposeViewController.m
//  InstaClone
//
//  Created by Alex Oseguera on 7/6/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "ComposeViewController.h"
#import "ParsePoster.h"
#import "MBProgressHUD.h"

@interface ComposeViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePickerVC;
@property (weak, nonatomic) IBOutlet UIImageView *composeImageView;
@property (weak, nonatomic) IBOutlet UITextView *captionTextView;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imagePickerVC = [UIImagePickerController new];
    self.imagePickerVC.delegate = self;
    self.imagePickerVC.allowsEditing = YES;
}

- (IBAction)cancelComposition:(id)sender {
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

- (IBAction)onTapImage:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:self.imagePickerVC
                       animated:YES
                     completion:nil];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    UIImage *const originalImage = info[UIImagePickerControllerOriginalImage];
    [self.composeImageView setImage:originalImage];
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *const resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *const newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (IBAction)onShare:(id)sender {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder)
                                               to:nil
                                             from:nil
                                         forEvent:nil];
    UIImage *const resizedImage = [self resizeImage:self.composeImageView.image
                                           withSize:CGSizeMake(500, 500)];
    
    typeof(self) __weak weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view
                         animated:YES];
    
    [ParsePoster parsePostFrom:resizedImage
                       caption:self.captionTextView.text
                withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        
        [MBProgressHUD hideHUDForView:weakSelf.view
                             animated:YES];
        if(error != nil){
            NSLog(@"Error Posting User Post");
        } else {
            NSLog(@"Sucessfully created post");
            [weakSelf dismissViewControllerAnimated:YES
                                         completion:nil];
        }
    }];
    
}

@end
