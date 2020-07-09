//
//  PostCell.h
//  Instagram
//
//  Created by Caroline Reiser on 7/7/20.
//  Copyright © 2020 Caroline Reiser. All rights reserved.
//

@import Parse;
#import "Post.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet UILabel *caption;
@property (weak, nonatomic) IBOutlet PFImageView *picture;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *timeStamp;


@property (strong, nonatomic) Post *post;
-(void) setPost:(Post *)post;

@end

NS_ASSUME_NONNULL_END
