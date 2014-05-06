//
//  UserManager.m
//  StepUp
//
//  Created by Sachin Jindal on 2/8/14.
//
//

#import "UserManager.h"

#define kFireBaseStepupUsersPath @"https://stepuphacker.firebaseio.com/stepup/users/"

@implementation UserManager

+ (UserManager *)sharedInstance {
    static UserManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        sharedInstance.firebase = [[Firebase alloc] initWithUrl:kFireBaseStepupUsersPath];
    });
    
    return sharedInstance;
}

- (User *) loadUserWithAuthCode: (NSString*) authCode {
    // Create a firebase ref for this particular authCode node
    NSString *rel_path = [@"authcodes/" stringByAppendingString:authCode];
    UserManager *um = [UserManager sharedInstance];
    Firebase* fb = [[um firebase] childByAppendingPath:rel_path];
    [fb observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        if ([snapshot hasChildren]) {
            NSString* userId = snapshot.value;
            NSLog(@"UserManager::loadUserWithAuthCode Fetched User id %@ with authcode %@", userId,
                  authCode);
            User* my_user = [um getUserWithUserId:userId];
            [um setMyUser:my_user];
        } else {
            [um setMyUser:nil];
        }
    }];
    return [[UserManager sharedInstance] myUser];
}

- (User *) getUserWithUserId: (NSString *) userId {
    NSString *rel_path = [@"userids/" stringByAppendingString:userId];
    Firebase* fb = [[[UserManager sharedInstance] firebase] childByAppendingPath:rel_path];
    __block User *my_user = nil;
    [fb observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        if ([snapshot hasChildren]) {
            NSString* name = snapshot.value[@"name"];
            UserType type = (UserType) snapshot.value[@"type"];
            NSString* email = snapshot.value[@"email"];
            NSString* location = snapshot.value[@"location"];
            NSLog(@"UserManager::getUserWithUserId Fetched User %@ with id %@", name, userId);
            my_user = [[User alloc] initWithUserId:userId andName:name andType:type
                                                andEmail:email andLocation:location];
        }
    }];
    return my_user;
}

- (BOOL) addUserToDatabase: (NSString*) authCode andUser: (User*) user {
    // To add a user to the database, first add user with its id to the id location
    // then add its auth code and id mapping
    NSString *userId = [user userId];
    NSString *rel_path = [@"userids/" stringByAppendingString:userId];
    Firebase* fb = [[[UserManager sharedInstance] firebase] childByAppendingPath:rel_path];
    NSNumber *user_type = [[NSNumber alloc] initWithUnsignedInteger:[user type]];
    __block BOOL user_added = false;
    [fb setValue:@{@"name": [user name],
                   @"type": user_type,
                   @"email": [user email],
                   @"location": [user location]} withCompletionBlock:^(NSError *error, Firebase *ref) {
                       if (error)
                       {
                           NSLog(@"UserManager::addUserToDatabase ALERT! User Addition failed: %@",
                                 [user name]);
                       } else
                       {
                           user_added = true;
                           NSLog(@"UserManager::addUserToDatabase User added successfully: %@ with id: %@",
                                 [user name], userId);
                       }
                   }];
    
    if (!user_added)
        return false;
    
    NSString *auth_path = [@"authcodes/" stringByAppendingString:authCode];
    fb = [[[UserManager sharedInstance] firebase] childByAppendingPath:auth_path];
    __block BOOL auth_added = false;
    [fb setValue:userId withCompletionBlock:^(NSError *error, Firebase *ref) {
        if (error)
        {
            NSLog(@"UserManager::addUserToDatabase ALERT! User Authcode addition failed: %@",
                  userId);
        } else
        {
            NSLog(@"UserManager::addUserToDatabase User authcode added successfully: %@ with authcode: %@",
                  userId, authCode);
            auth_added = true;
        }
    }];
    
    return auth_added;
}

@end
