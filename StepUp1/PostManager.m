//
//  PostManager.m
//  StepUp
//
//  Created by Sachin Jindal on 2/9/14.
//
//

#import "PostManager.h"

#define kFireBaseStepupPostsPath @"https://stepuphacker.firebaseio.com/stepup/posts/"

@implementation PostManager

+ (PostManager *)sharedInstance {
    static PostManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        sharedInstance.firebase = [[Firebase alloc] initWithUrl:kFireBaseStepupPostsPath];
        sharedInstance.populatedPosts = [[NSMutableDictionary alloc] init];
    });
    return sharedInstance;
}

- (void) addNewPost:(Post *) post withcompletionHandler:(void (^)(NSError *error))completionHandler
{
    // add a new post to the firebase database and assign the generated id
    // as the post id
    Firebase *fb = [[PostManager sharedInstance] firebase];
    Firebase *newPostRef = [fb childByAutoId];
    
    NSNumber *postType = [[NSNumber alloc] initWithUnsignedInteger:[post type]];
    
    NSDate *postDate = [post time];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"MM/dd"];
    
    NSString *postTimeString = [formatter stringFromDate:postDate];
    
    [post setPostId:[newPostRef name]];
    
    [newPostRef setValue:@{@"time": postTimeString,
                           @"type": postType,
                           @"title": [post title],
                           @"text": [post text],
                           @"userId": [post userId],
                           @"eventId": [post eventId]
                          }
     withCompletionBlock:^(NSError *error, Firebase *ref) {
          if (error) {
              // TODO: Generate a callback to listeners to alert about this
              NSLog(@"PostManager::addNewPost ALERT! Post addition failed %@", [post title]);
          } else
          {
              // TODO: Generate a post here announcing the addition
              // TODO: Check if adding this event generates a callback from firebase immediately
              // otherwise we'll have to add event ourself to show it to user -- shouldn't be required.
              
              NSLog(@"PostManager::addNewPost Post was added successfully %@", [post title]);
          }
         dispatch_async(dispatch_get_main_queue(), ^{
             completionHandler(error);
         });
     }];
}

- (void) deletePost:(Post *) post withcompletionHandler:(void (^)(NSError *))completionHandler
{
    Firebase *fb = [[PostManager sharedInstance] firebase];
    Firebase *newPostRef = [fb childByAppendingPath:[post postId]];
    [newPostRef removeValueWithCompletionBlock:^(NSError *error, Firebase *ref) {
        if (error) {
            NSLog(@"PostManager::deletePost ALERT! Couldn't delete the post");
        } else {
            // TODO: Generate a post here announcing the deletion
            NSLog(@"PostManager::deletePost Post deleted successfully");
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(error);
        });
    }];
}

- (void) addCommentToPost:(Post *) post andComment: (Comment *) comment {
    Firebase *fb = [[PostManager sharedInstance] firebase];
    Firebase *postRef = [fb childByAppendingPath:[post postId]];
    Firebase *commentsRef = [postRef childByAppendingPath:@"comments"];
    Firebase *newCommentRef = [commentsRef childByAutoId];
    
    [comment setCommentId:[newCommentRef name]];
    [newCommentRef setValue:@{@"commentID": comment.commentId,
                              @"name":comment.userName,
                              @"text":comment.commentText,
                              @"timeStamp":comment.commentTimeStamp} withCompletionBlock:^(NSError *error, Firebase *ref) {
        if (error) {
            NSLog(@"PostManager::addCommentToPost ALERT! Comment addition failed %@", [comment commentId]);
        } else {
            NSLog(@"PostManager::addCommentToPost Comment added successfully");
        }
    }];
}

- (void) deleteCommentFromPost:(Post *) post andComment: (Comment *) comment {
    Firebase *fb = [[PostManager sharedInstance] firebase];
    Firebase *postRef = [fb childByAppendingPath:[post postId]];
    Firebase *commentsRef = [postRef childByAppendingPath:@"comments"];
    Firebase *myCommentRef = [commentsRef childByAppendingPath:[comment commentId]];
    
    [myCommentRef removeValueWithCompletionBlock:^(NSError *error, Firebase *ref) {
        if (error)
        {
            NSLog(@"PostManager::removeCommentFromPost ALERT! Comment deletion failed %@", [comment commentId]);
        } else
        {
            NSLog(@"PostManager::removeCommentFromPost Comment added successfully");
        }
    }];
}

- (void) fetchAllPostsWithCompletionHandler:(void (^) (NSMutableDictionary *dictionary))completonHandler
{
    Firebase *fb = [[PostManager sharedInstance] firebase];
    
    [fb observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        if ([snapshot hasChildren]) {
            NSString* text = snapshot.value[@"text"];
            NSDate* time = snapshot.value[@"time"];
            NSString* title = snapshot.value[@"title"];
            PostType type = (PostType) snapshot.value[@"type"];
            NSString* userId = snapshot.value[@"userId"];
            NSString* eventId = snapshot.value[@"eventId"];
            NSString* postId = snapshot.name;
            
            Post* my_post = [[Post alloc] initWithPostId:postId andType:type andTitle: title andText: text andTime: time andUserId: userId andEventId: eventId];

            [[[PostManager sharedInstance] populatedPosts] setObject:my_post forKey:postId];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completonHandler([[PostManager sharedInstance] populatedPosts]);
        });
    }];
    
    [fb observeEventType:FEventTypeChildRemoved withBlock:^(FDataSnapshot *snapshot) {
        if ([snapshot hasChildren]) {
            NSString* postId = snapshot.name;
            [[[PostManager sharedInstance] populatedPosts] removeObjectForKey:postId];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completonHandler([[PostManager sharedInstance] populatedPosts]);
        });
    }];
    
    [fb observeEventType:FEventTypeChildChanged withBlock:^(FDataSnapshot *snapshot) {
        if ([snapshot hasChildren]) {
            NSString* text = snapshot.value[@"text"];
            NSDate* time = snapshot.value[@"time"];
            NSString* title = snapshot.value[@"title"];
            PostType type = (PostType) snapshot.value[@"type"];
            NSString* userId = snapshot.value[@"userId"];
            NSString* eventId = snapshot.value[@"eventId"];
            NSString* postId = snapshot.name;
            
            Post* my_post = [[Post alloc] initWithPostId:postId andType:type andTitle: title andText: text andTime: time andUserId: userId andEventId: eventId];
            
            [[[PostManager sharedInstance] populatedPosts] setObject:my_post forKey:postId];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completonHandler([[PostManager sharedInstance] populatedPosts]);
        });
    }];
}

@end
