#import "PatternParser.h"

@protocol QueryScanner;
@class ChainParser;

// TODO Test
@interface BranchParser : NSObject <PatternParser>

+ (id <PatternParser>)parserWithScanner:(id <QueryScanner>)scanner subjectChainParser:(ChainParser *)subjectChainParser;


@end