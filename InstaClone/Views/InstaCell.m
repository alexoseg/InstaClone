//
//  InstaCell.m
//  InstaClone
//
//  Created by Alex Oseguera on 7/7/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "InstaCell.h"

@implementation InstaCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
}

- (void)setUpInstaCellWithPost:(Post *)post{
    self.descriptionLabel.text = post.caption;
    NSLog(@"%@", post.caption);
    self.usernameLabelTop.text = post.author.username;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, yyyy"];
    self.dateLabel.text = [formatter stringFromDate:post.createdAtDate];

    self.postImageView.image = nil;
    typeof(self) __weak weakSelf = self;
    [post.image getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        UIImage *image = [UIImage imageWithData:data];
        [weakSelf.postImageView setImage:image];
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
