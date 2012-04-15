#import "SubjectPatternParser.h"

@protocol IgorQueryScanner;
@class SubjectChainParser;

// TODO Test
@interface BranchParser : NSObject <SubjectPatternParser>

+ (id <SubjectPatternParser>)parserWithScanner:(id <IgorQueryScanner>)scanner subjectChainParser:(SubjectChainParser *)subjectChainParser;


@end