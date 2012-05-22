#import "DEPatternParser.h"

@protocol DEMatcher;

@interface FakeSubjectParser : NSObject <DEPatternParser>

+ (FakeSubjectParser *)parserThatYieldsNoSubjectMatchers;

+ (FakeSubjectParser *)parserThatYieldsSubjectMatcher:(id <DEMatcher>)subjectMatcher;

+ (FakeSubjectParser *)parserThatYieldsSubjectMatchers:(NSArray *)subjectMatchers;

@end