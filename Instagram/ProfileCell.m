//
//  ProfileCell.m
//  Instagram
//
//  Created by Caroline Reiser on 7/9/20.
//  Copyright © 2020 Caroline Reiser. All rights reserved.
//

#import "ProfileCell.h"


@implementation ProfileCell

- (void)setPost:(Post *)post
{
    _post = post;
    
    self.picture.file = post[@"image"];
    [self.picture loadInBackground];
}


@end
