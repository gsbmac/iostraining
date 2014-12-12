//
//  MBBHomeView.m
//  MacBulletinBoard
//
//  Created by Mac on 12/9/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "MBBHomeView.h"

@implementation MBBHomeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) awakeFromNib {
    self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.height / 2;
    self.profilePicture.layer.borderColor = [UIColor whiteColor].CGColor;
    self.profilePicture.layer.borderWidth = 1.0f;
    self.profilePicture.clipsToBounds = YES;
}

- (IBAction)addPostButtonPressed:(id)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(addPostButtonPressed)]) {
        [self.delegate addPostButtonPressed];
    }
}

- (IBAction)logoutButtonPressed:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(logoutButtonPressed)]) {
        [self.delegate logoutButtonPressed];
    }
}

@end
