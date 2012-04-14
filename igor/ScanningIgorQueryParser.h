@protocol IgorQueryScanner;
@protocol SubjectPatternParser;
@class RelationshipParser;

#import "IgorQueryParser.h"


@interface ScanningIgorQueryParser : NSObject <IgorQueryParser>

+ (id <IgorQueryParser>)parserWithScanner:(id <IgorQueryScanner>)scanner relationshipParser:(RelationshipParser *)relationshipParser;

@end
