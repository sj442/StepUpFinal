//
//  Event.h
//  StepUp
//
//  Created by Sachin Jindal on 2/8/14.
//
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, EventStatus) {
    EVENT_SCHEDULED = 0,
    EVENT_POSTPONED = 1 << 0,
    EVENT_CANCELLED = 1 << 1
};

typedef NS_OPTIONS(NSUInteger, EventType) {
    EVENT_NETWORKING = 0,
    EVENT_PROFESSIONAL = 1 << 0,
    EVENT_TEEN = 1 << 1
};

typedef NS_OPTIONS(NSUInteger, RSVPResponse) {
    RSVP_YES = 0,
    RSVP_NO = 1 << 0,
    RSVP_MAYBE = 1 << 1
};

@interface Event : NSObject

@property NSString* eventId;
@property EventType type;
@property EventStatus status;
@property NSString* title;
@property NSString* description;
@property NSString* time;
@property NSNumber* duration;
@property NSString* url;
@property NSString* location;
@property NSDictionary* userResponse;

- (id) initWithEventId: (NSString*) eventId andType: (EventType) type andStatus: (EventStatus) status
              andTitle: (NSString*) title
        andDescription: (NSString*) description andTime: (NSString*) time andDuration: (NSNumber*) duration
                andUrl: (NSString*) url andLocation: (NSString*) location andUserResponse: (NSDictionary*) userResponse;
- (BOOL) validateEvent;

- (NSMutableArray*) getAttendees;
- (int) numberOfConfirmedResponses;
- (int) numberOfDeniedResponses;
- (int) numberOfConfusedResponses;

@end
