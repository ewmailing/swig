/* ----------------------------------------------------------------------------
 *  Errors and exceptions
 *
 * ---------------------------------------------------------------------------*/

#define SWIG_Error(code, msg)     SWIG_JSC_exception(context, exception, code, msg)
#define SWIG_exception(code, msg) SWIG_JSC_exception(context, exception, code, msg)
#define SWIG_fail                 goto fail

SWIGRUNTIME void SWIG_Javascript_Raise(JSContextRef context, JSValueRef *exception, const char* type) {
 JSStringRef message = JSStringCreateWithUTF8CString(type);
 *exception = JSValueMakeString(context, message);
 JSStringRelease(message);
}

SWIGRUNTIME void SWIG_JSC_exception(JSContextRef context, JSValueRef *exception, int code, const char* msg) {
  SWIG_Javascript_Raise(context, exception, msg);
}

/* ----------------------------------------------------------------------------
 *  The parent class of all Proxies
 *
 * ---------------------------------------------------------------------------*/

typedef struct {
  bool swigCMemOwn;
  void *swigCObject;
  swig_type_info *info;
} SwigPrivData;

SWIGRUNTIME JSValueRef _wrap_SwigObject_disown(JSContextRef context, JSObjectRef function, JSObjectRef thisObject, size_t argc, const JSValueRef argv[], JSValueRef* exception)
{
  JSValueRef jsresult;

  JSObjectRef obj = JSValueToObject(context, thisObject, NULL);
  SwigPrivData *cdata = (SwigPrivData *) JSObjectGetPrivate(obj);

  cdata->swigCMemOwn = false;

  jsresult = JSValueMakeUndefined(context);
  return jsresult;
}

SWIGRUNTIME JSValueRef _wrap_SwigObject_getCPtr(JSContextRef context, JSObjectRef function, JSObjectRef thisObject, size_t argc, const JSValueRef argv[], JSValueRef* exception)
{
  JSValueRef jsresult;
  long result;

  JSObjectRef obj = JSValueToObject(context, thisObject, NULL);
  SwigPrivData *cdata = (SwigPrivData*) JSObjectGetPrivate(obj);

  result = (long) cdata->swigCObject;
  jsresult = JSValueMakeNumber(context, result);

  return jsresult;
}

SWIGRUNTIME JSValueRef _wrap_SwigObject_equals(JSContextRef context, JSObjectRef function, JSObjectRef thisObject, size_t argc, const JSValueRef argv[], JSValueRef* exception)
{
  JSValueRef jsresult;
  bool result;

  JSObjectRef obj = JSValueToObject(context, thisObject, NULL);
  SwigPrivData *cdata = (SwigPrivData*) JSObjectGetPrivate(obj);

  JSObjectRef obj2 = JSValueToObject(context, argv[0], NULL);
  SwigPrivData *cdata2 = (SwigPrivData*) JSObjectGetPrivate(obj2);

  result = (cdata->swigCObject == cdata2->swigCObject);
  jsresult = JSValueMakeBoolean(context, result);

  return jsresult;
}

SWIGRUNTIME JSStaticValue _SwigObject_values[] = {
  {
    0, 0, 0, 0
  }
};

SWIGRUNTIME JSStaticFunction _SwigObject_functions[] = {
  {
    "disown",_wrap_SwigObject_disown, kJSPropertyAttributeNone
  },
  {
    "equals",_wrap_SwigObject_equals, kJSPropertyAttributeNone
  },
  {
    "getCPtr",_wrap_SwigObject_getCPtr, kJSPropertyAttributeNone
  },
  {
    0, 0, 0
  }
};

SWIGRUNTIME JSClassDefinition _SwigObject_objectDefinition;

SWIGRUNTIME JSClassRef _SwigObject_classRef;


SWIGRUNTIME int SWIG_JSC_ConvertInstancePtr(JSContextRef context, JSObjectRef objRef, void** ptr, swig_type_info *info, int flags) {
  SwigPrivData *cdata;

  cdata = (SwigPrivData *) JSObjectGetPrivate(objRef);
  if(cdata == NULL) {
    return SWIG_ERROR;
  }
  if(cdata->info != info) {
    bool type_valid = false;
    swig_cast_info *t = info->cast;
    while(t != NULL) {
      if(t->type == cdata->info) {
        type_valid = true;
        break;
      }
      t = t->next;
    }
    if(!type_valid) {
      return SWIG_TypeError;
    }
  }

  *ptr = cdata->swigCObject;

  if(flags & SWIG_POINTER_DISOWN) {
    cdata->swigCMemOwn = false;
  }

  return SWIG_OK;
}

SWIGRUNTIME int SWIG_JSC_ConvertPtr(JSContextRef context, JSValueRef valRef, void** ptr, swig_type_info *info, int flags) {
  JSObjectRef objRef;

  /* special case: JavaScript null => C NULL pointer */
  if(JSValueIsNull(context, valRef)) {
    *ptr=0;
    return SWIG_OK;
  }

  if(!JSValueIsObject(context, valRef)) {
    return SWIG_TypeError;
  }

  objRef = JSValueToObject(context, valRef, NULL);
  if(objRef == NULL) {
    return SWIG_ERROR;
  }

  return SWIG_JSC_ConvertInstancePtr(context, objRef, ptr, info, flags);
}

SWIGRUNTIME JSObjectRef SWIG_JSC_NewPointerObj(JSContextRef context, void *ptr, swig_type_info *info, int flags) {
  JSClassRef classRef;
  JSObjectRef result;
  SwigPrivData *cdata;

  if (ptr == NULL) {
    return JSValueToObject(context, JSValueMakeNull(context), 0);
  }

  if(info->clientdata == NULL) {
    classRef = _SwigObject_classRef;
  } else {
    classRef = (JSClassRef) info->clientdata;
  }

  result = JSObjectMake(context, classRef, NULL);

  cdata = (SwigPrivData*) malloc(sizeof(SwigPrivData));
  cdata->swigCObject = ptr;
  cdata->swigCMemOwn = (flags & SWIG_POINTER_OWN) ? 1 : 0;
  cdata->info = info;

  JSObjectSetPrivate(result, cdata);

  return result;
}

#define SWIG_ConvertPtr(obj, ptr, info, flags)    SWIG_JSC_ConvertPtr(context, obj, ptr, info, flags)
#define SWIG_NewPointerObj(ptr, info, flags)      SWIG_JSC_NewPointerObj(context, ptr, info, flags)

#define SWIG_ConvertInstance(obj, pptr, type, flags)    SWIG_JSC_ConvertInstancePtr(context, obj, pptr, type, flags)
#define SWIG_NewInstanceObj(thisvalue, type, flags)     SWIG_JSC_NewPointerObj(context, thisvalue, type, flags)

#define SWIG_ConvertFunctionPtr(obj, pptr, type)        SWIG_JSC_ConvertPtr(context, obj, pptr, type, 0)
#define SWIG_NewFunctionPtrObj(ptr, type)               SWIG_JSC_NewPointerObj(context, ptr, type, 0)

/* ----------------------------------------------------------------------------
 *  A class for packed data
 *
 * ---------------------------------------------------------------------------*/

typedef struct {
  void *data;
  size_t size;
  swig_type_info *type;
} SwigPackedData;

SWIGRUNTIME JSStaticValue _SwigPackedData_values[] = {
  {
    0, 0, 0, 0
  }
};
SWIGRUNTIME JSStaticFunction _SwigPackedData_functions[] = {
  {
    0, 0, 0
  }
};
SWIGRUNTIME JSClassDefinition _SwigPackedData_objectDefinition;
SWIGRUNTIME JSClassRef _SwigPackedData_classRef;

SWIGRUNTIMEINLINE
int SwigJSCPacked_Check(JSContextRef context, JSValueRef valRef) {
  return JSValueIsObjectOfClass(context, valRef, _SwigPackedData_classRef);
}

SWIGRUNTIME
swig_type_info* SwigJSCPacked_UnpackData(JSContextRef context, JSValueRef valRef, void *ptr, size_t size) {
  if (SwigJSCPacked_Check(context, valRef)) {
    JSObjectRef objRef = JSValueToObject(context, valRef, NULL);
    SwigPackedData *sobj = (SwigPackedData *) JSObjectGetPrivate(objRef);
    if (sobj->size != size) return 0;
    memcpy(ptr, sobj->data, size);
    return sobj->type;
  } else {
    return 0;
  }
}

SWIGRUNTIME
int SWIG_JSC_ConvertPacked(JSContextRef context, JSValueRef valRef, void *ptr, size_t sz, swig_type_info *ty) {
  swig_type_info *to = SwigJSCPacked_UnpackData(context, valRef, ptr, sz);
  if (!to) return SWIG_ERROR;
  if (ty) {
    if (to != ty) {
      /* check type cast? */
      swig_cast_info *tc = SWIG_TypeCheck(to->name,ty);
      if (!tc) return SWIG_ERROR;
    }
  }
  return SWIG_OK;
}

SWIGRUNTIME
JSValueRef SWIG_JSC_NewPackedObj(JSContextRef context, void *data, size_t size, swig_type_info *type) {

  JSClassRef classRef = _SwigObject_classRef;
  JSObjectRef result = JSObjectMake(context, classRef, NULL);

  SwigPackedData* cdata = (SwigPackedData*) malloc(sizeof(SwigPackedData));
  cdata->data = data;
  cdata->size = size;
  cdata->type = type;

  JSObjectSetPrivate(result, cdata);

  return result;
}

/*  SwigPackedData wrappers  */
SWIGRUNTIME
void _wrap_SwigPackedData_delete(JSObjectRef obj)
{
  SwigPackedData* cdata = (SwigPackedData*) JSObjectGetPrivate(obj);
  if (cdata) {
    free(cdata->data);
  }
}

/* for C++ member pointers, ie, member methods */

#define SWIG_ConvertMember(obj, ptr, sz, ty)            SWIG_JSC_ConvertPacked(context, obj, ptr, sz, ty)
#define SWIG_NewMemberObj(ptr, sz, type)                SWIG_JSC_NewPackedObj(context, ptr, sz, type)


/* ---------------------------------------------------------------------------
 * Support for IN/OUTPUT typemaps (see Lib/typemaps/inoutlist.swg)
 *
 * ---------------------------------------------------------------------------*/
SWIGRUNTIME
unsigned int SWIGJSC_ArrayLength(JSContextRef context, JSObjectRef arr) {
  static JSStringRef LENGTH = 0;
  JSValueRef exception = NULL;
  JSValueRef js_length;
  double length;

  if (LENGTH == 0) {
    LENGTH = JSStringCreateWithUTF8CString("length");
  }

  js_length = JSObjectGetProperty(context, arr, LENGTH, &exception);
  if (exception == 0 && JSValueIsNumber(context, js_length)) {
    length = JSValueToNumber(context, js_length, 0);
    return (unsigned int) length;
  } else {
    return 0;
  }
}

SWIGRUNTIME
JSValueRef SWIGJSC_AppendOutput(JSContextRef context, JSValueRef value, JSValueRef obj) {
  JSObjectRef arr;
  unsigned int length;

  if (JSValueIsUndefined(context, value)) {
    arr = JSObjectMakeArray(context, 0, 0, 0);
  } else {
    arr = JSValueToObject(context, value, 0);
  }

  length = SWIGJSC_ArrayLength(context, arr);
  JSObjectSetPropertyAtIndex(context, arr, length, obj, 0);
  return arr;
}




/* For objectA and objectB, make objectA hold a reference to objectB
 * such that objectB cannot be collected until objectA is discarded.
 * Example: Tree: objectB is a child node of objectA. This will prevent the child (objectB) 
 * from being collected as long as the root node is alive.
 * 2 params are expected to be passed in. Function returns with the 2 params still on the stack.
 */
SWIGRUNTIME void SWIGJSC_AssociateReference(JSContextRef context, JSObjectRef objectA, JSObjectRef objectB)
{
  /*
    There are two tricky implementation details that this implementation tries to handle.
    1. SWIG may have multiple userdata wrapper instances for the same underlying C-ptr.
    2. A user may want to associate a reference multiple times.
    For 1, we need to compare against the underlying C-ptr instead of the user data when 
    unassociating (removing) because it may be out of the user's control whether
    they have the same userdata wrapper since this is a SWIG implementation detail.
    For 2, the easiest thing to do is make this a list instead of an associative array.
    This means that every Associate (add) must be balanced by an Unassociate (remove).
   */

 /* I tried extremely hard to implement this using only the C-API and keep the details hidden/private
    from the user, but I don't think it is possible with JavaScriptCore.
    The fundamental problem is that I don't see any way to make one object hold a reference to another
    from the C-API. The closest thing is JSValueProtect (which you will find my attempt in the commit history).
    But the problem is that JSCore disallows you from calling JSValueUnprotect during the finalizer.
    So it is impossible to break the reference and allow referenced objects to go free when the holding 
    object gets collected.
    So this implementation uses JavaScript directly to create a new hidden property (array)
    on the object which will store the references. The normal GC system will handle this correctly.
    The implementation is tricky because JSCore doesn't make it that easy to do what we need.
    Ultimately, we need to call a function that passes objectA and objectB which will create the reference
    array and add objectB to the list.
    But JSCore doesn't just let us pass objectA and objectB to JSEvaluateScript.
    So instead, we need to create a script that returns a function object which contains the implementation
    of what we need to do.
    Then we use that returned function object and invoke it with JSObjectCallAsFunction,
    because this function will allow us to pass our 2 JSObjectRefs for objectA and objectB.
    This works, but does create a visible (array) property: _swigRefAssocList on objectA.
  */
  JSObjectRef js_function_object;
  JSValueRef js_result;
  JSStringRef js_script_string;
  const JSValueRef arguments[2] = {objectA, objectB};
  js_script_string = JSStringCreateWithUTF8CString(
"(function () {\n"
  "return function (objectA, objectB) {\n"
    "if(typeof objectA._swigRefAssocList === 'undefined') {\n"
      "objectA._swigRefAssocList = [];\n"
    "}\n"
    "objectA._swigRefAssocList.push(objectB);\n"
  "}\n"
"}());\n"
    );
    js_result = JSEvaluateScript(context, js_script_string, NULL, NULL, 0, NULL);
    js_function_object = JSValueToObject(context, js_result, NULL);

    JSObjectCallAsFunction(context, js_function_object, NULL, 2, arguments, NULL);
    JSStringRelease(js_script_string);
}

SWIGRUNTIME void SWIGJSC_UnassociateReference(JSContextRef context, JSObjectRef objectA, JSObjectRef objectB)
{
  /*
	 There are two tricky implementation details that this implementation tries to handle.
	 1. SWIG may have multiple userdata wrapper instances for the same underlying C-ptr.
	 2. A user may want to associate a reference multiple times.
	 For 1, we need to compare against the underlying C-ptr instead of the user data when 
	 unassociating (removing) because it may be out of the user's control whether
	 they have the same userdata wrapper since this is a SWIG implementation detail.
	 For 2, the easiest thing to do is make this a list instead of an associative array.
	 This means that every Associate (add) must be balanced by an Unassociate (remove).
 */

 /* I tried extremely hard to implement this using only the C-API and keep the details hidden/private
    from the user, but I don't think it is possible with JavaScriptCore.
    The fundamental problem is that I don't see any way to make one object hold a reference to another
    from the C-API. The closest thing is JSValueProtect (which you will find my attempt in the commit history).
    But the problem is that JSCore disallows you from calling JSValueUnprotect during the finalizer.
    So it is impossible to break the reference and allow referenced objects to go free when the holding 
    object gets collected.
    So this implementation uses JavaScript directly to create a new hidden property (array)
    on the object which will store the references. The normal GC system will handle this correctly.
    The implementation is tricky because JSCore doesn't make it that easy to do what we need.
    Ultimately, we need to call a function that passes objectA and objectB which will create the reference
    array and add objectB to the list.
    But JSCore doesn't just let us pass objectA and objectB to JSEvaluateScript.
    So instead, we need to create a script that returns a function object which contains the implementation
    of what we need to do.
    Then we use that returned function object and invoke it with JSObjectCallAsFunction,
    because this function will allow us to pass our 2 JSObjectRefs for objectA and objectB.
    This works, but does create a visible (array) property: _swigRefAssocList on objectA.
  */
  /* Note: This implementation depends on 'equals' (_wrap_SwigObject_equals) in _SwigObject_functions.
     This relies on C-ptr comparisons which 'equals' does.
   */
  JSObjectRef js_function_object;
  JSValueRef js_result;
  JSStringRef js_script_string;
  const JSValueRef arguments[2] = {objectA, objectB};
  js_script_string = JSStringCreateWithUTF8CString(
"(function () {\n"
  "return function (objectA, objectB) {\n"
    "var i;\n"
    "var delete_index = -1;\n"
    "if(typeof objectA._swigRefAssocList === 'undefined') {\n"
      "return;\n"
    "}\n"
    "for(i=objectA._swigRefAssocList.length-1; i>=0; i--) {\n"
      "if(objectA.equals(objectB)) {\n"
        "delete_index = i;\n"
        "break;\n"
      "}\n"
    "}\n"
    "if(delete_index > -1) {\n"
      "objectA._swigRefAssocList.splice(delete_index, 1);\n"
    "}\n"
  "}\n"
"}());\n"
  );

  js_result = JSEvaluateScript(context, js_script_string, NULL, NULL, 0, NULL);
  js_function_object = JSValueToObject(context, js_result, NULL);

  JSObjectCallAsFunction(context, js_function_object, NULL, 2, arguments, NULL);
  JSStringRelease(js_script_string);  
}

/* This is a convenience wrapper function to convert types because the SWIG implementation mostly uses JSValueRef
   and not JSObjectRef.
   The assumption is that all JSValueRefs passed to this function MUST be convertable to JSObjectRefs.
*/
SWIGRUNTIME void SWIGJSC_AssociateReferenceWithJSValueRefs(JSContextRef context, JSValueRef objectA, JSValueRef objectB) {
  JSObjectRef objectAref;
  JSObjectRef objectBref;
  objectAref = JSValueToObject(context, objectA, NULL);
  objectBref = JSValueToObject(context, objectB, NULL);
  SWIGJSC_AssociateReference(context, objectAref, objectBref);
}
SWIGRUNTIME void SWIGJSC_UnassociateReferenceWithJSValueRefs(JSContextRef context, JSValueRef objectA, JSValueRef objectB) {
  JSObjectRef objectAref;
  JSObjectRef objectBref;
  objectAref = JSValueToObject(context, objectA, NULL);
  objectBref = JSValueToObject(context, objectB, NULL);
  SWIGJSC_UnassociateReference(context, objectAref, objectBref);
}

