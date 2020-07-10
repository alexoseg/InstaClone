//
//  ParseGetter.m
//  InstaClone
//
//  Created by Alex Oseguera on 7/9/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import "ParseGetter.h"

@implementation ParseGetter

static NSString *const kCaption = @"caption";
static NSString *const kCommentCount = @"commentCount";
static NSString *const kLikeCount = @"likeCount";
static NSString *const kImage = @"image";
static NSString *const kAuthor = @"author";
static NSString *const kCreatedAt = @"createdAt";
static NSString *const kClassName = @"Post";
static NSInteger const kQueryLimit = 20;

+ (void)fetchAllPostsWithCompletion:(void (^)(NSArray * _Nullable objects, NSError * _Nullable error))completion {
    
    PFQuery *const query = [PFQuery queryWithClassName:kClassName];
    [query includeKey:kCaption];
    [query includeKey:kCommentCount];
    [query includeKey:kLikeCount];
    [query includeKey:kImage];
    [query includeKey:kAuthor];
    
    [query orderByDescending:kCreatedAt];
    query.limit = kQueryLimit;
    
    [query findObjectsInBackgroundWithBlock:completion];
}

+ (void)fetchPostsBefore:(NSDate *)createdAtDate
          withCompletion:(void (^)(NSArray * _Nullable objects, NSError * _Nullable error))completion {
    
    PFQuery *const query = [PFQuery queryWithClassName:kClassName];
    [query includeKey:kCaption];
    [query includeKey:kCommentCount];
    [query includeKey:kLikeCount];
    [query includeKey:kImage];
    [query includeKey:kAuthor];
    
    [query whereKey:kCreatedAt lessThan:createdAtDate];
    [query orderByDescending:kCreatedAt];
    query.limit = kQueryLimit;
    
    [query findObjectsInBackgroundWithBlock:completion];
}

+ (void)fetchPostsFromCurrentUserWithCompletion:(void (^)(NSArray * _Nullable, NSError * _Nullable))completion {
    
    PFQuery *const query = [PFQuery queryWithClassName:kClassName];
    [query whereKey:kAuthor equalTo:[PFUser currentUser]];
    
    [query includeKey:kCaption];
    [query includeKey:kCommentCount];
    [query includeKey:kLikeCount];
    [query includeKey:kImage];
    [query includeKey:kAuthor];
    
    [query orderByDescending:kCreatedAt];
    query.limit = kQueryLimit;
    
    [query findObjectsInBackgroundWithBlock:completion];
}

@end
