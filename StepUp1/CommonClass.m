//
//  CommonClass.m
//  StepUp1
//
//  Created by Sunayna Jain on 2/9/14.
//  Copyright (c) 2014 LittleAuk. All rights reserved.
//

#import "CommonClass.h"

@implementation CommonClass


+ (CommonClass *)sharedCommonClass {
    static CommonClass *sharedCommonClass = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedCommonClass = [[self alloc] init];
    });
    
    return sharedCommonClass;
}

-(UIColor*)darkOrangeColor {
    
    UIColor *darkOrangeColor = [UIColor colorWithRed:249.0/255.0 green:125.0/255.0 blue:54.0/255.0 alpha:1];
    
    return darkOrangeColor;
}

-(UIColor*)lightOrangeColor{
    
    UIColor *lighOrangeColor = [UIColor colorWithRed:248.0/255.0 green:165.0/255.0 blue:66.0/255.0 alpha:1];
    
    return lighOrangeColor;
}

-(UIColor*)extraLightOrangeColor{
    
    UIColor *lighOrangeColor = [UIColor colorWithRed:248.0/255.0 green:165.0/255.0 blue:66.0/255.0 alpha:1];
    
    return lighOrangeColor;
}

-(UIColor*)textGreyColor{
    
    UIColor *greyColor = [UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1];
    
    return greyColor;

}

@end
