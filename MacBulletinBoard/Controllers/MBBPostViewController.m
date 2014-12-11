//
//  MBBPostViewController.m
//  MacBulletinBoard
//
//  Created by Mac on 12/10/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "MBBPostViewController.h"

@interface MBBPostViewController ()

@end

@implementation MBBPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.postView = (MBBPostView*)[self getCustomXibUsingXibName:@"PostView"];
    self.postView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height);
    
    // Init nsuserdefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *title = [defaults objectForKey:@"title"];
    NSString *post = [defaults objectForKey:@"post"];
    NSString *user = [defaults objectForKey:@"user"];
    
    self.postView.titleLabel.text = title;
    self.postView.postLabel.text = post;
    self.postView.userLabel.text = [NSString stringWithFormat:@"%@ %@", @"Posted by: ", user];
    
    //CGSize labelSize = [text sizeWithFont:[UIFont systemFontSize:17.0f] constrainedToSize:self.postView.postLabel.frame.size lineBreakMode:NSLineBreakByWordWrapping];
    
    if ([user isEqualToString:@"mac"]) {
        self.postView.profilePicture.image = [UIImage imageNamed:@"icon"];
    }
    else {
        self.postView.profilePicture.image = [UIImage imageNamed:@"user"];
    }
    
    [self.view addSubview:self.postView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
