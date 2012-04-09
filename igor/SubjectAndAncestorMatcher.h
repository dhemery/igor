#import "SimpleMatcher.h"
#import "RelationshipMatcher.h"

@class InstanceMatcher;

@interface SubjectAndAncestorMatcher : NSObject <RelationshipMatcher>

@property(retain) id <RelationshipMatcher> ancestorMatcher;
@property(retain) InstanceMatcher *subjectMatcher;

+ (SubjectAndAncestorMatcher *)withSubjectMatcher:(InstanceMatcher *)subjectMatcher ancestorMatcher:(id <RelationshipMatcher>)ancestorMatcher;

@end
