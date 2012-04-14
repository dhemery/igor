#import "SubjectPatternParser.h"

@protocol IgorQueryScanner;
@class ChainParser;

// TODO Test
@interface BranchParser : NSObject <SubjectPatternParser>

+ (id <SubjectPatternParser>)parserWithScanner:(id <IgorQueryScanner>)scanner chainParser:(ChainParser *)relationshipParser;


@end