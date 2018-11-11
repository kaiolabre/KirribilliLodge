//
//  HomeViewController.h
//  Kirribili Lodge
//
//  Created by Kaio Labre on 13/10/18.
//  Copyright © 2018 Kaio Labre. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;

@interface HomeViewController : UIViewController
@property (nonatomic, retain) NSArray *arrData;
- (IBAction)didSelfCheckin:(id)sender;
@property(nonatomic, strong) NSString *user_email;
@property(nonatomic, strong) NSDate *today;
@property(nonatomic, strong) NSString *todayString;


@end
