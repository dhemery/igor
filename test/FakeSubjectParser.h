#import "SubjectPatternParser.h"

@interface FakeSubjectParser : NSObject <SubjectPatternParser>

+ (FakeSubjectParser *)parserThatYieldsNoSubjectMatchers;

+ (FakeSubjectParser *)parserThatYieldsSubjectMatcher:(id <SubjectMatcher>)subjectMatcher;

+ (FakeSubjectParser *)parserThatYieldsSubjectMatchers:(NSArray *)subjectMatchers;

@end