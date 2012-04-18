#import "PatternParser.h"

@protocol Matcher;

@interface FakeSimpleParser : NSObject <PatternParser>

+ (FakeSimpleParser *)parserThatYieldsNoSimpleMatchers;

+ (FakeSimpleParser *)parserThatYieldsSimpleMatcher:(id <Matcher>)simpleMatcher;

+ (FakeSimpleParser *)parserThatYieldsSimpleMatchers:(NSArray *)simpleMatchers;

@end