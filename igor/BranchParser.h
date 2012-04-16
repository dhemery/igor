#import "SubjectPatternParser.h"

@protocol IgorQueryScanner;
@class ChainParser;

// TODO Test
@interface BranchParser : NSObject <SubjectPatternParser>

+ (id <SubjectPatternParser>)parserWithScanner:(id <IgorQueryScanner>)scanner subjectChainParser:(ChainParser *)subjectChainParser;


@end