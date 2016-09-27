//
//  QuestionScrollViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 26..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "QuestionScrollViewController.h"

@interface QuestionScrollViewController ()

@end

@implementation QuestionScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _containerView.layer.borderColor = [[UIColor colorWithRed:217.0f/255.0f green:217.0f/255.0f blue:217.0f/255.0f alpha:1.0f] CGColor];
    _containerView.layer.borderWidth = 1.0f;
    _containerView.layer.cornerRadius = 10;
    
    _txtView.layer.borderColor = [[UIColor colorWithRed:217.0f/255.0f green:217.0f/255.0f blue:217.0f/255.0f alpha:1.0f] CGColor];
    _txtView.layer.borderWidth = 1.0f;
    _txtView.layer.cornerRadius = 10;
    
//    self.view.backgroundColor = [UIColor colorWithRed:235.0f/255.0f green:235.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    
    _imageFirstQuestion1.image = [UIImage imageNamed:@"radio_btn_on"];
    _imageSecondQuestion1.image = [UIImage imageNamed:@"radio_btn_on"];
    _imageThirdQuestion1.image = [UIImage imageNamed:@"radio_btn_on"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)firstButtonSelect:(id)sender {
    
    UIButton *button = sender;
    
    switch (button.tag) {
        case 0:
            _imageFirstQuestion1.image = [UIImage imageNamed:@"radio_btn_on"];
            _imageFirstQuestion2.image = [UIImage imageNamed:@"radio_btn_off"];
            _imageFirstQuestion3.image = [UIImage imageNamed:@"radio_btn_off"];
            break;
        case 1:
            _imageFirstQuestion1.image = [UIImage imageNamed:@"radio_btn_off"];
            _imageFirstQuestion2.image = [UIImage imageNamed:@"radio_btn_on"];
            _imageFirstQuestion3.image = [UIImage imageNamed:@"radio_btn_off"];
            break;
        case 2:
            _imageFirstQuestion1.image = [UIImage imageNamed:@"radio_btn_off"];
            _imageFirstQuestion2.image = [UIImage imageNamed:@"radio_btn_off"];
            _imageFirstQuestion3.image = [UIImage imageNamed:@"radio_btn_on"];
            break;
        default:
            break;
    }
}
- (IBAction)secondButtonSelect:(id)sender {
    
    UIButton *button = sender;
    
    switch (button.tag) {
        case 0:
            _imageSecondQuestion1.image = [UIImage imageNamed:@"radio_btn_on"];
            _imageSecondQuestion2.image = [UIImage imageNamed:@"radio_btn_off"];
            _imageSecondQuestion3.image = [UIImage imageNamed:@"radio_btn_off"];
            break;
        case 1:
            _imageSecondQuestion1.image = [UIImage imageNamed:@"radio_btn_off"];
            _imageSecondQuestion2.image = [UIImage imageNamed:@"radio_btn_on"];
            _imageSecondQuestion3.image = [UIImage imageNamed:@"radio_btn_off"];
            break;
        case 2:
            _imageSecondQuestion1.image = [UIImage imageNamed:@"radio_btn_off"];
            _imageSecondQuestion2.image = [UIImage imageNamed:@"radio_btn_off"];
            _imageSecondQuestion3.image = [UIImage imageNamed:@"radio_btn_on"];
            break;
        default:
            break;
    }
}
- (IBAction)thirdButtonSelect:(id)sender {
    
    UIButton *button = sender;
    
    switch (button.tag) {
        case 0:
            _imageThirdQuestion1.image = [UIImage imageNamed:@"radio_btn_on"];
            _imageThirdQuestion2.image = [UIImage imageNamed:@"radio_btn_off"];
            _imageThirdQuestion3.image = [UIImage imageNamed:@"radio_btn_off"];
            break;
        case 1:
            _imageThirdQuestion1.image = [UIImage imageNamed:@"radio_btn_off"];
            _imageThirdQuestion2.image = [UIImage imageNamed:@"radio_btn_on"];
            _imageThirdQuestion3.image = [UIImage imageNamed:@"radio_btn_off"];
            break;
        case 2:
            _imageThirdQuestion1.image = [UIImage imageNamed:@"radio_btn_off"];
            _imageThirdQuestion2.image = [UIImage imageNamed:@"radio_btn_off"];
            _imageThirdQuestion3.image = [UIImage imageNamed:@"radio_btn_on"];
            break;
        default:
            break;
    }
}

@end













