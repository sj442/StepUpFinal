//
//  PostManager.h
//  StepUp
//
//  Created by Sachin Jindal on 2/9/14.
//
//

// This class is intended to be used as an interface between User interface classes and
// the data storage. The class is responsible for doing the syncing with Firebase as well.


#import <Foundation/Foundation.h>
#import <Firebase/Firebase.h>

#import "Post.h"

@interface PostManager : NSObject

+ (PostManager *) sharedInstance;

@property (nonatomic, strong) Firebase* firebase;
@property NSMutableDictionary* populatedPosts;

- (void) addNewPost:(Post *) post;
- (void) deletePost:(Post *) post;

- (void) addCommentToPost:(Post *) post andComment: (Comment *) comment;
- (void) deleteCommentFromPost:(Post *) post andComment: (Comment *) comment;

- (void) fetchAllPostsWithCompletionHandler:(void (^) (NSMutableDictionary *dictionary))completonHandler;

@end
