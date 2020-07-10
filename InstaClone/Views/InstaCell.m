//
//  InstaCell.m
//  InstaClone
//
//  Created by Alex Oseguera on 7/7/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "InstaCell.h"

#pragma mark - Implementation

@implementation InstaCell

#pragma mark - Lifecycle

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUpViews];
}

#pragma mark - Setup

- (void)setUpInstaCellWithPost:(Post *)post
{
    self.descriptionLabel.text = post.caption;
    self.usernameLabelTop.text = post.username;
    self.dateLabel.text = post.createdAtDateString;

    self.postImageView.image = nil;
    typeof(self) __weak weakSelf = self;
    [post.postImage getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        UIImage *const image = [UIImage imageWithData:data];
        [weakSelf.postImageView setImage:image];
    }];
}

- (void)setUpViews
{
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
}

@end
