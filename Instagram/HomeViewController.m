//
//  HomeViewController.m
//  Instagram
//
//  Created by Caroline Reiser on 7/7/20.
//  Copyright © 2020 Caroline Reiser. All rights reserved.
//

@import MBProgressHUD;

#import "DetailsViewController.h"
#import "HomeViewController.h"
#import <Parse/Parse.h>
#import "Post.h"
#import "PostCell.h"
#import "ProfileViewController.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray<Post *>* posts;
@property (nonatomic) int postLimit;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view.
    
    self.postLimit = 20;
    
    UIImage *img = [UIImage imageNamed:@"instagram-writing"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [imgView setImage:img];
    // setContent mode aspect fit
    [imgView setContentMode:UIViewContentModeScaleAspectFit];
    self.navigationItem.titleView = imgView;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    [self fetchPosts];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (void)fetchPosts {
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    query.limit = self.postLimit;

    // fetch data asynchronously
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            self.posts = posts;
            //NSLog(@"%@", self.posts);
            [self.tableView reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            self.isMoreDataLoading = false;
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    [self.refreshControl endRefreshing];
}

- (void) fetchMorePosts{
    self.postLimit += 20;
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    //is this right????
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    query.limit = self.postLimit;

    // fetch data asynchronously
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            self.posts = posts;
            //NSLog(@"%@", self.posts);
            [self.tableView reloadData];
            self.isMoreDataLoading = false;
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
     // Handle scroll behavior here
    if(!self.isMoreDataLoading){
       if(!self.isMoreDataLoading){
           // Calculate the position of one screen length before the bottom of the results
           int scrollViewContentHeight = self.tableView.contentSize.height;
           int scrollOffsetThreshold = scrollViewContentHeight - self.tableView.bounds.size.height;
           
           // When the user has scrolled past the threshold, start requesting
           if(scrollView.contentOffset.y > scrollOffsetThreshold && self.tableView.isDragging) {
               self.isMoreDataLoading = true;
               [self fetchMorePosts];
           }
       }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PostCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    Post* myPost = self.posts[indexPath.row];
    cell.button.tag = indexPath.row;
    cell.profileButton.tag = indexPath.row;
    [cell setPost:myPost];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.posts.count;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue identifier] isEqualToString:@"detailsSegue"])
    {
        UIButton *tappedButton = sender;
        DetailsViewController *detailsViewController = [segue destinationViewController];
        Post *post = self.posts[tappedButton.tag];
        detailsViewController.post = post;
    }
    else if([[segue identifier] isEqualToString:@"profileSegue"])
    {
        UIButton *tappedButton = sender;
         ProfileViewController *profileViewController = [segue destinationViewController];
         PFUser *user = self.posts[tappedButton.tag][@"author"];
         profileViewController.user = user;
    }
}


@end
