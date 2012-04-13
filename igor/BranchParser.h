#import "SubjectPatternParser.h"

@protocol IgorQueryScanner;
@protocol SubjectChainParser;

@interface BranchParser : NSObject <SubjectPatternParser>

+ (id <SubjectPatternParser>)parserWithScanner:(id <IgorQueryScanner>)scanner subjectChainParser:(id <SubjectChainParser>)subjectChainParser;


@end