
#import "Matcher.h"

@interface SubjectSubtreeMatcher : NSObject<Matcher>

@property(retain,readonly) id<Matcher> subjectMatcher;
@property(retain,readonly) id<Matcher> subtreeMatcher;

+(id<Matcher>) withSubjectMatcher:(id<Matcher>)subjectMatcher subtreeMatcher:(id<Matcher>)subtreeMatcher;

@end
