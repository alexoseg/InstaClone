//
//  PostBuilder.m
//  InstaClone
//
//  Created by Alex Oseguera on 7/9/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "PostBuilder.h"

static NSString *const kAuthor = @"author";
static NSString *const kCaption = @"caption";
static NSString *const kCommentCount = @"commentCount";
static NSString *const kImage = @"image";
static NSString *const kLikeCount = @"likeCount";

@implementation PostBuilder

+ (Post *)buildPostFromPFObject:(PFObject *)object {
    
    PFUser *const author = object[kAuthor];
    NSString *const username = author.username;
    NSString *const objectId = object.objectId;
    NSString *const caption = object[kCaption];
    NSNumber *const commentCount = object[kCommentCount];
    NSNumber *const likeCount = object[kLikeCount];
    PFFileObject *const postImage = object[kImage];
    NSDate *const createdAt = object.createdAt;
    
    if (author == nil
        || username == nil
        || objectId == nil
        || caption == nil
        || commentCount == nil
        || likeCount == nil
        || postImage == nil
        || createdAt == nil){
        return nil;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, yyyy"];
    NSString *const formattedDateString = [formatter stringFromDate:createdAt];
    
    return [[Post alloc] initWithPostId:objectId
                               username:username
                                caption:caption
                              postImage:postImage
                              likeCount:likeCount
                           commentCount:commentCount
                    createdAtDateString:formattedDateString];
}

+ (void)buildParsePostFrom:(UIImage *)postImage caption:(NSString *)caption withCompletion:(PFBooleanResultBlock)completion {
    
    PFObject *post = [PFObject objectWithClassName:@"Post"];
    NSData *imageData = UIImagePNGRepresentation(postImage);
    post[kImage] = [PFFileObject fileObjectWithName:@"image.png" data:imageData];
    post[kCaption] = caption;
    post[kAuthor] = PFUser.currentUser;
    post[kLikeCount] = @(0);
    post[kCommentCount] = @(0);
    
    [post saveInBackgroundWithBlock:completion]; 
}

@end
