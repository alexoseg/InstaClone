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

//Tells the compiler that the getters and setters are implemented not by the class itself
@dynamic postID; 
@dynamic author;
@dynamic caption;
@dynamic image;
@dynamic likeCount;
@dynamic commentCount;

- (instancetype)initWithObjectId:(NSString *)objectId caption:(NSString *)caption author:(PFUser *)author commentCount:(NSNumber *)commentCount likeCount:(NSNumber *)likeCount image:(PFFileObject *)image{
    Post *post = [Post new];
    post.objectId = objectId;
    post.caption = caption;
    post.author = author;
    post.commentCount = commentCount;
    post.likeCount = likeCount;
    post.image = image;
    
    return post;
}

+ (nonnull NSString *)parseClassName {
    return @"Post";
}

+ (void) postUserImage:(UIImage * _Nullable)image withCaption:(NSString * _Nullable)caption  withCompletion:(PFBooleanResultBlock  _Nullable)completion{
    Post *newPost = [Post new];
    newPost.image = [self getPFFileFromImage:image];
    newPost.author = [PFUser currentUser];
    newPost.caption = caption;
    newPost.likeCount = @(0);
    newPost.commentCount = @(0);
       
    [newPost saveInBackgroundWithBlock: completion];
}

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
 
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

@end
