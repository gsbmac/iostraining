//
//  MBBPostViewController.h
//  MacBulletinBoard
//
//  Created by Mac on 12/10/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "MBBBaseUIViewController.h"
#import "MBBPostView.h"
#import "MBBCommentTableViewCell.h"
#import "AppDelegate.h"

@interface MBBPostViewController : MBBBaseUIViewController<MBBPostViewDelegate, UITextFieldDelegate, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) MBBPostView *postView;

@end
