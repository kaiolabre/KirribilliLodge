//
//  HomeViewController.m
//  Kirribili Lodge
//
//  Created by Kaio Labre on 13/10/18.
//  Copyright © 2018 Kaio Labre. All rights reserved.
//

#import "HomeViewController.h"
@import Firebase;
@interface HomeViewController ()
@property(strong, nonatomic) FIRAuthStateDidChangeListenerHandle handle;
@property (nonatomic, readwrite) FIRFirestore *db;
@end

@implementation HomeViewController


@synthesize user_email, today, todayString;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.db = [FIRFirestore firestore];
    
    FIRUser *user = [FIRAuth auth].currentUser;
    if (user) {
        // The user's ID, unique to the Firebase project.
        // Do NOT use this value to authenticate with your backend server,
        // if you have one. Use getTokenWithCompletion:completion: instead.
        self.user_email = user.email;
        // ...
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didSelfCheckin:(id)sender {
    
    NSDateFormatter *inDateFormatter = [[NSDateFormatter alloc] init];
    [inDateFormatter setFormatterBehavior:NSDateFormatterBehaviorDefault];
    [inDateFormatter setDateStyle:NSDateFormatterShortStyle];
    [inDateFormatter setTimeStyle:NSDateFormatterNoStyle];
    self.todayString = [inDateFormatter stringFromDate:[NSDate date]];
    
    [[[self.db collectionWithPath:[self user_email]] queryWhereField:@"date_in" isEqualTo:[self todayString]]
     getDocumentsWithCompletion:^(FIRQuerySnapshot *snapshot, NSError *error) {
         if (error != nil) {
             // Normal Alert
             UIAlertController *alert = [UIAlertController
                                         alertControllerWithTitle:@"Error"
                                         message:@"Could not connect to the database."
                                         preferredStyle:UIAlertControllerStyleAlert];
             
             
             // Add OK Action
             UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                 
                 
                 [self presentViewController:alert animated:YES completion:nil];
             }];
             
             [alert addAction:ok];
             
             [self presentViewController:alert animated:YES completion:nil];
             
             return;
         }
         else if (snapshot.isEmpty) {
             // Normal Alert
             UIAlertController *alert = [UIAlertController
                                         alertControllerWithTitle:@"Self Check-in Unsuccessful!"
                                         message:@"You have no bookings for today."
                                         preferredStyle:UIAlertControllerStyleAlert];
             
             
             // Add OK Action
             UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                
                 //push home page
                 NSString * storyboardName = @"Main";
                 UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
                 UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"HomePage"];
                 [self presentViewController:vc animated:YES completion:nil];
                 [self presentViewController:alert animated:YES completion:nil];
             }];
             
             [alert addAction:ok];
             
             [self presentViewController:alert animated:YES completion:nil];
             
             return;
         }
         else {
             
             //push home page
             NSString * storyboardName = @"Main";
             UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
             UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"SelfCheckin"];
             [self presentViewController:vc animated:YES completion:nil];
         }
     }];
}
@end
