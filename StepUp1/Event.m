//
//  Event.m
//  StepUp
//
//  Created by Sachin Jindal on 2/8/14.
//
//

#import "Event.h"

@implementation Event

- (id) initWithEventId:(NSString *)eventId andType:(EventType)type andStatus:(EventStatus)status andTitle:(NSString *)title andDescription:(NSString *)description andTime:(NSString *)time andDate:(NSString *)date andEventTimeStamp:(NSNumber *)eventTimeStamp andDuration:(NSNumber *)duration andUrl:(NSString *)url andLocation:(NSString *)location andUserResponse:(NSDictionary *)userResponse
{
    self = [super init];
    if (self) {
        self.eventId = eventId;
        self.type = type;
        self.status = status;
        self.title = title;
        self.description = description;
        self.time = time;
        self.date = date;
        self.eventTimeStamp = eventTimeStamp;
        self.duration = duration;
        self.url = url;
        self.location = location;
        self.userResponse = userResponse;
    }
    return self;
}

- (id) init {
    return [self initWithEventId:0 andType:EVENT_TEEN andStatus:EVENT_SCHEDULED andTitle:@"UNTITLED" andDescription:@"" andTime:@"" andDate:@"" andEventTimeStamp:0 andDuration:0 andUrl:@"http://www.google.com" andLocation:@"New York City" andUserResponse:nil];
}

- (BOOL) validateEvent
{
    if (self.title == nil ||
        self.date==nil ||
        self.location == nil ||
        self.time == nil ||
        self.url == nil)
         {
        NSLog(@"Event INVALID: title %@ desc %@ location %@ time %@ duration %@ url %@ userResponse %@",
              self.title, self.description, self.location, self.time, self.duration, self.url, self.userResponse);
        return FALSE;
    }
    return TRUE;
}

- (NSMutableArray*) getAttendees {
    NSEnumerator *enumerator = [self.userResponse keyEnumerator];
    id key;
    NSMutableArray* attendees = [[NSMutableArray alloc] init];
    
    while (key = [enumerator nextObject]) {
        NSString *response = [[self userResponse] objectForKey:key];
        if ([response isEqualToString:@"YES"]) {
            [attendees addObject:key];
        }
    }
    return attendees;
}

- (int) numberOfConfirmedResponses {
    NSEnumerator *enumerator = [self.userResponse keyEnumerator];
    id key;
    int count = 0;

    while (key = [enumerator nextObject]) {
        NSString *response = [[self userResponse] objectForKey:key];
        if ([response isEqualToString:@"YES"]) {
            count++;
        }
    }
    return count;
}

- (int) numberOfDeniedResponses {
    NSEnumerator *enumerator = [self.userResponse keyEnumerator];
    id key;
    int count = 0;
    
    while (key = [enumerator nextObject]) {
        NSString *response = [[self userResponse] objectForKey:key];
        if ([response isEqualToString:@"NO"]) {
            count++;
        }
    }
    return count;
}

- (int) numberOfConfusedResponses {
    NSEnumerator *enumerator = [self.userResponse keyEnumerator];
    id key;
    int count = 0;
    
    while (key = [enumerator nextObject]) {
        NSString *response = [[self userResponse] objectForKey:key];
        if ([response isEqualToString:@"MAYBE"]) {
            count++;
        }
    }
    return count;
}


@end
