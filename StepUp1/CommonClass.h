//
//  CommonClass.h
//  StepUp1
//
//  Created by Sunayna Jain on 2/9/14.
//  Copyright (c) 2014 LittleAuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonClass : NSObject

+ (CommonClass *) sharedCommonClass;

-(UIColor*)darkOrangeColor;

-(UIColor*)lightOrangeColor;

-(UIColor*)extraLightOrangeColor;

-(UIColor*)textGreyColor;
    
@end

