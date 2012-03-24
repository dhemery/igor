#import "Matcher.h"
#import "RelationshipMatcher.h"

@class NodeMatcher;

@interface SubjectAndAncestorMatcher : NSObject <RelationshipMatcher>

@property(retain) id <RelationshipMatcher> ancestorMatcher;
@property(retain) NodeMatcher *subjectMatcher;

+ (SubjectAndAncestorMatcher *)withSubjectMatcher:(NodeMatcher *)subjectMatcher ancestorMatcher:(id <RelationshipMatcher>)ancestorMatcher;

@end
