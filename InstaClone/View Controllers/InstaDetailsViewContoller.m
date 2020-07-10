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
        UIImage *const image = [UIImage imageWithData:data];
        [self.instaImageView setImage:image];
    }];
    
    self.timestampLabel.text = self.post.createdAtDateString;
}

@end
