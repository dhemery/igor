#import "SubjectPatternParser.h"

@protocol Matcher;

@interface FakeSubjectParser : NSObject <SubjectPatternParser>

+ (FakeSubjectParser *)parserThatYieldsNoSubjectMatchers;

+ (FakeSubjectParser *)parserThatYieldsSubjectMatcher:(id <Matcher>)subjectMatcher;

+ (FakeSubjectParser *)parserThatYieldsSubjectMatchers:(NSArray *)subjectMatchers;

@end