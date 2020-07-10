//
//  CommentsViewController.h
//  Instagram
//
//  Created by Caroline Reiser on 7/10/20.
//  Copyright © 2020 Caroline Reiser. All rights reserved.
//
@import Parse;

#import "Parse/Parse.h"
#import "Post.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentsViewController : UIViewController
@property (weak, nonatomic) IBOutlet PFImageView *profilePic;
@property (weak, nonatomic) IBOutlet UITextField *comment;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) Post *post;

@end

NS_ASSUME_NONNULL_END
