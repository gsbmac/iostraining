//
//  MBBLoginViewController.h
//  MacBulletinBoard
//
//  Created by Mac on 12/9/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "MBBBaseUIViewController.h"
#import "MBBLoginView.h"

@interface MBBLoginViewController : MBBBaseUIViewController<MBBLoginViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) MBBLoginView *loginView;

@end
