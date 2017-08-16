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


#endif /* DYMacro_h */
