#import "SimpleMatcher.h"
#import "SubjectMatcher.h"

@interface SubjectOnRightMatcher : NSObject <SubjectMatcher>

@property(retain) id <SubjectMatcher> subject;
@property(retain) id <SubjectMatcher> head;

+ (SubjectOnRightMatcher *)withSubject:(id<SubjectMatcher>)subject head:(id <SubjectMatcher>)head;

@end
