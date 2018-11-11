//
//  PersonalInfoViewController.m
//  Kirribili Lodge
//
//  Created by Kaio Labre on 13/10/18.
//  Copyright © 2018 Kaio Labre. All rights reserved.
//

#import "PersonalInfoViewController.h"
@import Firebase;

@interface PersonalInfoViewController ()
@property(strong, nonatomic) FIRAuthStateDidChangeListenerHandle handle;


@end

@implementation PersonalInfoViewController
@synthesize emailLabel, passwordLabel;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FIRUser *user = [FIRAuth auth].currentUser;
    if (user) {
        // The user's ID, unique to the Firebase project.
        // Do NOT use this value to authenticate with your backend server,
        // if you have one. Use getTokenWithCompletion:completion: instead.
        //NSString *email = user.email;
        // ...
    }
    
    self.handle = [[FIRAuth auth]
                   addAuthStateDidChangeListener:^(FIRAuth *_Nonnull auth, FIRUser *_Nullable user) {
                       // [START_EXCLUDE]
                       [self setTitleDisplay:user];
                       // [END_EXCLUDE]
                   }];
}
- (void)setTitleDisplay: (FIRUser *)user {
    if (user.email) {
        self.emailLabel.text = user.email;
    } else {
        // Normal Alert
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:@"User Error"
                                    message:@"Could not get user email."
                                    preferredStyle:UIAlertControllerStyleAlert];
        
        // Add OK Action
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
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

- (IBAction)didDeleteAccount:(id)sender {
    
    FIRUser *user = [FIRAuth auth].currentUser;
    
    [user deleteWithCompletion:^(NSError *_Nullable error) {
        if (error) {
            // An error happened.
        } else {
            // Normal Alert
            UIAlertController *alert = [UIAlertController
                                        alertControllerWithTitle:@"Account Deleted"
                                        message:@"Please login."
                                        preferredStyle:UIAlertControllerStyleAlert];
            
            // Add OK Action
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //push login page
                NSString * storyboardName = @"Main";
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
                UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"LoginPage"];
                [self presentViewController:vc animated:YES completion:nil];
                [alert dismissViewControllerAnimated:YES completion:nil];
            }];
            
            [alert addAction:ok];
            
            [self presentViewController:alert animated:YES completion:nil];
            
            return;
        }
    }];
    
}
@end
