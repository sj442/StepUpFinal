//
//  EventManager.m
//  StepUp
//
//  Created by Sachin Jindal on 2/8/14.
//
//

#import "EventManager.h"
#import "PostManager.h"
#import  "Post.h"

#define kFireBaseStepupEventsPath @"https://stepuphacker.firebaseio.com/stepup/events/"

@implementation EventManager

+ (EventManager *)sharedInstance {
    static EventManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        sharedInstance.firebase = [[Firebase alloc] initWithUrl:kFireBaseStepupEventsPath];
        sharedInstance.populatedEvents = [[NSMutableDictionary alloc] init];
    });
    return sharedInstance;
}

- (BOOL) addNewEvent:(Event *) event withcompletionHandler:(void (^)(NSError *error))completionHandler{
    // add a new event to the firebase database and assign the generated id
    // as the event id
    Firebase *fb = [[EventManager sharedInstance] firebase];
    Firebase *newEventRef = [fb childByAutoId];
    
    NSNumber *eventType = [[NSNumber alloc] initWithUnsignedInteger:[event type]];
    NSNumber *eventStatus = [[NSNumber alloc] initWithUnsignedInteger:[event status]];
    
    [event setEventId:[newEventRef name]];
    
    if (![event validateEvent]) {
        NSLog(@"EventManager::addNewEvent ALERT! Event invalid %@", [event title]);
        return false;
    }
    NSLog(@"EventManager::addNewEvent Event adding %@", [event title]);
    
    [newEventRef setValue:@{@"time": [event time],
                            @"date": [event date],
                            @"location": [event location],
                            @"type": eventType,
                            @"url": [event url],
                            @"title": [event title],
                            @"status": eventStatus,
                            @"duration": [event duration],
                            @"description": [event description],
                            @"userresponse": [event userResponse],
                            @"timeStamp": [event eventTimeStamp]
                            }
      withCompletionBlock:^(NSError *error, Firebase *ref) {
          if (error)
          {
              // TODO: Generate a callback to listeners to alert about this
              NSLog(@"EventManager::addNewEvent ALERT! Event addition failed %@", [event title]);
              
          } else {
              // TODO: Generate a post here announcing the addition
              // TODO: Check if adding this event generates a callback from firebase immediately
              // otherwise we'll have to add event ourself to show it to user -- shouldn't be required.
              
              NSLog(@"EventManager::addNewEvent Event was added successfully %@", [event title]);
          }
          dispatch_async(dispatch_get_main_queue(), ^{
              completionHandler(error);
          });
      }];
    return true;
}

- (BOOL) modifyEvent:(Event *) oldEvent andNewEvent:(Event *) newEvent withCompletionHandler:(void (^)(NSError *error))completionHandler {
    Firebase *fb = [[EventManager sharedInstance] firebase];
    Firebase *newEventRef = [fb childByAppendingPath:[oldEvent eventId]];
    
    NSNumber *eventType = [[NSNumber alloc] initWithUnsignedInteger:[newEvent type]];
    NSNumber *eventStatus = [[NSNumber alloc] initWithUnsignedInteger:[newEvent status]];

    [newEventRef setValue:@{@"time": [newEvent time],
                            @"date": [newEvent date],
                            @"location": [newEvent location],
                            @"type": eventType,
                            @"url": [newEvent url],
                            @"title": [newEvent title],
                            @"status": eventStatus,
                            @"duration": [newEvent duration],
                            @"description": [newEvent description],
                            @"userresponse": [newEvent userResponse],
                            @"timeStamp": [newEvent eventTimeStamp]
                            }
      withCompletionBlock:^(NSError *error, Firebase *ref) {
          if (error) {
              // TODO: Generate a callback to listeners to alert about this
              NSLog(@"EventManager::modifyEvent ALERT! Event modifiction failed %@", [newEvent title]);
          } else {
              NSLog(@"EventManager::modifyEvent Event was added successfully %@", [newEvent title]);
          }
          dispatch_async(dispatch_get_main_queue(), ^{
              completionHandler(error);
          });
      }];
    return true;
}
- (BOOL) cancelEvent:(Event *) event
{
    Event *new_event = [event mutableCopy];
    [new_event setStatus:EVENT_CANCELLED];
    [[EventManager sharedInstance] modifyEvent:event andNewEvent:new_event withCompletionHandler:^(NSError *error) {
        //fill in later
    }];
    
    // TODO: Generate a post here announcing the cancellation
    
    NSString *postTitle = [NSString stringWithFormat:@"CANCELLED %@", [event title]];
    
    NSString *postText = [NSString stringWithFormat:@"%@ scheduled on %@ at %@ has been canceled. We'll get back to you with more updates", [event title], [event time], [event location]];
    
    Post *newPost = [[Post alloc]initWithPostId:@"" andType:0 andTitle:postTitle andText: postText andTime:[NSDate date] andUserId:@"" andEventId:[event eventId]];
    
    [[PostManager sharedInstance] addNewPost:newPost];
    
   return true;
}

- (BOOL) deleteEvent:(Event *) event withCompletionHandler:(void (^)(NSError *error))completionHandler  {
    Firebase *fb = [[EventManager sharedInstance] firebase];
    Firebase *newEventRef = [fb childByAppendingPath:[event eventId]];

    [newEventRef removeValueWithCompletionBlock:^(NSError *error, Firebase *ref) {
        if (error) {
            NSLog(@"EventManager::deleteEvent ALERT! Couldn't delete the event");
        } else {
            // TODO: Generate a post here announcing the deletion
            NSLog(@"EventManager::deleteEvent Event deleted successfully");
            
            NSString *postTitle = [NSString stringWithFormat:@"CANCELLED %@", [event title]];
            
            NSString *postText = [NSString stringWithFormat:@"%@ scheduled on %@ at %@ has been canceled. We'll get back to you with more updates", [event title], [event date], [event location]];
            
            Post *newPost = [[Post alloc]initWithPostId:@"" andType:0 andTitle:postTitle andText: postText andTime:[NSDate date] andUserId:@"" andEventId:[event eventId]];
            
            [[PostManager sharedInstance] addNewPost:newPost];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(error);
        });
    }];
    return true;

}
- (BOOL) postponeEvent:(Event *) event andNewTime:(NSString *) newTime {
    Event *new_event = [event mutableCopy];
    [new_event setTime:newTime];
    [[EventManager sharedInstance] modifyEvent:event andNewEvent:new_event withCompletionHandler:^(NSError *error) {
        //later
    }];
    // TODO: Generate a post here announcing the postpone
    return true;

}
- (BOOL) rsvpEvent:(Event *) event andUser:(NSString *) userid andResponse:(RSVPResponse) response {
    Event *new_event = [event mutableCopy];
    switch (response) {
        case RSVP_YES:
            [[new_event userResponse] setValue:@"YES" forKey:userid];
            break;
        case RSVP_NO:
            [[new_event userResponse] setValue:@"NO" forKey:userid];
            break;
        case RSVP_MAYBE:
            [[new_event userResponse] setValue:@"MAYBE" forKey:userid];
            break;
        default:
            break;
    }
    [[EventManager sharedInstance] modifyEvent:event andNewEvent:new_event withCompletionHandler:^(NSError *error) {
        //later
    }];
    return true;
}

- (Event *) getEventWithEventId: (NSString *) eventId {
    EventManager* em = [EventManager sharedInstance];
    Event* event = [[em populatedEvents] objectForKey:eventId];
    if (event == nil) {
        return [em fetchEventWithEventId:eventId];
    } else {
        return event;
    }
    return nil;
}

- (Event *) fetchEventWithEventId: (NSString *) eventId {
    Firebase *fb = [[EventManager sharedInstance] firebase];
    Firebase *newEventRef = [fb childByAppendingPath:eventId];
    
    // fetch the event from Firebase data if it exists there

    __block Event* my_event = nil;
    [newEventRef observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        if ([snapshot hasChildren]) {
            NSString* description = snapshot.value[@"description"];
            NSNumber* duration = snapshot.value[@"duration"];
            NSString* location = snapshot.value[@"location"];
            EventStatus status = (EventStatus) snapshot.value[@"status"];
            NSString* time = snapshot.value[@"time"];
            NSString *date = snapshot.value[@"date"];
            NSNumber *eventTimeStamp = snapshot.value[@"eventTimeStamp"];
            NSString* title = snapshot.value[@"title"];
            EventType type = (EventType) snapshot.value[@"type"];
            NSString* url = snapshot.value[@"url"];
            NSDictionary* userResponse = snapshot.value[@"userresponse"];
            my_event = [[Event alloc] initWithEventId:eventId andType:type andStatus:status andTitle:title andDescription:description andTime:time andDate:date andEventTimeStamp:eventTimeStamp andDuration:duration andUrl:url andLocation:location andUserResponse:userResponse];
        }
    }];
    
    return my_event;
}

- (void)fetchAllEventsWithCompletionHandler:(void (^) (NSMutableDictionary *dictionary))completonHandler {
    
    Firebase *fb = [[EventManager sharedInstance] firebase];

    [fb observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        if ([snapshot hasChildren]) {
            NSString *description = snapshot.value[@"description"];
            NSNumber *duration = snapshot.value[@"duration"];
            NSString *location = snapshot.value[@"location"];
            EventStatus status = (EventStatus) snapshot.value[@"status"];
            NSString *time = snapshot.value[@"time"];
            NSString *title = snapshot.value[@"title"];
            EventType type = (EventType) snapshot.value[@"type"];
            NSString *url = snapshot.value[@"url"];
            NSDictionary *userResponse = snapshot.value[@"userresponse"];
            NSString *eventId = snapshot.name;
            NSString *date = snapshot.value[@"date"];
            NSNumber *eventTimeStamp = snapshot.value[@"eventTimeStamp"];

            Event* my_event = [[Event alloc] initWithEventId:eventId andType:type andStatus:status andTitle:title andDescription:description andTime:time andDate:date andEventTimeStamp:eventTimeStamp andDuration:duration andUrl:url andLocation:location andUserResponse:userResponse];
            
            [[[EventManager sharedInstance] populatedEvents] setObject:my_event forKey:eventId];
            
            NSLog(@"FetchAllEvents: Added new Event %@ with id: %@ Total Events now %lu", [my_event title], [my_event eventId], (unsigned long)[[[EventManager sharedInstance] populatedEvents] count]);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completonHandler([[EventManager sharedInstance] populatedEvents]);
        });
    }];
    
    [fb observeEventType:FEventTypeChildRemoved withBlock:^(FDataSnapshot *snapshot)
    {
        if ([snapshot hasChildren])
        {
            NSString* eventId = snapshot.name;
            [[[EventManager sharedInstance] populatedEvents] removeObjectForKey:eventId];
        }
    }];
    
    [fb observeEventType:FEventTypeChildChanged withBlock:^(FDataSnapshot *snapshot) {
        if ([snapshot hasChildren]) {
            NSString* description = snapshot.value[@"description"];
            NSNumber* duration = snapshot.value[@"duration"];
            NSString* location = snapshot.value[@"location"];
            EventStatus status = (EventStatus) snapshot.value[@"status"];
            NSString* time = snapshot.value[@"time"];
            NSString* title = snapshot.value[@"title"];
            EventType type = (EventType) snapshot.value[@"type"];
            NSString* url = snapshot.value[@"url"];
            NSDictionary* userResponse = snapshot.value[@"userresponse"];
            NSString* eventId = snapshot.name;
            NSString *date = snapshot.value[@"date"];
            NSNumber *eventTimeStamp = snapshot.value[@"eventTimeStamp"];
            
            Event* my_event = [[Event alloc] initWithEventId:eventId andType:type andStatus:status andTitle:title andDescription:description andTime:time andDate:date andEventTimeStamp:eventTimeStamp andDuration:duration andUrl:url andLocation:location andUserResponse:userResponse];
            
            [[[EventManager sharedInstance] populatedEvents] setObject:my_event forKey:eventId];
        }        
    }];
}

-(BOOL)compareTodayWithEventTimeStamp:(NSNumber*)timestamp
{
    NSDate *today = [NSDate date];
    
    NSNumber *todayTimeStamp = [NSNumber numberWithDouble:[today timeIntervalSinceReferenceDate]];
    
    if (timestamp<todayTimeStamp)
    {
        return NO;
    }
    return YES;
}

@end
