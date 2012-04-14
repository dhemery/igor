#import "CombinatorParser.h"

@interface FakeCombinatorParser : NSObject <CombinatorParser>

+ (id)parserThatYieldsNoCombinators;

@end