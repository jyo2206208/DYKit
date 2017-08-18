//
//  DYMacro.h
//  DYKitDemo
//
//  Created by DuYe on 2017/8/16.
//  Copyright © 2017年 DuYe. All rights reserved.
//

#ifndef DYMacro_h
#define DYMacro_h

// 懒加载
#define DY_LAZY(object, assignment) (object = object ?: assignment)
#define DYN_LAZY(object, typeClass) -(typeClass *)object{return _##object = (_##object ?: [[typeClass alloc] init]);}

// 动态添加属性
#ifndef DYSYNTH_DYNAMIC_PROPERTY_OBJECT
#define DYSYNTH_DYNAMIC_PROPERTY_OBJECT(_getter_, _setter_, _association_, _type_) \
- (void)_setter_ : (_type_)object { \
[self willChangeValueForKey:@#_getter_]; \
objc_setAssociatedObject(self, _cmd, object, OBJC_ASSOCIATION_ ## _association_); \
[self didChangeValueForKey:@#_getter_]; \
} \
- (_type_)_getter_ { \
return objc_getAssociatedObject(self, @selector(_setter_:)); \
}
#endif



#define metamacro_concat(A, B) \
metamacro_concat_(A, B)
#define metamacro_concat_(A, B) A ## B
#define uxy_property_basicDataType( __type, __name) \
property (nonatomic, assign, setter=set__##__name:, getter=__##__name) __type __name;

#define uxy_def_property_basicDataType( __type, __name) \
- (__type)__##__name   \
{   \
NSNumber *number = [self uxy_getAssociatedObjectForKey:#__name];    \
return metamacro_concat(metamacro_concat(__uxy_, __type), _value)( number ); \
}   \
- (void)set__##__name:(__type)__##__name   \
{ \
id value = @(__##__name);\
[self uxy_setAssignAssociatedObject:value forKey:#__name];     \
}

#define __uxy_int_value( __nubmer ) [__nubmer intValue]
#define __uxy_BOOL_value( __nubmer ) [__nubmer boolValue]
#define __uxy_NSTimeInterval_value( __nubmer ) [__nubmer doubleValue]


#endif /* DYMacro_h */
