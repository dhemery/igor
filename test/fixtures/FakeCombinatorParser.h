#import "DECombinatorParser.h"

@interface FakeCombinatorParser : NSObject <DECombinatorParser>

+ (id)parserThatYieldsCombinator:(id <DECombinator>)combinator;

+ (id)parserThatYieldsNoCombinators;

@end