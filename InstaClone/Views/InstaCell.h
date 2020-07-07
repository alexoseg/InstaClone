//
//  InstaCell.h
//  InstaClone
//
//  Created by Alex Oseguera on 7/7/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InstaCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

NS_ASSUME_NONNULL_END
