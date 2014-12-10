//
//  MBBAddPostViewController.h
//  MacBulletinBoard
//
//  Created by Mac on 12/10/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "MBBBaseUIViewController.h"
#import "MBBAddPostView.h"

@interface MBBAddPostViewController : MBBBaseUIViewController<MBBAddPostViewDelegate, UITextFieldDelegate, UITextViewDelegate>

@property (strong, nonatomic) MBBAddPostView *addPostView;

@end
