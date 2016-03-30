//
//  TextAnalyzer.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/24/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TextAnalyzer.h"

@implementation TextAnalyzer

+ (void)analyze:(NSString *)str
{
    NSString *question = str;
    
    NSMutableCharacterSet *characters = [NSMutableCharacterSet whitespaceCharacterSet];
    NSCharacterSet *punctuation = [NSCharacterSet punctuationCharacterSet];
    [characters formUnionWithCharacterSet:punctuation];
    [characters removeCharactersInString:@"'"];
    
    NSArray *a = [question componentsSeparatedByCharactersInSet:characters];
    
    NSLinguisticTaggerOptions options = NSLinguisticTaggerOmitWhitespace;// | NSLinguisticTaggerOmitPunctuation;
    
    NSArray *lengOption = [NSLinguisticTagger availableTagSchemesForLanguage:@"en"];
    
    NSLinguisticTagger *tagger = [[NSLinguisticTagger alloc] initWithTagSchemes:lengOption options:options];
    
    tagger.string = question;
    
    [tagger enumerateTagsInRange:NSMakeRange(0, [question length])
                          scheme:NSLinguisticTagSchemeLexicalClass
                         options:options
                      usingBlock:^(NSString *tag, NSRange tokenRange, NSRange sentenceRange, BOOL *stop) {
                          
        NSString *token = [question substringWithRange:tokenRange];
//        NSLog(@"%@ %@: %@ %@", breaks, token, tag, breaks);
    }];
}

@end
