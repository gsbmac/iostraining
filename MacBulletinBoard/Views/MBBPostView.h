//
//  MBBPostView.h
//  MacBulletinBoard
//
//  Created by Mac on 12/10/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MBBPostViewDelegate <NSObject>

@required

- (void)addCommentButtonPressed;

@end

@interface MBBPostView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UITableView *commentTable;
@property (weak, nonatomic) IBOutlet UITextView *postLabel;
@property (weak, nonatomic) IBOutlet UITextView *commentField;
@property (weak, nonatomic) IBOutlet UIButton *addCommentButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)addCommentButtonPressed:(id)sender;

@property (strong) id<MBBPostViewDelegate> delegate;


@end
