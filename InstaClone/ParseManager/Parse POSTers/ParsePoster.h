//
//  ParsePoster.h
//  InstaClone
//
//  Created by Alex Oseguera on 7/9/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface ParsePoster : NSObject

+ (void)parsePostFrom:(UIImage *)postImage
                   caption:(NSString *)caption
            withCompletion:(PFBooleanResultBlock  _Nullable)completion;

+ (void)createAccountWithUsername:(NSString *)username
                         password:(NSString *)password
                   withCompletion:(PFBooleanResultBlock  _Nullable)completion;

+ (void)loginAccountWithUsername:(NSString *)username
                        password:(NSString *)password
                  withCompletion:(void (^)(PFUser * _Nullable user, NSError * _Nullable error))completion;

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
