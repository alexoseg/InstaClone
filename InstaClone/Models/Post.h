//
//  Post.h
//  InstaClone
//
//  Created by Alex Oseguera on 7/7/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@interface Post : NSObject

@property (nonatomic, strong) NSString *postID;
@property (nonatomic, strong) PFUser *author;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) PFFileObject *postImage;
@property (nonatomic, strong) NSNumber *likeCount;
@property (nonatomic, strong) NSNumber *commentCount;
@property (nonatomic, strong) NSString *createdAtDateString;

- (instancetype)initWithPostId:(NSString *)postId
                        username:(NSString *)username
                         caption:(NSString *)caption
                       postImage:(PFFileObject *)postImage
                       likeCount:(NSNumber *)likeCount
                    commentCount:(NSNumber *)commentCount
                   createdAtDateString:(NSString *)createdAtDateString;

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
