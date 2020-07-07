//
//  Post.h
//  InstaClone
//
//  Created by Alex Oseguera on 7/7/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parse/Parse.h"

#ifndef Post_h
#define Post_h

@interface Post : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString * _Nullable postID;

@property (nonatomic, strong) PFUser * _Nonnull author;

@property (nonatomic, strong) NSString * _Nonnull caption;
@property (nonatomic, strong) PFFileObject * _Nonnull image;
@property (nonatomic, strong) NSNumber * _Nonnull likeCount;
@property (nonatomic, strong) NSNumber * _Nonnull commentCount;
@property (nonatomic, strong) NSDate * _Nonnull createdAtDate; 

+ (void) postUserImage:(UIImage * _Nullable)image withCaption:(NSString * _Nullable)caption  withCompletion:(PFBooleanResultBlock  _Nullable)completion;
- (instancetype _Nonnull )initWithObjectId:(NSString *_Nonnull)objectId caption:(NSString *_Nonnull)caption author:(PFUser *_Nonnull)author commentCount:(NSNumber *_Nonnull)commentCount likeCount:(NSNumber *_Nonnull)likeCount image:(PFFileObject *_Nonnull)image createdAtDate:(NSDate *_Nonnull)createdAtDate;

@end

#endif /* Post_h */
