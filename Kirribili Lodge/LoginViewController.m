//
//  LoginViewController.m
//  Kirribili Lodge
//
//  Created by Kaio Labre on 13/10/18.
//  Copyright © 2018 Kaio Labre. All rights reserved.
//

#import "LoginViewController.h"
@import Firebase;

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize  emailField, passwordField;

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)viewWillAppear:(BOOL)animated {
    // Normal Alert
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"Welcome"
                                message:@"Please Login"
                                preferredStyle:UIAlertControllerStyleAlert];
    
    // Add OK Action
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didTapEmailLogin:(id)sender {
    [[FIRAuth auth] signInWithEmail:[emailField text]
                           password:[passwordField text]
                         completion:^(FIRAuthDataResult * _Nullable authResult,
                                      NSError * _Nullable error) {
                             if(error) {
                                 // Normal Alert
                                 UIAlertController *alert = [UIAlertController
                                                             alertControllerWithTitle:@"Login Error"
                                                             message:error.localizedDescription
                                                             preferredStyle:UIAlertControllerStyleAlert];
                                 
                                 // Add OK Action
                                 UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                 }];
                                 
                                 [alert addAction:ok];
                                 
                                 [self presentViewController:alert animated:YES completion:nil];
                                 
                                 return;
                             }
                             
                             
                             //push home page
                             NSString * storyboardName = @"Main";
                             UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
                             UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"HomePage"];
                             [self presentViewController:vc animated:YES completion:nil];
                             
                         }];
}
@end
