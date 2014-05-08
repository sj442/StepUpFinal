//
//  Post.h
//  StepUp
//
//  Created by Sachin Jindal on 2/8/14.
//
//

#import <Foundation/Foundation.h>
#import "User.h"

typedef NS_OPTIONS(NSUInteger, PostType) {
    POST_EVENTUPDATE = 0,
    POST_QUESTIONS = 1 << 0,
    POST_ANNOUNCEMENT = 1 << 1,
};

@interface Comment: NSObject
@property  (strong, nonatomic) NSString *commentId;
@property  (strong, nonatomic) NSString *userName;
@property  (strong, nonatomic) NSNumber *commentTimeStamp;
@property  (strong, nonatomic) NSString *commentText;
@property  (strong, nonatomic) NSString *postID;

- (id) initWithCommentId:(NSString*) commentID andUser:(NSString*) user andCommentText:(NSString*)text andTimeStamp:(NSNumber*) timeStamp andPostID:(NSString*)postId;

@end

@interface Post : NSObject

@property  (strong, nonatomic) NSString *postId;
@property PostType type;
@property  (strong, nonatomic) NSString *title;
@property  (strong, nonatomic) NSString *text;
@property  (strong, nonatomic) NSDate *time;
@property  (strong, nonatomic) NSString *userId;
@property  (strong, nonatomic) NSString* eventId;
@property  (strong, nonatomic) NSMutableArray* comments;

- (id) initWithPostId: (NSString*) postId andType: (PostType) type andTitle: (NSString*) title andText: (NSString *) text andTime: (NSDate *) time andUserId: (NSString*) userId
           andEventId: (NSString*) eventId;

- (void) addComment: (Comment *) comment;


@end
