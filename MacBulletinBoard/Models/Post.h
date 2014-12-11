//
//  Post.h
//  MacBulletinBoard
//
//  Created by Mac on 12/11/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comment;

@interface Post : NSManagedObject

@property (nonatomic, retain) NSString * body;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * user;
@property (nonatomic, retain) Comment *comment;

@end
