//
//  LoginViewController.m
//  Instagram
//
//  Created by Caroline Reiser on 7/7/20.
//  Copyright © 2020 Caroline Reiser. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)onTap:(id)sender {
     [self.view endEditing:YES];
}
- (IBAction)logIn:(id)sender {
    if([self validFields])
       {
           NSString *username = self.username.text;
           NSString *password = self.password.text;
           
           [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
               if (error != nil) {
                   NSLog(@"User log in failed: %@", error.localizedDescription);
                   UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error Logging In" message:@"Username and/or password doesn't exist or doesn't match." preferredStyle:(UIAlertControllerStyleAlert)];
                        
                        // create a cancel action
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        // handle cancel response here. Doing nothing will dismiss the view.
                                                                          }];
                        // add the cancel action to the alertController
                        [alert addAction:okAction];

                        
                        [self presentViewController:alert animated:YES completion:^{
                            // optional code for what happens after the alert controller has finished presenting
                        }];
               } else {
                   NSLog(@"User logged in successfully");
                   
                   // display view controller that needs to shown after successful login
                   
                   // manually segue to logged in view
                   [self performSegueWithIdentifier:@"loginSegue" sender:nil];

                   }
           }];
       }
}

- (BOOL)validFields{
    if([self.username.text isEqual:@""] || [self.password.text isEqual:@""])
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Username and/or Password required" message:@"You must fill in a username and password" preferredStyle:(UIAlertControllerStyleAlert)];
        
        // create a cancel action
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // handle cancel response here. Doing nothing will dismiss the view.
                                                          }];
        // add the cancel action to the alertController
        [alert addAction:okAction];

        
        [self presentViewController:alert animated:YES completion:^{
            // optional code for what happens after the alert controller has finished presenting
        }];
        return NO;
    }
    return YES;
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
