//
//  SignUpMommyInfoController.h
//  co.medisolution
//
//  Created by uracle on 2016. 8. 23..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpMommyInfoController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIAlertViewDelegate, UIImagePickerControllerDelegate>

- (IBAction)MommyPictureButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *mommyNameTextField;
@property (weak, nonatomic) IBOutlet UILabel *mommyNameValidationLabel;


@end
