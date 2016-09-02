//
//  DiaryWriteBasicController.m
//  co.medisolution
//
//  Created by uracle on 2016. 8. 17..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "DiaryWriteBasicController.h"

@interface DiaryWriteBasicController ()

@end

@implementation DiaryWriteBasicController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 0.0, _contentsTextView.frame.size.width - 10.0, 34.0)];
    
    [_placeholderLabel setText:@"내용을 입력해주세요"];
    [_placeholderLabel setBackgroundColor:[UIColor clearColor]];
    [_placeholderLabel setTextColor:[UIColor colorWithRed:199.0/255.0f green:199.0/255.0f  blue:205.0/255.0f alpha:1.0]];
    [_placeholderLabel setFont:[UIFont systemFontOfSize:14.5]];
    _contentsTextView.delegate = self;
    
    [_contentsTextView addSubview:_placeholderLabel];
    
    _imageButton01.layer.cornerRadius = 20;//half of the width
    _imageButton01.layer.borderColor = [UIColor colorWithRed:236.0/255.0f green:236.0/255.0f  blue:236.0/255.0f alpha:1.0].CGColor;
    _imageButton01.layer.borderWidth = 2.0f;
    _imageButton01.layer.masksToBounds = YES;
    
    _imageButton02.layer.cornerRadius = 20;//half of the width
    _imageButton02.layer.borderColor = [UIColor colorWithRed:236.0/255.0f green:236.0/255.0f  blue:236.0/255.0f alpha:1.0].CGColor;
    _imageButton02.layer.borderWidth = 2.0f;
    _imageButton02.layer.masksToBounds = YES;
    
    _imageButton03.layer.cornerRadius = 20;//half of the width
    _imageButton03.layer.borderColor = [UIColor colorWithRed:236.0/255.0f green:236.0/255.0f  blue:236.0/255.0f alpha:1.0].CGColor;
    _imageButton03.layer.borderWidth = 2.0f;
    _imageButton03.layer.masksToBounds = YES;
    
    _imageButton04.layer.cornerRadius = 20;//half of the width
    _imageButton04.layer.borderColor = [UIColor colorWithRed:236.0/255.0f green:236.0/255.0f  blue:236.0/255.0f alpha:1.0].CGColor;
    _imageButton04.layer.borderWidth = 2.0f;
    _imageButton04.layer.masksToBounds = YES;
    
    
    UINavigationItem *newItem = [[UINavigationItem alloc]init];
    newItem.title = @"다이어리 쓰기";
    
    //close Button Setting
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *closeBtnImage = [UIImage imageNamed:@"title_icon_close.png"];
    closeBtn.frame = CGRectMake(0, 0, 40, 40);
    [closeBtn setImage:closeBtnImage forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithCustomView:closeBtn];
    newItem.rightBarButtonItem = closeButton;
    
    //save Button Setting
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *saveBtnImage = [UIImage imageNamed:@"title_icon_save.png"];
    saveBtn.frame = CGRectMake(0, 0, 40, 40);
    [saveBtn setImage:saveBtnImage forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveDiary) forControlEvents:UIControlEventTouchUpInside];
    [saveBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    newItem.leftBarButtonItem = saveButton;
    
    [_navigationBar setItems:@[newItem]];

}

- (void)goBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveDiary{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (![textView hasText]) {
        _placeholderLabel.hidden = NO;
    }
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    
    if(![textView hasText]) {
        _placeholderLabel.hidden = NO;
    }
    else{
        _placeholderLabel.hidden = YES;
    }
}

@end
