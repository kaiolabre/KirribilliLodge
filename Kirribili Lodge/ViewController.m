//
//  ViewController.m
//  Kirribili Lodge
//
//  Created by Kaio Labre on 4/9/18.
//  Copyright © 2018 Kaio Labre. All rights reserved.
//

#import "ViewController.h"

@import Firebase;
@interface ViewController ()

@end

@implementation ViewController

@synthesize  emailField, passwordField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didCreateAccount:(id)sender {
    [[FIRAuth auth] createUserWithEmail:[emailField text]
                               password:[passwordField text]
                             completion:^(FIRAuthDataResult * _Nullable authResult,
                                          NSError * _Nullable error) {
                                 if(error) {
                                     // Normal Alert
                                     UIAlertController *alert = [UIAlertController
                                                                 alertControllerWithTitle:@"Register Error"
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
                                 
                                 //push login page
                                 NSString * storyboardName = @"Main";
                                 UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
                                 UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"LoginPage"];
                                 [self presentViewController:vc animated:YES completion:nil];
                                 
                                 
                             }];
}



@end
