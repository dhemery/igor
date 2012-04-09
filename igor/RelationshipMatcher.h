#import "SimpleMatcher.h"
#import "SubjectMatcher.h"

@class InstanceMatcher;

@interface RelationshipMatcher : NSObject <SubjectMatcher>

@property(retain) id <SubjectMatcher> ancestorMatcher;
@property(retain) InstanceMatcher *subjectMatcher;

+ (RelationshipMatcher *)withSubjectMatcher:(InstanceMatcher *)subjectMatcher ancestorMatcher:(id <SubjectMatcher>)ancestorMatcher;

@end
