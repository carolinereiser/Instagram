//
//  ProfileViewController.m
//  Instagram
//
//  Created by Caroline Reiser on 7/8/20.
//  Copyright © 2020 Caroline Reiser. All rights reserved.
//
@import MBProgressHUD;

#import "DetailsViewController.h"
#import "Post.h"
#import "ProfileCell.h"
#import "ProfileViewController.h"

@interface ProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSArray<Post *>* posts;
@property (nonatomic) int postLimit;
@property (assign, nonatomic) BOOL isMoreDataLoading;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
        
    if(!self.user)
    {
        self.user = [PFUser currentUser];
    }
    self.username.text = self.user.username;
    
    self.profilePic.file = self.user[@"profilePic"];
    [self.profilePic loadInBackground];
    
    self.postLimit = 20;
    
    [self fetchUserPosts];
    
    self.collectionView.frame = self.view.frame;
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
        
    layout.minimumInteritemSpacing = 2;
    layout.minimumLineSpacing = 2;
    
    CGFloat imagesPerLine = 3;
    CGFloat itemWidth = (self.collectionView.frame.size.width - (layout.minimumInteritemSpacing * (imagesPerLine - 1))) / imagesPerLine;
    CGFloat itemHeight = itemWidth;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
}

- (void)fetchUserPosts
{
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query whereKey:@"author" equalTo:self.user];
    [query includeKey:@"author"];
    query.limit = self.postLimit;

    // fetch data asynchronously
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            self.posts = posts;
            NSLog(@"%@", self.posts);
            [self.collectionView reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            self.isMoreDataLoading = false;
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

/*
- (void) fetchMoreUserPosts{
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
            [self.collectionView reloadData];
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
           int scrollViewContentHeight = self.collectionView.contentSize.height;
           int scrollOffsetThreshold = scrollViewContentHeight - self.collectionView.bounds.size.height;
           
           // When the user has scrolled past the threshold, start requesting
           if(scrollView.contentOffset.y > scrollOffsetThreshold && self.collectionView.isDragging) {
               self.isMoreDataLoading = true;
               [self fetchMoreUserPosts];
           }
       }
    }
}
*/


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ProfileCell* cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ProfileCell" forIndexPath:indexPath];
    
    Post* myPost = self.posts[indexPath.row];
    [cell setPost:myPost];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.posts.count;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue identifier] isEqualToString:@"detailsSegue"])
    {
        UICollectionViewCell *tappedCell = sender;
        DetailsViewController *detailsViewController = [segue destinationViewController];
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:tappedCell];
        Post *post = self.posts[indexPath.item];
        detailsViewController.post = post;
    }
}




@end
