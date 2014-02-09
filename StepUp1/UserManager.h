//
//  UserManager.h
//  StepUp
//
//  Created by Sachin Jindal on 2/8/14.
//
//

// This class is intended to be used as an interface between User interface classes and
// the data storage. The class is responsible for doing the syncing with Firebase as well.


#import <Foundation/Foundation.h>
#import <Firebase/Firebase.h>
#import "User.h"

@interface UserManager : NSObject

+ (UserManager *) sharedInstance;

@property User* myUser;
@property (nonatomic, strong) Firebase* firebase;

- (User *) loadUserWithAuthCode: (NSString*) authCode;
- (User *) getUserWithUserId: (NSString*) userId;
- (BOOL) addUserToDatabase: (NSString*) authCode andUser: (User*) user;

@end
