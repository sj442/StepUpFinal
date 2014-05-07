//
//  CommentManager.m
//  StepUp1
//
//  Created by Sunayna Jain on 5/6/14.
//  Copyright (c) 2014 LittleAuk. All rights reserved.

#import "CommentManager.h"

#define kFireBaseStepupPostsPath @"https://stepuphacker.firebaseio.com/stepup/comments/"

@implementation CommentManager : NSObject

+ (CommentManager *)sharedInstance {
    static CommentManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        sharedInstance.firebase = [[Firebase alloc] initWithUrl:kFireBaseStepupPostsPath];
        sharedInstance.populatedPosts = [[NSMutableDictionary alloc] init];
    });
    return sharedInstance;
}

-(BOOL)addNewComment:(Comment*) comment toPost:(Post*)post withCompletionHandler:(void(^)(NSMutableDictionary *dictionary))completionHandler
{
    Firebase *fb = [[CommentManager sharedInstance] firebase];
    Firebase *newCommentRef = [fb childByAutoId];
    
    [comment setCommentId:[newCommentRef name]];
    
    [newCommentRef setValue:@{} withCompletionBlock:^(NSError *error, Firebase *ref) {
        //completion block
    }];
    return YES;
}

-(BOOL)deletecomment:(Comment *)comment fromPost:(Post *)post withCompletionHandler:(void (^) (NSMutableDictionary *dictionary))completionHandler
{
    return YES;
}

-(BOOL)fetchAllCommentsWithPostID:(NSString*) postID withcompletionhandler:(void (^) (NSMutableDictionary *dictionary))completonHandler
{
    return YES;
}

@end
