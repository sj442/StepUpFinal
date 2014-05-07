//
//  CommentManager.h
//  StepUp1
//
//  Created by Sunayna Jain on 5/6/14.
//  Copyright (c) 2014 LittleAuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Firebase/Firebase.h>
#import "Post.h"

@interface CommentManager : NSObject

@property (nonatomic, strong) Firebase* firebase;
@property NSMutableDictionary* populatedPosts;

+ (CommentManager *) sharedInstance;

-(BOOL)addNewComment:(Comment*) comment toPost:(Post*)post withCompletionHandler:(void(^)(NSMutableDictionary *dictionary))completionHandler;

-(BOOL)deletecomment:(Comment *)comment fromPost:(Post *)post withCompletionHandler:(void (^) (NSMutableDictionary *dictionary))completionHandler;

-(BOOL)fetchAllCommentsWithPostID:(NSString*) postID withcompletionhandler:(void (^) (NSMutableDictionary *dictionary))completonHandler;


@end
