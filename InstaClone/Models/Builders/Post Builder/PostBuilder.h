//
//  PostBuilder.h
//  InstaClone
//
//  Created by Alex Oseguera on 7/9/20.
//  Copyright © 2020 Alex Oseguera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Post.h"
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface PostBuilder : NSObject

+ (nullable Post *)buildPostFromPFObject:(PFObject *)object;

@end

NS_ASSUME_NONNULL_END
