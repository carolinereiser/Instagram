//
//  DetailsViewController.m
//  Instagram
//
//  Created by Caroline Reiser on 7/7/20.
//  Copyright © 2020 Caroline Reiser. All rights reserved.
//

#import "CommentsViewController.h"
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
    self.profilePic.file = self.post[@"author"][@"profilePic"];
    [self.profilePic loadInBackground];
    
    NSDate *createdAt = self.post.createdAt;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"E MMM d HH:mm:ss";

    NSString* dateString = [formatter stringFromDate:createdAt];

    self.timeStamp.text = dateString;
    
    self.likeCount.text = [NSString stringWithFormat:@"%@", self.post[@"likeCount"]];
}

- (void) refreshData
{
    self.likeCount.text = [NSString stringWithFormat:@"%@", self.post[@"likeCount"]];
}

- (IBAction)didLike:(id)sender {
    PFQuery *query = [PFQuery queryWithClassName:@"Likes"];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    [query whereKey:@"post" equalTo:self.post];
    query.limit = 1;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable users, NSError * _Nullable error) {
        if(users != nil)
        {
            if(users.count == 1)
            {
                PFQuery *query = [PFQuery queryWithClassName:@"Likes"];
                [query whereKey:@"user" equalTo:[PFUser currentUser]];
                [query whereKey:@"post" equalTo:self.post];
                query.limit = 1;
                [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable user, NSError * _Nullable error) {
                    if(user)
                    {
                        NSLog (@"Like removed");
                        [user[0] deleteInBackground];
                    }
                    else
                    {
                        NSLog (@"unable to retrieve like");
                    }
                }];
                
                NSNumber *currLikeCount = self.post.likeCount;
                int val = [currLikeCount intValue];
                val -= 1;
                self.post.likeCount = [NSNumber numberWithInt:val];
                [self refreshData];
            }
            else
            {
                PFObject *like = [PFObject objectWithClassName:@"Likes"];
                like[@"user"] = [PFUser currentUser];
                like[@"post"] = self.post;
                
                [like saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                  if (succeeded) {
                      NSLog(@"Like saved!");
                      [self refreshData];
                  } else {
                     NSLog(@"Error: %@", error.description);
                  }
                }];
                
                NSNumber *currLikeCount = self.post.likeCount;
                int val = [currLikeCount intValue];
                val += 1;
                self.post.likeCount = [NSNumber numberWithInt:val];
            }
        }
        else
        {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CommentsViewController *commentsViewController = [segue destinationViewController];
    Post *post = self.post;
    commentsViewController.post = post;
}


@end
