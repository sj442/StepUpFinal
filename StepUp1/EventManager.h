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
@property (nonatomic, strong) NSMutableDictionary* populatedEvents;

- (BOOL) addNewEvent:(Event *) event withcompletionHandler:(void (^)(NSError *error))completionHandler;

- (BOOL) modifyEvent:(Event *) oldEvent andNewEvent:(Event *) newEvent withCompletionHandler:(void (^)(NSError *error))completionHandler;

- (BOOL) cancelEvent:(Event *) event;

- (BOOL) deleteEvent:(Event *) event withCompletionHandler:(void (^)(NSError *error))completionHandler;

- (BOOL) postponeEvent:(Event *) event andNewTime:(NSString *) newTime;

- (BOOL) rsvpEvent:(Event *) event andUser:(NSString *) userid andResponse:(RSVPResponse) response;

- (Event *) getEventWithEventId: (NSString *) eventId;
- (Event *) fetchEventWithEventId: (NSString *) eventId;

-(void)fetchAllEventsWithCompletionHandler:(void (^) (NSMutableDictionary *dictionary))completonHandler;

@end
