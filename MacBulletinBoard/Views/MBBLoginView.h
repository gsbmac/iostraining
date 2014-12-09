//
//  MBBLoginView.h
//  MacBulletinBoard
//
//  Created by Mac on 12/9/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MBBLoginViewDelegate <NSObject>

@required

- (void)loginButtonPressed;

@end

@interface MBBLoginView : UIView

// IB Outlets

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)loginButtonPressed:(id)sender;

@property (strong) id<MBBLoginViewDelegate> delegate;

@end
