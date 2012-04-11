#import "SimpleMatcher.h"
#import "SubjectMatcher.h"

@interface RelationshipMatcher : NSObject <SubjectMatcher>

@property(retain) id <SubjectMatcher> ancestorMatcher;
@property(retain) id <SubjectMatcher> subjectMatcher;

+ (RelationshipMatcher *)withSubjectMatcher:(id<SubjectMatcher>)subjectMatcher ancestorMatcher:(id <SubjectMatcher>)ancestorMatcher;

@end
