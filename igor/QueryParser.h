#import "PatternParser.h"

@protocol ChainParser;

@interface QueryParser : NSObject <PatternParser>

+ (id <PatternParser>)parserWithChainParser:(id <ChainParser>)chainParser;

@end
