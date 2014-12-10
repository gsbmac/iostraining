//
//  MBBAddPostViewController.m
//  MacBulletinBoard
//
//  Created by Mac on 12/10/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "MBBAddPostViewController.h"

@interface MBBAddPostViewController ()

@end

@implementation MBBAddPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.addPostView = (MBBAddPostView*)[self getCustomXibUsingXibName:@"AddPostView"];
    self.addPostView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height);
    
    // set delegates
    self.addPostView.delegate = self;
    self.addPostView.titleInput.delegate = self;
    self.addPostView.postInput.delegate = self;

    [self.view addSubview:self.addPostView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addPostButtonPressed{
    //[self performSegueWithIdentifier:@"LoginToHomeSegue" sender:self];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *user = [defaults objectForKey:@"username"];
    NSMutableArray *persistenTitles = [[defaults arrayForKey:@"titles"] mutableCopy];
    NSMutableArray *persistentPosts = [[defaults arrayForKey:@"posts"] mutableCopy];
    NSMutableArray *persistentUsers = [[defaults arrayForKey:@"users"] mutableCopy];
    
    NSString *inputTitle = self.addPostView.titleInput.text;
    NSString *inputPost = self.addPostView.postInput.text;
    
    // Init arrays
    [persistenTitles addObject:inputTitle];
    [persistentPosts addObject:inputPost];
    [persistentUsers addObject:user];
    
    // Store arrays to NSUserDefaults
    [defaults setObject:persistenTitles forKey:@"titles"];
    [defaults setObject:persistentPosts forKey:@"posts"];
    [defaults setObject:persistentUsers forKey:@"users"];
    
    //[self.homeView.postTableView reloadData];
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
