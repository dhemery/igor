#import "DEPatternParser.h"

@protocol DEQueryScanner;
@protocol DEChainParser;

// TODO Test
@interface DEBranchParser : NSObject <DEPatternParser>

@property(strong) id <DEChainParser> subjectChainParser;

+ (id <DEPatternParser>)parserWithChainParser:(id <DEChainParser>)chainParser;

@end
