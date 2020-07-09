//
//  DetailsViewController.m
//  Instagram
//
//  Created by Caroline Reiser on 7/7/20.
//  Copyright © 2020 Caroline Reiser. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.picture.file = self.post[@"image"];
    self.caption.text = self.post[@"caption"];
    self.username.text = self.post[@"author"][@"username"];
    NSDate *createdAt = self.post.createdAt;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"E MMM d HH:mm:ss";

    NSString* dateString = [formatter stringFromDate:createdAt];

    self.timeStamp.text = dateString;
    
    self.likeCount.text = [NSString stringWithFormat:@"%@", self.post[@"likeCount"]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
