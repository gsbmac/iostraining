//
//  MBBHomeViewController.h
//  MacBulletinBoard
//
//  Created by Mac on 12/9/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "MBBBaseUIViewController.h"
#import "MBBHomeView.h"
#import "MBBPostTableViewCell.h"

@interface MBBHomeViewController : MBBBaseUIViewController<MBBHomeViewDelegate, UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) MBBHomeView *homeView;

@end
