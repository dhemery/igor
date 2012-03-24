#import "Matcher.h"
#import "RelationshipMatcher.h"

@interface SubjectAndDescendantMatcher : NSObject <RelationshipMatcher>

@property(retain, readonly) id <RelationshipMatcher> subjectMatcher;
@property(retain, readonly) id <RelationshipMatcher> descendantMatcher;

+ (SubjectAndDescendantMatcher *)withSubjectMatcher:(id <RelationshipMatcher>)subjectMatcher descendantMatcher:(id <RelationshipMatcher>)descendantMatcher;

@end
