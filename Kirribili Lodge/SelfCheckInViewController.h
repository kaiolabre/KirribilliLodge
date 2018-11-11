//
//  SelfCheckInViewController.h
//  Kirribili Lodge
//
//  Created by Kaio Labre on 14/10/18.
//  Copyright © 2018 Kaio Labre. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;

@interface SelfCheckInViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property(nonatomic, strong) NSString *user_email;
@property (nonatomic, strong) NSDate *today;
@property(nonatomic, strong) NSString *todayString;
@property(nonatomic, strong) NSString *documentID;

@end
