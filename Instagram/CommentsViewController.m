//
//  CommentsViewController.m
//  Instagram
//
//  Created by Caroline Reiser on 7/10/20.
//  Copyright © 2020 Caroline Reiser. All rights reserved.
//
@import MBProgressHUD;

#import "CommentCell.h"
#import "CommentsViewController.h"

@interface CommentsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray* comments;

@end

@implementation CommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self fetchComments];
    [self.tableView reloadData];
    // Do any additional setup after loading the view.
    self.profilePic.file = [PFUser currentUser][@"profilePic"];
    [self.profilePic loadInBackground];
    
}

- (void) fetchComments
{
    PFQuery *query = [PFQuery queryWithClassName:@"Comments"];
    [query orderByAscending:@"createdAt"];
    [query whereKey:@"post" equalTo:self.post];
    [query includeKey:@"user"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable comments, NSError * _Nullable error) {
        if(comments != nil)
        {
            self.comments = comments;
            NSLog(@"%@", self.comments);
            [self.tableView reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
        else
        {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}
- (IBAction)didTap:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)sendComment:(id)sender {
    if([self.comment.text isKindOfClass:[NSString class]])
    {
        PFObject *comment = [PFObject objectWithClassName:@"Comments"];
        comment[@"user"] = [PFUser currentUser];
        comment[@"post"] = self.post;
        comment[@"text"] = self.comment.text;
        
        [comment saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if(succeeded)
            {
                NSLog(@"Successfully commented!");
                [self fetchComments];
            }
            else
            {
                NSLog(@"%@", error.localizedDescription);
            }
        }];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"CommentCell"  forIndexPath:indexPath];
    
    NSLog(@"%@", self.comments);
    
    cell.profilePic.file = self.comments[indexPath.row][@"user"][@"profilePic"];
    [cell.profilePic loadInBackground];
    cell.username.text = self.comments[indexPath.row][@"user"][@"username"];
    cell.comment.text = self.comments[indexPath.row][@"text"];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.comments.count;
}

- (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
 
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
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
