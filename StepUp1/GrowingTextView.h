//
//  GrowingTextView.h
//  StepUp1
//
//  Created by Sunayna Jain on 5/8/14.
//  Copyright (c) 2014 LittleAuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextViewInternal.h"

@class GrowingTextView;
@class TextViewInternal;

@protocol GrowingTextViewDelegate

@optional
- (BOOL)growingTextViewShouldBeginEditing:(GrowingTextView *)growingTextView;
- (BOOL)growingTextViewShouldEndEditing:(GrowingTextView *)growingTextView;

- (void)growingTextViewDidBeginEditing:(GrowingTextView *)growingTextView;
- (void)growingTextViewDidEndEditing:(GrowingTextView *)growingTextView;

- (BOOL)growingTextView:(GrowingTextView *)growingTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- (void)growingTextViewDidChange:(GrowingTextView *)growingTextView;

- (void)growingTextView:(GrowingTextView *)growingTextView willChangeHeight:(float)height;
- (void)growingTextView:(GrowingTextView *)growingTextView didChangeHeight:(float)height;

- (void)growingTextViewDidChangeSelection:(GrowingTextView *)growingTextView;
- (BOOL)growingTextViewShouldReturn:(GrowingTextView *)growingTextView;
@end

@interface GrowingTextView : UIView <UITextViewDelegate> {
    
//	TextViewInternal *internalTextView;
//    
//	int minHeight;
//	int maxHeight;
//    
//	//class properties
//	int maxNumberOfLines;
//	int minNumberOfLines;
//    
//	BOOL animateHeightChange;
//    NSTimeInterval animationDuration;
//    
//	//uitextview properties
//	NSObject <HPGrowingTextViewDelegate> *__unsafe_unretained delegate;
//	NSTextAlignment textAlignment;
//	NSRange selectedRange;
//	BOOL editable;
//	UIDataDetectorTypes dataDetectorTypes;
//	UIReturnKeyType returnKeyType;
//	UIKeyboardType keyboardType;
//    
//    UIEdgeInsets contentInset;
}

//real class properties
@property int maxNumberOfLines;

@property int minNumberOfLines;

@property (nonatomic) int maxHeight;

@property (nonatomic) int minHeight;

@property BOOL animateHeightChange;

@property NSTimeInterval animationDuration;

@property (nonatomic, strong) NSString *placeholder;

@property (nonatomic, strong) UIColor *placeholderColor;

@property (nonatomic, strong) UITextView *internalTextView;


//uitextview properties
@property(unsafe_unretained) NSObject<GrowingTextViewDelegate> *delegate;
@property(nonatomic,strong) NSString *text;
@property(nonatomic,strong) UIFont *font;
@property(nonatomic,strong) UIColor *textColor;
@property(nonatomic) NSTextAlignment textAlignment;    // default is NSTextAlignmentLeft
@property(nonatomic) NSRange selectedRange;            // only ranges of length 0 are supported
@property(nonatomic,getter=isEditable) BOOL editable;
@property(nonatomic) UIDataDetectorTypes dataDetectorTypes __OSX_AVAILABLE_STARTING(__MAC_NA, __IPHONE_3_0);
@property (nonatomic) UIReturnKeyType returnKeyType;
@property (nonatomic) UIKeyboardType keyboardType;
@property (assign) UIEdgeInsets contentInset;
@property (nonatomic) BOOL isScrollable;
@property(nonatomic) BOOL enablesReturnKeyAutomatically;

//#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
//- (id)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer;
//#endif
//
//uitextview methods
//need others? use .internalTextView
- (BOOL)becomeFirstResponder;
- (BOOL)resignFirstResponder;
- (BOOL)isFirstResponder;

- (BOOL)hasText;
- (void)scrollRangeToVisible:(NSRange)range;

// call to force a height change (e.g. after you change max/min lines)
- (void)refreshHeight;

@end