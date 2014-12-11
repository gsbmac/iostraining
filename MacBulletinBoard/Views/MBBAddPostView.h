//
//  MBBAddPostView.h
//  MacBulletinBoard
//
//  Created by Mac on 12/10/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MBBAddPostViewDelegate <NSObject>
@required

- (void)addPostButtonPressed;

@end

@interface MBBAddPostView : UIView

@property (weak, nonatomic) IBOutlet UITextField *titleInput;
@property (weak, nonatomic) IBOutlet UITextView *postInput;
@property (weak, nonatomic) IBOutlet UIButton *addpostButton;
@property (weak, nonatomic) IBOutlet UIScrollView *addPostScrollView;

- (IBAction)addPostButtonPressed:(id)sender;

@property (strong) id<MBBAddPostViewDelegate> delegate;

@end
