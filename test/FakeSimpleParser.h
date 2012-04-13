#import "SimplePatternParser.h"

@protocol SimpleMatcher;

@interface FakeSimpleParser : NSObject <SimplePatternParser>

+ (FakeSimpleParser *)parserThatYieldsNoSimpleMatchers;

+ (FakeSimpleParser *)parserThatYieldsSimpleMatcher:(id <SimpleMatcher>)simpleMatcher;

+ (FakeSimpleParser *)parserThatYieldsSimpleMatchers:(NSArray *)simpleMatchers;

@end