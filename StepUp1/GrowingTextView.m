//
//  GrowingTextView.m
//  StepUp1
//
//  Created by Sunayna Jain on 5/8/14.
//  Copyright (c) 2014 LittleAuk. All rights reserved.
//

#import "GrowingTextView.h"

@interface GrowingTextView(private)
-(void)commonInitialiser;
-(void)resizeTextView:(NSInteger)newSizeH;
-(void)growDidStop;
@end

@implementation GrowingTextView

// having initwithcoder allows us to use HPGrowingTextView in a Nib. -- aob, 9/2011
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        [self commonInitialiser];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self commonInitialiser];
    }
    return self;
}

//#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
//- (id)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer {
//    if ((self = [super initWithFrame:frame])) {
//        [self commonInitialiser:textContainer];
//    }
//    return self;
//}
//
//-(void)commonInitialiser {
//    [self commonInitialiser:nil];
//}

//-(void)commonInitialiser:(NSTextContainer *)textContainer
//#else
//-(void)commonInitialiser
//#endif
//{
//    // Initialization code
//    CGRect r = self.frame;
//    r.origin.y = 0;
//    r.origin.x = 0;
//#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
////    self.internalTextView = [[TextViewInternal alloc] initWithFrame:r textContainer:textContainer];
////    
//    self.internalTextView = [[TextViewInternal alloc]initWithFrame:r];
//#else
//    self.internalTextView = [[TextViewInternal alloc] initWithFrame:r];
//#endif
//    self.internalTextView.delegate = self;
//    self.internalTextView.scrollEnabled = NO;
//    self.internalTextView.font = [UIFont fontWithName:@"Helvetica" size:13];
//    self.internalTextView.contentInset = UIEdgeInsetsZero;
//    self.internalTextView.showsHorizontalScrollIndicator = NO;
//    self.internalTextView.text = @"-";
//    self.internalTextView.contentMode = UIViewContentModeRedraw;
//    [self addSubview:self.internalTextView];
//    
//    self.minHeight = self.internalTextView.frame.size.height;
//    self.minNumberOfLines = 1;
//    
//    self.animateHeightChange = YES;
//    self.animationDuration = 0.1f;
//    
//    self.internalTextView.text = @"";
//    
//    [self setMaxNumberOfLines:3];
//    
//    [self setPlaceholderColor:[UIColor lightGrayColor]];
//    ((TextViewInternal*)self.internalTextView).displayPlaceHolder = YES;
//}

-(void)commonInitialiser
{
    self.internalTextView = [[TextViewInternal alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.internalTextView.delegate = self;
    self.internalTextView.scrollEnabled = NO;
    self.internalTextView.font = [UIFont fontWithName:@"Helvetica" size:13];
    self.internalTextView.contentInset = UIEdgeInsetsZero;
    self.internalTextView.showsHorizontalScrollIndicator = NO;
    self.internalTextView.text = @"-";
    self.internalTextView.contentMode = UIViewContentModeRedraw;
    [self addSubview:self.internalTextView];
    
    self.minHeight = self.internalTextView.frame.size.height;
    self.minNumberOfLines = 1;
    
    self.animateHeightChange = YES;
    self.animationDuration = 0.1f;
    
    self.internalTextView.text = @"";
    
    [self setMaxNumberOfLines:3];
    
    [self setPlaceholderColor:[UIColor lightGrayColor]];
    ((TextViewInternal*)self.internalTextView).displayPlaceHolder = YES;
}

-(CGSize)sizeThatFits:(CGSize)size
{
    if (self.text.length == 0) {
        size.height = self.minHeight;
    }
    return size;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
	CGRect r = self.bounds;
	r.origin.y = 0;
	r.origin.x = self.contentInset.left;
    r.size.width -= self.contentInset.left + self.contentInset.right;
    
    self.internalTextView.frame = r;
}

-(void)setContentInset:(UIEdgeInsets)inset
{
    self.contentInset = inset;
    
    CGRect r = self.frame;
    r.origin.y = inset.top - inset.bottom;
    r.origin.x = inset.left;
    r.size.width -= inset.left + inset.right;
    
    self.internalTextView.frame = r;
    
    [self setMaxNumberOfLines:self.maxNumberOfLines];
    [self setMinNumberOfLines:self.minNumberOfLines];
}

-(UIEdgeInsets)contentInset
{
    return self.contentInset;
}

-(void)setMaxNumberOfLines:(int)n
{
    if(n == 0 && self.maxHeight > 0) return; // the user specified a maxHeight themselves.
    
    // Use internalTextView for height calculations, thanks to Gwynne <http://blog.darkrainfall.org/>
    NSString *saveText = self.internalTextView.text, *newText = @"-";
    
    self.internalTextView.delegate = nil;
    self.internalTextView.hidden = YES;
    
    for (int i = 1; i < n; ++i)
        newText = [newText stringByAppendingString:@"\n|W|"];
    
    self.internalTextView.text = newText;
    
    self.maxHeight = [self measureHeight];
    
    self.internalTextView.text = saveText;
    self.internalTextView.hidden = NO;
    self.internalTextView.delegate = self;
    
    [self sizeToFit];
    
    self.maxNumberOfLines = n;
}

-(int)maxNumberOfLines
{
    return self.maxNumberOfLines;
}

- (void)setMaxHeight:(int)height
{
    self.maxHeight = height;
    self.maxNumberOfLines = 0;
}

-(void)setMinNumberOfLines:(int)m
{
    if(m == 0 && self.minHeight > 0) return; // the user specified a minHeight themselves.
    
	// Use internalTextView for height calculations, thanks to Gwynne <http://blog.darkrainfall.org/>
    NSString *saveText = self.internalTextView.text, *newText = @"-";
    
    self.internalTextView.delegate = nil;
    self.internalTextView.hidden = YES;
    
    for (int i = 1; i < m; ++i)
        newText = [newText stringByAppendingString:@"\n|W|"];
    
    self.internalTextView.text = newText;
    
    self.minHeight = [self measureHeight];
    
    self.internalTextView.text = saveText;
    self.internalTextView.hidden = NO;
    self.internalTextView.delegate = self;
    
    [self sizeToFit];
    
    self.minNumberOfLines = m;
}

-(int)minNumberOfLines
{
    return self.minNumberOfLines;
}

- (void)setMinHeight:(int)height
{
    self.minHeight = height;
    self.minNumberOfLines = 0;
}

- (NSString *)placeholder
{
    return ((TextViewInternal*)self.internalTextView).placeholder;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    [((TextViewInternal*)self.internalTextView) setPlaceholder:placeholder];
    [((TextViewInternal*)self.internalTextView) setNeedsDisplay];
}

- (UIColor *)placeholderColor
{
    return ((TextViewInternal*)self.internalTextView).placeholderColor;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    [((TextViewInternal*)self.internalTextView) setPlaceholderColor:placeholderColor];
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self refreshHeight];
}

- (void)refreshHeight
{
	//size of content, so we can set the frame of self
	NSInteger newSizeH = [self measureHeight];
	if (newSizeH < self.minHeight || !self.internalTextView.hasText) {
        newSizeH = self.minHeight; //not smalles than minHeight
    }
    else if (self.maxHeight && newSizeH > self.maxHeight) {
        newSizeH = self.maxHeight; // not taller than maxHeight
    }
    
	if (self.internalTextView.frame.size.height != newSizeH)
	{
        // if our new height is greater than the maxHeight
        // sets not set the height or move things
        // around and enable scrolling
        if (newSizeH >= self.maxHeight)
        {
            if(!self.internalTextView.scrollEnabled){
                self.internalTextView.scrollEnabled = YES;
                [self.internalTextView flashScrollIndicators];
            }
            
        } else {
            self.internalTextView.scrollEnabled = NO;
        }
        
        // [fixed] Pasting too much text into the view failed to fire the height change,
        // thanks to Gwynne <http://blog.darkrainfall.org/>
		if (newSizeH <= self.maxHeight)
		{
            if(self.animateHeightChange) {
                
                if ([UIView resolveClassMethod:@selector(animateWithDuration:animations:)]) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
                    [UIView animateWithDuration:self.animationDuration
                                          delay:0
                                        options:(UIViewAnimationOptionAllowUserInteraction|
                                                 UIViewAnimationOptionBeginFromCurrentState)
                                     animations:^(void) {
                                         [self resizeTextView:newSizeH];
                                     }
                                     completion:^(BOOL finished) {
                                         if ([self.delegate respondsToSelector:@selector(growingTextView:didChangeHeight:)]) {
                                             [self.delegate growingTextView:self didChangeHeight:newSizeH];
                                         }
                                     }];
#endif
                } else {
                    [UIView beginAnimations:@"" context:nil];
                    [UIView setAnimationDuration:self.animationDuration];
                    [UIView setAnimationDelegate:self];
                    [UIView setAnimationDidStopSelector:@selector(growDidStop)];
                    [UIView setAnimationBeginsFromCurrentState:YES];
                    [self resizeTextView:newSizeH];
                    [UIView commitAnimations];
                }
            } else {
                [self resizeTextView:newSizeH];
                // [fixed] The growingTextView:didChangeHeight: delegate method was not called at all when not animating height changes.
                // thanks to Gwynne <http://blog.darkrainfall.org/>
                
                if ([self.delegate respondsToSelector:@selector(growingTextView:didChangeHeight:)]) {
                    [self.delegate growingTextView:self didChangeHeight:newSizeH];
                }
            }
		}
	}
    // Display (or not) the placeholder string
    
    BOOL wasDisplayingPlaceholder = ((TextViewInternal*)self.internalTextView).displayPlaceHolder;
    ((TextViewInternal*)self.internalTextView).displayPlaceHolder = self.internalTextView.text.length == 0;
    
    if (wasDisplayingPlaceholder != ((TextViewInternal*)self.internalTextView).displayPlaceHolder) {
        [self.internalTextView setNeedsDisplay];
    }
    
    
    // scroll to caret (needed on iOS7)
    if ([self respondsToSelector:@selector(snapshotViewAfterScreenUpdates:)])
    {
        [self performSelector:@selector(resetScrollPositionForIOS7) withObject:nil afterDelay:0.1f];
    }
    
    // Tell the delegate that the text view changed
    if ([self.delegate respondsToSelector:@selector(growingTextViewDidChange:)]) {
		[self.delegate growingTextViewDidChange:self];
	}
}

// Code from apple developer forum - @Steve Krulewitz, @Mark Marszal, @Eric Silverberg
- (CGFloat)measureHeight
{
    if ([self respondsToSelector:@selector(snapshotViewAfterScreenUpdates:)])
    {
        return ceilf([self.internalTextView sizeThatFits:self.internalTextView.frame.size].height);
    }
    else {
        return self.internalTextView.contentSize.height;
    }
}

- (void)resetScrollPositionForIOS7
{
    CGRect r = [self.internalTextView caretRectForPosition:self.internalTextView.selectedTextRange.end];
    CGFloat caretY =  MAX(r.origin.y - self.internalTextView.frame.size.height + r.size.height + 8, 0);
    if (self.internalTextView.contentOffset.y < caretY && r.origin.y != INFINITY)
        self.internalTextView.contentOffset = CGPointMake(0, caretY);
}

-(void)resizeTextView:(NSInteger)newSizeH
{
    if ([self.delegate respondsToSelector:@selector(growingTextView:willChangeHeight:)]) {
        [self.delegate growingTextView:self willChangeHeight:newSizeH];
    }
    
    CGRect internalTextViewFrame = self.frame;
    internalTextViewFrame.size.height = newSizeH; // + padding
    self.frame = internalTextViewFrame;
    
    internalTextViewFrame.origin.y = self.contentInset.top - self.contentInset.bottom;
    internalTextViewFrame.origin.x = self.contentInset.left;
    
    if(!CGRectEqualToRect(self.internalTextView.frame, internalTextViewFrame)) self.internalTextView.frame = internalTextViewFrame;
}

- (void)growDidStop
{
    // scroll to caret (needed on iOS7)
    if ([self respondsToSelector:@selector(snapshotViewAfterScreenUpdates:)])
    {
        [self resetScrollPositionForIOS7];
    }
    
	if ([self.delegate respondsToSelector:@selector(growingTextView:didChangeHeight:)]) {
		[self.delegate growingTextView:self didChangeHeight:self.frame.size.height];
	}
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.internalTextView becomeFirstResponder];
}

- (BOOL)becomeFirstResponder
{
    [super becomeFirstResponder];
    return [self.internalTextView becomeFirstResponder];
}

-(BOOL)resignFirstResponder
{
	[super resignFirstResponder];
	return [self.internalTextView resignFirstResponder];
}

-(BOOL)isFirstResponder
{
    return [self.internalTextView isFirstResponder];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark UITextView properties
///////////////////////////////////////////////////////////////////////////////////////////////////

-(void)setText:(NSString *)newText
{
    self.internalTextView.text = newText;
    
    // include this line to analyze the height of the textview.
    // fix from Ankit Thakur
    [self performSelector:@selector(textViewDidChange:) withObject:self.internalTextView];
}

-(NSString*) text
{
    return self.internalTextView.text;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

-(void)setFont:(UIFont *)afont
{
	self.internalTextView.font= afont;
    
	[self setMaxNumberOfLines:self.maxNumberOfLines];
	[self setMinNumberOfLines:self.minNumberOfLines];
}

-(UIFont *)font
{
	return self.internalTextView.font;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

-(void)setTextColor:(UIColor *)color
{
	self.internalTextView.textColor = color;
}

-(UIColor*)textColor{
	return self.internalTextView.textColor;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

-(void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
	self.internalTextView.backgroundColor = backgroundColor;
}

-(UIColor*)backgroundColor
{
    return self.internalTextView.backgroundColor;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

-(void)setTextAlignment:(NSTextAlignment)aligment
{
	self.internalTextView.textAlignment = aligment;
}

-(NSTextAlignment)textAlignment
{
	return self.internalTextView.textAlignment;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

-(void)setSelectedRange:(NSRange)range
{
	self.internalTextView.selectedRange = range;
}

-(NSRange)selectedRange
{
	return self.internalTextView.selectedRange;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

- (void)setIsScrollable:(BOOL)isScrollable
{
    self.internalTextView.scrollEnabled = isScrollable;
}

- (BOOL)isScrollable
{
    return self.internalTextView.scrollEnabled;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

-(void)setEditable:(BOOL)beditable
{
	self.internalTextView.editable = beditable;
}

-(BOOL)isEditable
{
	return self.internalTextView.editable;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

-(void)setReturnKeyType:(UIReturnKeyType)keyType
{
	self.internalTextView.returnKeyType = keyType;
}

-(UIReturnKeyType)returnKeyType
{
	return self.internalTextView.returnKeyType;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

- (void)setKeyboardType:(UIKeyboardType)keyType
{
	self.internalTextView.keyboardType = keyType;
}

- (UIKeyboardType)keyboardType
{
	return self.internalTextView.keyboardType;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

- (void)setEnablesReturnKeyAutomatically:(BOOL)enablesReturnKeyAutomatically
{
    self.internalTextView.enablesReturnKeyAutomatically = enablesReturnKeyAutomatically;
}

- (BOOL)enablesReturnKeyAutomatically
{
    return self.internalTextView.enablesReturnKeyAutomatically;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

-(void)setDataDetectorTypes:(UIDataDetectorTypes)datadetector
{
	self.internalTextView.dataDetectorTypes = datadetector;
}

-(UIDataDetectorTypes)dataDetectorTypes
{
	return self.internalTextView.dataDetectorTypes;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

- (BOOL)hasText{
	return [self.internalTextView hasText];
}

- (void)scrollRangeToVisible:(NSRange)range
{
	[self.internalTextView scrollRangeToVisible:range];
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UITextViewDelegate


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
	if ([self.delegate respondsToSelector:@selector(growingTextViewShouldBeginEditing:)]) {
		return [self.delegate growingTextViewShouldBeginEditing:self];
        
	} else {
		return YES;
	}
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
	if ([self.delegate respondsToSelector:@selector(growingTextViewShouldEndEditing:)]) {
		return [self.delegate growingTextViewShouldEndEditing:self];
        
	} else {
		return YES;
	}
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)textViewDidBeginEditing:(UITextView *)textView {
	if ([self.delegate respondsToSelector:@selector(growingTextViewDidBeginEditing:)]) {
		[self.delegate growingTextViewDidBeginEditing:self];
	}
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)textViewDidEndEditing:(UITextView *)textView {
	if ([self.delegate respondsToSelector:@selector(growingTextViewDidEndEditing:)]) {
		[self.delegate growingTextViewDidEndEditing:self];
	}
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)atext {
    
	//weird 1 pixel bug when clicking backspace when textView is empty
	if(![textView hasText] && [atext isEqualToString:@""]) return NO;
    
	//Added by bretdabaker: sometimes we want to handle this ourselves
    if ([self.delegate respondsToSelector:@selector(growingTextView:shouldChangeTextInRange:replacementText:)])
        return [self.delegate growingTextView:self shouldChangeTextInRange:range replacementText:atext];
    
	if ([atext isEqualToString:@"\n"]) {
		if ([self.delegate respondsToSelector:@selector(growingTextViewShouldReturn:)]) {
			if (![self.delegate performSelector:@selector(growingTextViewShouldReturn:) withObject:self]) {
				return YES;
			} else {
				[textView resignFirstResponder];
				return NO;
			}
		}
	}
    
	return YES;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)textViewDidChangeSelection:(UITextView *)textView {
	if ([self.delegate respondsToSelector:@selector(growingTextViewDidChangeSelection:)]) {
		[self.delegate growingTextViewDidChangeSelection:self];
	}
}


@end