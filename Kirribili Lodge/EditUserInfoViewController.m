//
//  EditUserInfoViewController.m
//  Kirribili Lodge
//
//  Created by Kaio Labre on 13/10/18.
//  Copyright © 2018 Kaio Labre. All rights reserved.
//

#import "EditUserInfoViewController.h"
@import Firebase;

@interface EditUserInfoViewController ()

@end

@implementation EditUserInfoViewController
@synthesize emailField, passwordField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
//signInWithEmail:[emailField text]
//password:[passwordField text]
- (IBAction)didUpdateUser:(id)sender {
    
    [[FIRAuth auth].currentUser updateEmail:[emailField text] completion:^(NSError *_Nullable error) {
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
            self.emailField.text = @"";
            self.passwordField.text = @"";
            return;
        }
    }];
    
    [[FIRAuth auth].currentUser updatePassword:[passwordField text] completion:^(NSError *_Nullable error) {
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
            self.emailField.text = @"";
            self.passwordField.text = @"";
            return;
        }
        
    }];
    
    // Normal Alert
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"Success"
                                message:@"Information Updated"
                                preferredStyle:UIAlertControllerStyleAlert];
    
    // Add OK Action
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    self.emailField.text = @"";
    self.passwordField.text = @"";
    
}
@end
