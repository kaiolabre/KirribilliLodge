//
//  EditUserInfoViewController.h
//  Kirribili Lodge
//
//  Created by Kaio Labre on 13/10/18.
//  Copyright © 2018 Kaio Labre. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;

@interface EditUserInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
- (IBAction)didUpdateUser:(id)sender;

@end
