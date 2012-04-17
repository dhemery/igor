#import "CombinatorParser.h"

@protocol QueryScanner;

@interface DescendantCombinatorParser : NSObject <CombinatorParser>

+ (id <CombinatorParser>)parserWithScanner:(id <QueryScanner>)theScanner;

@end