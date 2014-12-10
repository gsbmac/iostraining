//
//  MBBHomeView.h
//  MacBulletinBoard
//
//  Created by Mac on 12/9/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MBBHomeViewDelegate <NSObject>

@required

- (void)addPostButtonPressed;
- (void)logoutButtonPressed;

@end

@interface MBBHomeView : UIView

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIButton *addPostButton;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UITableView *postTableView;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;

- (IBAction)addPostButtonPressed:(id)sender;
- (IBAction)logoutButtonPressed:(id)sender;

@property (strong) id<MBBHomeViewDelegate> delegate;


@end
