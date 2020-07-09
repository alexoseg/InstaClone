//
//  Post.m
//  InstaClone
//
//  Created by Alex Oseguera on 7/7/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Post.h"

@implementation Post

- (instancetype)initWithPostId:(NSString *)postId
                      username:(NSString *)username
                       caption:(NSString *)caption
                     postImage:(PFFileObject *)postImage
                     likeCount:(NSNumber *)likeCount
                  commentCount:(NSNumber *)commentCount
           createdAtDateString:(NSString *)createdAtDateString {
    
    self = [super init];
    
    if (self) {
        _postID = postId;
        _username = username;
        _caption = caption;
        _postImage = postImage;
        _likeCount = likeCount;
        _commentCount = commentCount;
        _createdAtDateString = createdAtDateString;
    }
    
    return self; 
}

@end
