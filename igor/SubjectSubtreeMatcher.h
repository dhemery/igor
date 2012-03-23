#import "Matcher.h"
#import "RelationshipMatcher.h"

@interface SubjectSubtreeMatcher : NSObject<RelationshipMatcher>

@property(retain, readonly) id<RelationshipMatcher> subjectMatcher;
@property(retain, readonly) id<RelationshipMatcher> subtreeMatcher;

+ (SubjectSubtreeMatcher *)withSubjectMatcher:(id <RelationshipMatcher>)subjectMatcher subtreeMatcher:(id <RelationshipMatcher>)subtreeMatcher;

@end
