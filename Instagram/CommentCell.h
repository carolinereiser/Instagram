//
//  CommentCell.h
//  Instagram
//
//  Created by Caroline Reiser on 7/10/20.
//  Copyright © 2020 Caroline Reiser. All rights reserved.
//
@import Parse;

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet PFImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *comment;

@end

NS_ASSUME_NONNULL_END
