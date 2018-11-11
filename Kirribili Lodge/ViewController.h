//
//  ViewController.h
//  Kirribili Lodge
//
//  Created by Kaio Labre on 4/9/18.
//  Copyright © 2018 Kaio Labre. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;


- (IBAction)didCreateAccount:(id)sender;
@end

