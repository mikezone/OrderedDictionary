//
//  OrderedDictionary.m
//  OrderedDictionary
//
//  Created by Mike on 16/4/21.
//  Copyright © 2016年 Mike. All rights reserved.
//

#import "OrderedDictionary.h"

#define AssertKeysCountEqualToValuesCount NSAssert(_allKeys.count == _allValues.count, @"")

#define isLegalIndex(index) (index >= 0 || index < _allKeys.count)

@interface OrderedDictionary () {
    unsigned long *hasChanged;
}

@property (nonatomic, strong) NSMutableArray *allKeys;
@property (nonatomic, strong) NSMutableArray *allValues;

@end

@implementation OrderedDictionary

- (instancetype)init {
    if (self = [super init]) {
        hasChanged = 0;
        _allKeys = [NSMutableArray array];
        _allValues = [NSMutableArray array];
    }
    return self;
}

+ (instancetype)dictionary {
    return [[self alloc] init];
}

- (NSUInteger)count {
    return _allValues.count;
}

- (NSArray *)allKeys {
    return _allKeys.copy;
}

- (NSArray *)allValues {
    return _allValues.copy;
}

#pragma mark - get

- (id)keyAtIndex:(NSUInteger)index {
    return isLegalIndex(index) ? _allKeys[index] : nil;
}

- (id)objectAtIndex:(NSUInteger)index {
    return isLegalIndex(index) ? _allValues[index] : nil;
}

- (id)objectForKey:(id)key {
    NSUInteger index = [_allKeys indexOfObject:key];
    return index == NSNotFound ? nil : _allValues[index];
}

- (id)objectForKeyedSubscript:(id)key {
    return [self objectForKey:key];
}

#pragma mark - set

- (void)setObject:(id)anObject atIndex:(NSUInteger)atIndex {
    if (isLegalIndex(atIndex)) {
        _allValues[atIndex] = anObject;
    }
}

- (void)setObject:(id)anObject forKey:(id)aKey {
    AssertKeysCountEqualToValuesCount;
    NSUInteger index = [_allKeys indexOfObject:aKey];
    if (anObject && aKey) {
        if (index == NSNotFound) {
            [_allKeys addObject:aKey];
            [_allValues addObject:anObject];
        } else {
            [_allValues setObject:anObject atIndexedSubscript:index];
        }
    }
}

- (void)setObject:(id)anObject forKeyedSubscript:(id<NSCopying>)aKey {
    [self setObject:anObject forKey:aKey];
}

#pragma mark - remove

- (void)removeObjectForKey:(id)aKey {
    AssertKeysCountEqualToValuesCount;
    NSUInteger index = [_allKeys indexOfObject:aKey];
    if (index != NSNotFound) {
        [_allKeys removeObject:aKey];
        [_allValues removeObjectAtIndex:index];
    }
}

- (void)removeAllObjects {
    AssertKeysCountEqualToValuesCount;
    [_allKeys removeAllObjects];
    [_allValues removeAllObjects];
}

- (void)removeObjectsForKeys:(NSArray *)keyArray {
    for (id key in keyArray) {
        [self removeObjectForKey:key];
    }
}

#pragma mark - enumerator

- (void)enumerateKeysAndObjectsUsingBlock:(void (^)(id key, id obj, BOOL *stop))block {
    BOOL stop = NO;
    for (NSUInteger i = 0; i < _allKeys.count; i++) {
        id key = _allKeys[i];
        id obj = _allValues[i];
        block(key, obj, &stop);
        if (stop) {
            break;
        }
    }
}

#pragma mark - others

- (NSString *)description {
    NSMutableString *mutableString = [NSMutableString stringWithString:@"{\n"];
    for (NSUInteger i = 0; i < self.allKeys.count; i++) {
        [mutableString appendFormat:@"\t%@ = %@;\n", _allKeys[i], _allValues[i]];
    }
    [mutableString appendString:@"}\n"];
    return mutableString;
}

@end
