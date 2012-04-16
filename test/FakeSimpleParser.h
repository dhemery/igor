#import "SimplePatternParser.h"

@protocol Matcher;

@interface FakeSimpleParser : NSObject <SimplePatternParser>

+ (FakeSimpleParser *)parserThatYieldsNoSimpleMatchers;

+ (FakeSimpleParser *)parserThatYieldsSimpleMatcher:(id <Matcher>)simpleMatcher;

+ (FakeSimpleParser *)parserThatYieldsSimpleMatchers:(NSArray *)simpleMatchers;

@end