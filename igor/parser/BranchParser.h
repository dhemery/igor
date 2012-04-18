#import "PatternParser.h"

@protocol QueryScanner;
@protocol ChainParser;

// TODO Test
@interface BranchParser : NSObject <PatternParser>

@property(strong) id <ChainParser> subjectChainParser;

+ (id <PatternParser>)parserWithChainParser:(id <ChainParser>)chainParser;

@end
