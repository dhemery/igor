#import "Matcher.h"

@interface SubjectSubtreeMatcher : Matcher

@property(retain, readonly) Matcher *subjectMatcher;
@property(retain, readonly) Matcher *subtreeMatcher;

+ (SubjectSubtreeMatcher *)withSubjectMatcher:(Matcher *)subjectMatcher subtreeMatcher:(Matcher *)subtreeMatcher;

@end
