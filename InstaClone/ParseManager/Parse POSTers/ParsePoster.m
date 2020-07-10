//
//  ParsePoster.m
//  InstaClone
//
//  Created by Alex Oseguera on 7/9/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "ParsePoster.h"

static NSString *const kAuthor = @"author";
static NSString *const kCaption = @"caption";
static NSString *const kCommentCount = @"commentCount";
static NSString *const kImage = @"image";
static NSString *const kLikeCount = @"likeCount";

@implementation ParsePoster

+ (void)parsePostFrom:(UIImage *)postImage
              caption:(NSString *)caption
       withCompletion:(PFBooleanResultBlock)completion{
    
    PFObject *post = [PFObject objectWithClassName:@"Post"];
    NSData *imageData = UIImagePNGRepresentation(postImage);
    post[kImage] = [PFFileObject fileObjectWithName:@"image.png" data:imageData];
    post[kCaption] = caption;
    post[kAuthor] = PFUser.currentUser;
    post[kLikeCount] = @(0);
    post[kCommentCount] = @(0);
    
    [post saveInBackgroundWithBlock:completion]; 
}

+ (void)createAccountWithUsername:(NSString *)username
                         password:(NSString *)password
                   withCompletion:(PFBooleanResultBlock)completion {
    
    PFUser *newUser = [PFUser user];
    newUser.username = [username copy];
    newUser.password = [password copy];
    [newUser signUpInBackgroundWithBlock:completion];
}

+ (void)loginAccountWithUsername:(NSString *)username
                        password:(NSString *)password
                  withCompletion:(void (^)(PFUser * _Nullable, NSError * _Nullable))completion {
    
    NSString *const copyUsername = [username copy];
    NSString *const copyPassword = [password copy];
    
    [PFUser logInWithUsernameInBackground:copyUsername password:copyPassword block:completion];
}

@end
