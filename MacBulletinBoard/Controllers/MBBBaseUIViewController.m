//
//  MBBBaseUIViewController.m
//  MacBulletinBoard
//
//  Created by Mac on 12/9/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "MBBBaseUIViewController.h"

@interface MBBBaseUIViewController ()

@end

@implementation MBBBaseUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView*)getCustomXibUsingXibName:(NSString*)xibName{
    NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil];
    return [arrayOfViews objectAtIndex:0];
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
