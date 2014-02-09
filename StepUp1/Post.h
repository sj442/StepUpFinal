//
//  Post.h
//  StepUp
//
//  Created by Sachin Jindal on 2/8/14.
//
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, PostType) {
    POST_EVENTUPDATE = 0,
    POST_ANNOUNCEMENT = 1 << 0,
    POST_QUESTION = 1 << 1
};

@interface Comment: NSObject
@property NSString* commentId;
@property NSDictionary* data;

- (id) initWithCommentId: (NSString*) commentID andData: (NSDictionary*) data;

@end

@interface Post : NSObject

@property NSString* postId;
@property PostType type;
@property NSString* title;
@property NSString* text;
@property NSDate* time;
@property NSString* userId;
@property NSString* eventId;
@property NSMutableArray* comments;

- (id) initWithPostId: (NSString*) postId andType: (PostType) type andTitle: (NSString*) title andText: (NSString *) text andTime: (NSDate *) time andUserId: (NSString*) userId
           andEventId: (NSString*) eventId;

- (void) addComment: (Comment *) comment;


@end
