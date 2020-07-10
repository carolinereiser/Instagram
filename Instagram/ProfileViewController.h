//
//  ProfileViewController.h
//  Instagram
//
//  Created by Caroline Reiser on 7/8/20.
//  Copyright © 2020 Caroline Reiser. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet PFImageView *profilePic;

@property (weak, nonatomic) PFUser *user;
 
@end

NS_ASSUME_NONNULL_END
