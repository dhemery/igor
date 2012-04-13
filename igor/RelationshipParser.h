#import "SubjectChainParser.h"

@protocol IgorQueryScanner;
@protocol SubjectPatternParser;

@interface RelationshipParser : NSObject <SubjectChainParser>

+ (id <SubjectChainParser>)parserWithScanner:(id <IgorQueryScanner>)scanner;


@end
