//
//  EventManager.h
//  StepUp
//
//  Created by Sachin Jindal on 2/8/14.
//
//

// This class is intended to be used as an interface between User interface classes and
// the data storage. The class is responsible for doing the syncing with Firebase as well.


#import <Foundation/Foundation.h>
#import <Firebase/Firebase.h>

#import "Event.h"

@interface EventManager : NSObject

+ (EventManager *) sharedInstance;

@property (nonatomic, strong) Firebase* firebase;
@property NSMutableDictionary* populatedEvents;

- (BOOL) addNewEvent:(Event *) event;
- (BOOL) modifyEvent:(Event *) oldEvent andNewEvent:(Event *) newEvent;
- (BOOL) cancelEvent:(Event *) event;
- (BOOL) deleteEvent:(Event *) event;
- (BOOL) postponeEvent:(Event *) event andNewTime:(NSString *) newTime;
- (BOOL) rsvpEvent:(Event *) event andUser:(NSString *) userid andResponse:(RSVPResponse) response;

- (Event *) getEventWithEventId: (NSString *) eventId;
- (Event *) fetchEventWithEventId: (NSString *) eventId;
- (void) fetchAllEvents;

@end
