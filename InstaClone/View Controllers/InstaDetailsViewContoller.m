//
//  InstaDetailsViewContoller.m
//  InstaClone
//
//  Created by Alex Oseguera on 7/7/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "InstaDetailsViewContoller.h"

#pragma mark - Interface

@interface InstaDetailsViewContoller ()

#pragma mark - Properties

@property (weak, nonatomic) IBOutlet UILabel *usernameLabelTop;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabelBot;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *instaImageView;

@end

#pragma mark - Implementation

@implementation InstaDetailsViewContoller

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpViews];
}

#pragma mark - Setup

- (void) setUpViews
{
    _profileImageView.layer.cornerRadius = _profileImageView.frame.size.width / 2;
    _usernameLabelBot.text = _post.username;
    _usernameLabelTop.text = _post.username;
    _captionLabel.text = _post.caption;
    
    typeof(self) __weak weakSelf = self;
    [_post.postImage getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) {
            return;
        }
        UIImage *const image = [UIImage imageWithData:data];
        [strongSelf.instaImageView setImage:image];
    }];
    
    _timestampLabel.text = _post.createdAtDateString;
}

@end
