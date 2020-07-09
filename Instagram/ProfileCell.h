//
//  ProfileCell.h
//  Instagram
//
//  Created by Caroline Reiser on 7/9/20.
//  Copyright © 2020 Caroline Reiser. All rights reserved.
//

@import Parse;
#import "Post.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet PFImageView *picture;
@property (weak, nonatomic) Post* post;

@end

NS_ASSUME_NONNULL_END
