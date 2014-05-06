//
//  User.m
//  StepUp
//
//  Created by Sachin Jindal on 2/8/14.
//
//

#import "User.h"

@implementation User

- (id) initWithUserId: (NSString*) userId andName: (NSString*) name andType: (UserType) type
             andEmail: (NSString*) email andLocation: (NSString*) location {
    self = [super init];
    
    if (self) {
        self.userId = userId;
        self.name = name;
        self.type = type;
        self.email = email;
        self.location = location;
    }
    return self;
}

-(id)init
{
    return [self initWithUserId:0 andName:@"UnNamed" andType:MENTEE andEmail:@"xxxxxx@gmail.com" andLocation:@"New York City"];
}

@end
