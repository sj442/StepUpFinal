//
//  Post.m
//  StepUp
//
//  Created by Sachin Jindal on 2/8/14.

#import "Post.h"

@implementation Comment

- (id) initWithCommentId: (NSString*) commentId andUser:(NSString*) user andCommentText:(NSString *)text andTimeStamp:(NSNumber *)timeStamp
{
    self = [super init];
    if (self) {
        self.commentId = commentId;
        self.userName = user;
        self.commentText = text;
        self.commentTimeStamp = timeStamp;
    }
    return self;
}

@end

@implementation Post

- (id) initWithPostId: (NSString*) postId andType: (PostType) type andTitle: (NSString*) title andText: (NSString*) text andTime: (NSDate *) time andUserId: (NSString*) userId andEventId:(NSString *)eventId {
    self = [super init];
    if (self) {
        self.postId = postId;
        self.type = type;
        self.title = title;
        self.text = text;
        self.time = time;
        self.userId = userId;
        self.eventId = eventId;
    }
    return self;
}

- (id) init {
    return [self initWithPostId:@"" andType:0 andTitle:@"" andText:@"" andTime:0 andUserId:0 andEventId:0];
}

- (void) addComment: (Comment *) comment {
    [self.comments addObject:comment];
}

@end
