//
//  Event.h
//  StepUp
//
//  Created by Sachin Jindal on 2/8/14.
//
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, UserType) {
  ADMIN = 0,
  MENTOR = 1 << 0,
  MENTEE = 1 << 1
};

@interface User : NSObject

@property NSString *userId;
@property NSString *name;
@property UserType type;
@property NSString *email;
@property NSString *location;

- (id) initWithUserId: (NSString*) userId andName: (NSString*) name andType: (UserType) type
             andEmail: (NSString*) email andLocation: (NSString*) location;

@end
