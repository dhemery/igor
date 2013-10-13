#import "DEPatternParser.h"

@protocol DEMatcher;

@interface FakeSimpleParser : NSObject <DEPatternParser>

+ (FakeSimpleParser *)parserThatYieldsNoSimpleMatchers;

+ (FakeSimpleParser *)parserThatYieldsSimpleMatcher:(id <DEMatcher>)simpleMatcher;

+ (FakeSimpleParser *)parserThatYieldsSimpleMatchers:(NSArray *)simpleMatchers;

@end