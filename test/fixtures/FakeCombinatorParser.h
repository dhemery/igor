#import "CombinatorParser.h"

@interface FakeCombinatorParser : NSObject <CombinatorParser>

+ (id)parserThatYieldsCombinator:(id <Combinator>)combinator;

+ (id)parserThatYieldsNoCombinators;

@end