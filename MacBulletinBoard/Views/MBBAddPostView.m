//
//  MBBAddPostView.m
//  MacBulletinBoard
//
//  Created by Mac on 12/10/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "MBBAddPostView.h"

@implementation MBBAddPostView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)addPostButtonPressed:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(addPostButtonPressed)]) {
        [self.delegate addPostButtonPressed];
    }
}
@end
