//
//  BookNowViewController.h
//  Kirribili Lodge
//
//  Created by Kaio Labre on 14/10/18.
//  Copyright © 2018 Kaio Labre. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;

@interface BookNowViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIDatePicker *inDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *outDatePicker;

//changed to "BOOK NOW" meaning (reducing scope)
- (IBAction)didCheckAvailability:(id)sender;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

//Date Handling Variables
@property(nonatomic, strong) NSDate *inMinimumDate;
@property(nonatomic, strong) NSDate *outMinimumDate;

//Booking Variables
@property(nonatomic, strong) NSDate *inDate;
@property(nonatomic, strong) NSDate *today;
@property(nonatomic, strong) NSDate *outDate;
@property(nonatomic, strong) NSString *inDateString;
@property(nonatomic, strong) NSString *outDateString;
@property(nonatomic, strong) NSString *user_email;
@property (nonatomic, assign) NSInteger checkin_code;
 
//------------------REDUCED SCOPE

//@property (weak, nonatomic) IBOutlet UILabel *rmTypeLabel;
//@property (weak, nonatomic) IBOutlet UILabel *inDateLabel;
//@property (weak, nonatomic) IBOutlet UILabel *outDateLabel;
//@property (weak, nonatomic) IBOutlet UILabel *nightLabel;
//@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
//@property (weak, nonatomic) IBOutlet UIButton *didBookNow;
//@property(nonatomic, strong) NSString *roomType;

//- (IBAction)didNext:(id)sender;
//- (IBAction)didBookNow:(id)sender;


//test
//@property (weak, nonatomic) IBOutlet UILabel *pickerLabel;

@end
