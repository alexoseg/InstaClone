//
//  ParseGetter.h
//  InstaClone
//
//  Created by Alex Oseguera on 7/9/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface ParseGetter : NSObject

+ (void)fetchAllPostsWithCompletion:(void (^)(NSArray * _Nullable objects, NSError * _Nullable error))completion;

+ (void)fetchPostsBefore:(NSDate *)createdAtDate
          withCompletion:(void (^)(NSArray * _Nullable objects, NSError * _Nullable error))completion;

+ (void)fetchPostsFromCurrentUserWithCompletion:(void (^)(NSArray * _Nullable objects, NSError * _Nullable error))completion;

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
