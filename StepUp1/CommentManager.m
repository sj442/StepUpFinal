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
        //sharedInstance.firebase = [[Firebase alloc] initWithUrl:kFireBaseStepupPostsPath];
        sharedInstance.populatedComments = [[NSMutableDictionary alloc] init];
    });
    return sharedInstance;
}

-(BOOL)addNewComment:(Comment*) comment toPost:(Post*)post withCompletionHandler:(void(^)(NSError *error))completionHandler
{
    NSString *fireBaseURL = [NSString stringWithFormat:@"%@/%@", kFireBaseStepupPostsPath, post.postId];
    
    self.firebase = [[Firebase alloc]initWithUrl:fireBaseURL];
    
    Firebase *newCommentRef = [self.firebase childByAutoId];
    
    [comment setCommentId:[newCommentRef name]];
    
    [newCommentRef setValue:@{@"commentId":[comment commentId],
                              @"userName":[comment userName],
                              @"commentTimeStamp":[comment commentTimeStamp],
                              @"commentText":[comment commentText],
                              @"postID":[comment postID]
                              }
     
        withCompletionBlock:^(NSError *error, Firebase *ref) {
        //completion block
    }];
    return YES;
}

-(BOOL)deletecomment:(Comment *)comment fromPost:(Post *)post withCompletionHandler:(void (^) (NSError *error))completionHandler
{
    return YES;
}

-(void)fetchAllCommentsWithPostID:(NSString*) postID withcompletionhandler:(void (^) (NSMutableDictionary *dictionary))completonHandler
{
    Firebase *fb = [[Firebase alloc]initWithUrl:[NSString stringWithFormat:@"%@/%@", kFireBaseStepupPostsPath, postID]];
    
    [fb observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        if ([snapshot hasChildren]) {
            
            NSLog(@"yup comments exist!");
            
            NSString *commentId = snapshot.value[@"commentId"];
            NSString *userName = snapshot.value[@"userName"];
            NSNumber *timeStamp = snapshot.value[@"commentTimeStamp"];
            NSString *text = snapshot.value[@"commentText"];
            
            Comment *this_comment = [[Comment alloc]initWithCommentId:commentId andUser:userName andCommentText:text andTimeStamp:timeStamp andPostID:postID];
            
            [[[CommentManager sharedInstance] populatedComments] setObject:this_comment forKey:commentId];
            
            NSLog(@"FetchAllComments: Added new comment %@ with id: %@ Total comments now %lu", [this_comment commentId], [this_comment userName], (unsigned long)[[[CommentManager sharedInstance] populatedComments] count]);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completonHandler([[CommentManager sharedInstance] populatedComments]);
            });
        }
    }];
    
    [fb observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        if ([snapshot childrenCount]==0)
        {
            NSMutableDictionary *tempDict = [[NSMutableDictionary alloc]initWithObjects:@[@"null"] forKeys:@[@"null"]];
            
            [[[CommentManager sharedInstance] populatedComments] removeAllObjects];
            
            NSLog(@"no comments for this post!");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completonHandler(tempDict);
            });
            
        }
    }];
    
    [fb observeEventType:FEventTypeChildRemoved withBlock:^(FDataSnapshot *snapshot)
     {
         if ([snapshot hasChildren])
         {
             NSString* commentID = snapshot.name;
             
             [[[CommentManager sharedInstance] populatedComments] removeObjectForKey:commentID];
         }
     }];
    
    [fb observeEventType:FEventTypeChildChanged withBlock:^(FDataSnapshot *snapshot) {
        if ([snapshot hasChildren]) {
            
            NSString *commentId = snapshot.value[@"commentId"];
            NSString *userName = snapshot.value[@"userName"];
            NSNumber *timeStamp = snapshot.value[@"commentTimeStamp"];
            NSString *text = snapshot.value[@"commentText"];
            
            Comment *this_comment = [[Comment alloc]initWithCommentId:commentId andUser:userName andCommentText:text andTimeStamp:timeStamp andPostID:postID];
            
            [[[CommentManager sharedInstance] populatedComments] setObject:this_comment forKey:commentId];
        }
    }];
}

@end
