#import "SimpleMatcher.h"
#import "SubjectMatcher.h"

@interface BranchMatcher : NSObject <SubjectMatcher>

@property(retain, readonly) id <SubjectMatcher> subjectMatcher;
@property(retain, readonly) id <SubjectMatcher> descendantMatcher;

+ (BranchMatcher *)withSubjectMatcher:(id <SubjectMatcher>)subjectMatcher descendantMatcher:(id <SubjectMatcher>)descendantMatcher;

@end
