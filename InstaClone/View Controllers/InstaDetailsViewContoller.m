//
//  InstaDetailsViewContoller.m
//  InstaClone
//
//  Created by Alex Oseguera on 7/7/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "InstaDetailsViewContoller.h"

@interface InstaDetailsViewContoller ()
@property (weak, nonatomic) IBOutlet UILabel *usernameLabelTop;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabelBot;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UIImageView *instaImageView;


@end

@implementation InstaDetailsViewContoller

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpViews];
}
 
- (void) setUpViews {
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
    self.usernameLabelBot.text = self.post.username;
    self.usernameLabelTop.text = self.post.username;
    
    self.captionLabel.text = self.post.caption;
    [self.post.postImage getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        UIImage *image = [UIImage imageWithData:data];
        [self.instaImageView setImage:image];
    }];
    
    self.timestampLabel.text = self.post.createdAtDateString;
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
