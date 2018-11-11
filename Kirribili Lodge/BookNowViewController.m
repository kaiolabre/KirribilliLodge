//
//  BookNowViewController.m
//  Kirribili Lodge
//
//  Created by Kaio Labre on 14/10/18.
//  Copyright © 2018 Kaio Labre. All rights reserved.
//

#import "BookNowViewController.h"
#include <stdlib.h>
@import Firebase;

@interface BookNowViewController ()
@property(strong, nonatomic) FIRAuthStateDidChangeListenerHandle handle;
@property (nonatomic, readwrite) FIRFirestore *db;
@property (nonatomic, strong) NSString *code;
@end

@implementation BookNowViewController

@synthesize inDatePicker, outDatePicker,                        //picker views
            inMinimumDate, outMinimumDate,                                  //date picker result
            inDate, outDate,inDateString, outDateString, user_email, checkin_code;                    //dbooking handing
            //roomType, today, pickerView,                                  /variables
            //rmTypeLabel, inDateLabel, outDateLabel,nightLabel,priceLabel;   //labels to be updated

int totalDays,totalPrice;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.db = [FIRFirestore firestore];
    
    FIRUser *user = [FIRAuth auth].currentUser;
    if (user) {
        // The user's ID, unique to the Firebase project.
        // Do NOT use this value to authenticate with your backend server,
        // if you have one. Use getTokenWithCompletion:completion: instead.
        self.user_email = user.email;
        // ...
    }
    
    
    /*   REDUCING SCOPE
    // Do any additional setup after loading the view.
    [inDatePicker addTarget:self action:@selector(changeOutDatePickerMinimumDate:) forControlEvents:UIControlEventValueChanged];
    //populate roomtype picker
    _pickerData = @[@[@"Single Room - Shared Bathroom", @"Single Room - Private Bathroom", @"Double Room - Shared Bathroom", @"Double Room - Shared Bathroom"]];
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;*/
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//------------------Date Picker View
-(IBAction)changeOutDatePickerMinimumDate:(id)sender{
    outMinimumDate = self.inDatePicker.date;
    
    outDatePicker.minimumDate = outMinimumDate;
}

- (IBAction)didCheckAvailability:(id)sender {
    
    //if all correct
    self.inDate = self.inDatePicker.date;
    self.outDate = self.outDatePicker.date;
    
    
    //cant get this is statement to be true!!!!!!!!!!!!!!!!!!!!!!!!!!!
    if(([inDate compare: [self today]] == NSOrderedDescending)){
        // Normal Alert
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:@"Error"
                                    message:@"You can only book rooms from today."
                                    preferredStyle:UIAlertControllerStyleAlert];
        
        // Add OK Action
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    
    
    
    //if(([startDate1 compare:[self getDefaultDate]] == NSOrderedSame) || ([startDate1 compare: [self getDefaultDate]] != NSOrderedSame && (([m_selectedDate compare: m_currentDate1] == NSOrderedDescending) || [m_selectedDate compare: m_currentDate1] == NSOrderedSame) && cycleStopped))
    
    else if (([inDate compare: [self outDate]] == NSOrderedDescending) ||
             ([outDate compare: [self inDate]] == NSOrderedSame))
    {
        // Normal Alert
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:@"Error"
                                    message:@"You must stay at least one night."
                                    preferredStyle:UIAlertControllerStyleAlert];
        
        // Add OK Action
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    else{
        
        
        NSDateFormatter *inDateFormatter = [[NSDateFormatter alloc] init];
        [inDateFormatter setFormatterBehavior:NSDateFormatterBehaviorDefault];
        [inDateFormatter setDateStyle:NSDateFormatterShortStyle];
        [inDateFormatter setTimeStyle:NSDateFormatterNoStyle];
        self.inDateString = [inDateFormatter stringFromDate:[self inDate]];
        
        NSDateFormatter *outDateFormatter = [[NSDateFormatter alloc] init];
        [outDateFormatter setFormatterBehavior:NSDateFormatterBehaviorDefault];
        [outDateFormatter setDateStyle:NSDateFormatterShortStyle];
        [outDateFormatter setTimeStyle:NSDateFormatterNoStyle];
        self.outDateString = [outDateFormatter stringFromDate:[self outDate]];
        
        self.checkin_code = arc4random_uniform(9999);
        self.code = [NSString stringWithFormat: @"%ld", (long)checkin_code];
        
        
        __block FIRDocumentReference *ref =
        [[self.db collectionWithPath:[self user_email]] addDocumentWithData:@{
                                                                        @"date_in": [self inDateString],
                                                                        @"date_out": [self outDateString],
                                                                        @"user_email": [self user_email],
                                                                        @"checkin_code":[self code]
                                                                      } completion:^(NSError * _Nullable error) {
                                                                          if (error != nil) {
                                                                              NSLog(@"Document added with ID: %@", ref.documentID);
                                                                              // Normal Alert
                                                                              UIAlertController *alert = [UIAlertController
                                                                                                          alertControllerWithTitle:@"Error"
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
                                                                          
                                                                          else {
                                                                             
                                                                              // Normal Alert
                                                                              UIAlertController *alert = [UIAlertController
                                                                                                          alertControllerWithTitle:@"Success!"
                                                                                                          message:@"Your Booking was successfully made."
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
                                                                              
                                                                          }
                                                                      }];
        
        
       
    }
}



/*
 
///------------------- Reduced Scope----------------------------------
//------------------- picker view----------------------------------

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_pickerData[component] count];
}

- (NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerData[component][row];
}



- (IBAction)didNext:(id)sender {
    //get room type
    NSInteger row1;
    row1 = [pickerView selectedRowInComponent:0];
    
    NSArray *subArray = [_pickerData objectAtIndex:0];
    
    self.roomType = [subArray objectAtIndex:row1];
    
    //test
    //self.pickerLabel.text = self.roomType;
    
    //calculate # of nights
    
    NSDate *startDate = self.inDate;
    NSDate *endDate = self.outDate;
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:startDate
                                                          toDate:endDate
                                                         options:0];
    
    totalDays = (int)components.day;
    
    //calculate total price
    totalPrice = totalDays * 75; //get price from DB
    
    
    //push next page

    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"ConfirmBooking"];
    [self presentViewController:vc animated:YES completion:nil];
    
    
    
    return;
}

*/

/*
- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    <#code#>
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    <#code#>
}

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    <#code#>
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    <#code#>
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    <#code#>
}

- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
    //..
}

- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    <#code#>
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    <#code#>
}

- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    <#code#>
}

- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
    <#code#>
}

- (void)setNeedsFocusUpdate {
    <#code#>
}

- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
    <#code#>
}

- (void)updateFocusIfNeeded {
    <#code#>
}*/

//passing data


/*
- (IBAction)didBookNow:(id)sender {
    self.rmTypeLabel.text = roomType;
}*/
@end
