//
//  PostCell.m
//  Instagram
//
//  Created by Caroline Reiser on 7/7/20.
//  Copyright © 2020 Caroline Reiser. All rights reserved.
//

#import "PostCell.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setPost:(Post *)post
{
    _post = post;
    
    self.picture.file = post[@"image"];
    [self.picture loadInBackground];
    
    self.caption.text = post[@"caption"];
    
    self.username.text = post[@"author"][@"username"];
    
    NSDate *createdAt = post.createdAt;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"E MMM d HH:mm:ss";

    NSString* dateString = [formatter stringFromDate:createdAt];
    
    self.timeStamp.text = [NSString stringWithFormat:@"Posted on %@", dateString];
    
    self.likeCount.text = [NSString stringWithFormat:@"%@", post[@"likeCount"]];
    
    [self.caption sizeToFit];
}
- (IBAction)pressedLike:(id)sender {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
