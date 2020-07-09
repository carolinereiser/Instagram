//
//  Post.h
//  Instagram
//
//  Created by Caroline Reiser on 7/7/20.
//  Copyright © 2020 Caroline Reiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parse/Parse.h"
@interface Post : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString * _Nonnull postID;
@property (nonatomic, strong) NSString * _Nonnull userID;
@property (nonatomic, strong) PFUser * _Nonnull author;

@property (nonatomic, strong) NSString * _Nullable caption;
@property (nonatomic, strong) PFFileObject * _Nonnull image;
@property (nonatomic, strong) NSNumber * _Nonnull likeCount;
@property (nonatomic, strong) NSNumber * _Nonnull commentCount;


+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end

