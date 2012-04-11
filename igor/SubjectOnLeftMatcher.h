#import "SimpleMatcher.h"
#import "SubjectMatcher.h"

@interface SubjectOnLeftMatcher : NSObject <SubjectMatcher>

@property(retain, readonly) id <SubjectMatcher> subject;
@property(retain, readonly) id <SubjectMatcher> tail;

+ (SubjectOnLeftMatcher *)withSubject:(id <SubjectMatcher>)subject tail:(id <SubjectMatcher>)tail;

@end
