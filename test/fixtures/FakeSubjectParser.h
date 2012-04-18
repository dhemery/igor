#import "PatternParser.h"

@protocol Matcher;

@interface FakeSubjectParser : NSObject <PatternParser>

+ (FakeSubjectParser *)parserThatYieldsNoSubjectMatchers;

+ (FakeSubjectParser *)parserThatYieldsSubjectMatcher:(id <Matcher>)subjectMatcher;

+ (FakeSubjectParser *)parserThatYieldsSubjectMatchers:(NSArray *)subjectMatchers;

@end