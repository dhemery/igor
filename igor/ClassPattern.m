
#import "ClassMatcher.h"
#import "ClassPattern.h"
#import "KindOfClassMatcher.h"
#import "MemberOfClassMatcher.h"

@implementation ClassPattern

-(ClassMatcher*) parse:(NSScanner*)scanner {
    Class targetClass = [UIView class];
    Class selectorClass = [KindOfClassMatcher class];
    
    NSString* className;
    if([scanner scanCharactersFromSet:[NSCharacterSet letterCharacterSet] intoString:&className]) {
        targetClass = NSClassFromString(className);
        selectorClass = [MemberOfClassMatcher class];
    }
    if([scanner scanString:@"*" intoString:nil]) {
        selectorClass = [KindOfClassMatcher class];
    }
    return [selectorClass forClass:targetClass];
}

@end
