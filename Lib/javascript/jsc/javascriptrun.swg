/* ----------------------------------------------------------------------------
 *  Errors and exceptions
 *
 * ---------------------------------------------------------------------------*/

#define SWIG_Error(code, msg)     SWIG_JSC_exception(context, exception, code, msg)
#define SWIG_exception(code, msg) SWIG_JSC_exception(context, exception, code, msg)
#define SWIG_fail                 goto fail

void SWIG_Javascript_Raise(JSContextRef context, JSValueRef *exception, const char* type) {
 JSStringRef message = JSStringCreateWithUTF8CString(type);
 *exception = JSValueMakeString(context, message);
 JSStringRelease(message);
}

void SWIG_JSC_exception(JSContextRef context, JSValueRef *exception, int code, const char* msg) {
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
  size_t refOwnerListMaxLength;
  size_t refOwnerListCurrentLength;
  JSObjectRef* refOwnerList;
} SwigPrivData;

JSValueRef _wrap_SwigObject_disown(JSContextRef context, JSObjectRef function, JSObjectRef thisObject, size_t argc, const JSValueRef argv[], JSValueRef* exception)
{
  JSValueRef jsresult;

  JSObjectRef obj = JSValueToObject(context, thisObject, NULL);
  SwigPrivData *cdata = (SwigPrivData *) JSObjectGetPrivate(obj);

  cdata->swigCMemOwn = false;

  jsresult = JSValueMakeUndefined(context);
  return jsresult;
}

JSValueRef _wrap_SwigObject_getCPtr(JSContextRef context, JSObjectRef function, JSObjectRef thisObject, size_t argc, const JSValueRef argv[], JSValueRef* exception)
{
  JSValueRef jsresult;
  long result;

  JSObjectRef obj = JSValueToObject(context, thisObject, NULL);
  SwigPrivData *cdata = (SwigPrivData*) JSObjectGetPrivate(obj);

  result = (long) cdata->swigCObject;
  jsresult = JSValueMakeNumber(context, result);

  return jsresult;
}

JSValueRef _wrap_SwigObject_equals(JSContextRef context, JSObjectRef function, JSObjectRef thisObject, size_t argc, const JSValueRef argv[], JSValueRef* exception)
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

JSStaticValue _SwigObject_values[] = {
  {
    0, 0, 0, 0
  }
};

JSStaticFunction _SwigObject_functions[] = {
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

JSClassDefinition _SwigObject_objectDefinition;

JSClassRef _SwigObject_classRef;


int SWIG_JSC_ConvertInstancePtr(JSContextRef context, JSObjectRef objRef, void** ptr, swig_type_info *info, int flags) {
  SwigPrivData *cdata = (SwigPrivData *) JSObjectGetPrivate(objRef);
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

int SWIG_JSC_ConvertPtr(JSContextRef context, JSValueRef valRef, void** ptr, swig_type_info *info, int flags) {
  if(!JSValueIsObject(context, valRef)) {
    return SWIG_TypeError;
  }

  JSObjectRef objRef = JSValueToObject(context, valRef, NULL);
  if(objRef == NULL) {
    return SWIG_ERROR;
  }

  return SWIG_JSC_ConvertInstancePtr(context, objRef, ptr, info, flags);
}

JSObjectRef SWIG_JSC_NewPointerObj(JSContextRef context, void *ptr, swig_type_info *info, int flags) {

  JSClassRef classRef;
  if(info->clientdata == NULL) {
    classRef = _SwigObject_classRef;
  } else {
    classRef = (JSClassRef) info->clientdata;
  }

  JSObjectRef result = JSObjectMake(context, classRef, NULL);

  SwigPrivData* cdata = (SwigPrivData*) malloc(sizeof(SwigPrivData));
  cdata->swigCObject = ptr;
  cdata->swigCMemOwn = (flags & SWIG_POINTER_OWN) ? 1 : 0;
  cdata->info = info;
  cdata->refOwnerListMaxLength = 0;
  cdata->refOwnerListCurrentLength = 0;
  cdata->refOwnerList = NULL;

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

JSStaticValue _SwigPackedData_values[] = {
  {
    0, 0, 0, 0
  }
};
JSStaticFunction _SwigPackedData_functions[] = {
  {
    0, 0, 0
  }
};
JSClassDefinition _SwigPackedData_objectDefinition;
JSClassRef _SwigPackedData_classRef;

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
}




/* For objectA and objectB, make objectA hold a reference to objectB
 * such that objectB cannot be collected until objectA is discarded.
 * Example: Tree: objectB is a child node of objectA. This will prevent the child (objectB) 
 * from being collected as long as the root node is alive.
 * 2 params are expected to be passed in. Function returns with the 2 params still on the stack.
 */
SWIGRUNTIME void SWIGJSC_AssociateReference(JSContextRef context, JSObjectRef objectA, JSObjectRef objectB)
{
  SwigPrivData *cdata;
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

  cdata = (SwigPrivData*) JSObjectGetPrivate(objectA);

  /* create the reference list if it doesn't exist */
  if(NULL == cdata->refOwnerList) {
    /* Use a standard vector resizing approach of doubling every time */
    cdata->refOwnerListMaxLength = 2;
    cdata->refOwnerListCurrentLength = 0;
    cdata->refOwnerList = (JSObjectRef*)malloc(cdata->refOwnerListMaxLength * sizeof(JSObjectRef));
  }

  /* make sure the array is large enough */
  if(cdata->refOwnerListCurrentLength == cdata->refOwnerListMaxLength) {
    JSObjectRef* newarray;
    /* Use a standard vector resizing approach of doubling every time */
    newarray = (JSObjectRef*)realloc(cdata->refOwnerList, 2 * cdata->refOwnerListMaxLength * sizeof(JSObjectRef));
    if(NULL == newarray) {
      JSValueRef jsexception = NULL;
      SWIG_Javascript_Raise(context, &jsexception, "realloc for refOwnerList failed");
      return;
    }
    free(cdata->refOwnerList);
    cdata->refOwnerList = newarray;
    /* update the max size now that we have successfully resized */
    cdata->refOwnerListMaxLength = cdata->refOwnerListMaxLength * 2;    
  }

  /* add objectB to objectA's reference list */
  cdata->refOwnerList[cdata->refOwnerListCurrentLength] = objectB;
  cdata->refOwnerListCurrentLength = cdata->refOwnerListCurrentLength + 1;

  /* increment the reference count on objectB to let the VM know we are retaining it */
  JSValueProtect(context, objectB);
}

SWIGRUNTIME void SWIGJSC_UnassociateReference(JSContextRef context, JSObjectRef objectA, JSObjectRef objectB)
{
  JSObjectRef obj;
  SwigPrivData *cdata_A;
  SwigPrivData *cdata_B;

  long i;
  long deleted_index = 0;

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
  cdata_A = (SwigPrivData*) JSObjectGetPrivate(objectA);
  cdata_B = (SwigPrivData*) JSObjectGetPrivate(objectB);

  /* This should be an assertion failure if the reference list doesn't exist */
  if(NULL == cdata_A->refOwnerList) {
    return;
  }
  /* This should be an assertion failure if the reference list is empty */
  if(0 == cdata_A->refOwnerListCurrentLength) {
    return;
  }

  /* go backwards to remove at the end of the list */
  for(i=cdata_A->refOwnerListCurrentLength; i>=0; i--) {
    SwigPrivData *cdata_current;
    JSObjectRef current_object = cdata_A->refOwnerList[i];
	  if( (current_object == objectB)
		  || (cdata_current->swigCObject == cdata_B->swigCObject)
	  )
	  {
		  /* We'll just record the index position now. We'll delete the entry below. */
		  deleted_index = i;

      /* decrement the retain count since we have the object handy */
      /* I'm a little worried about the case where current_object != objectB
         but the underlying pointers are equal. 
         The question arises, do I delete current_object or objectB?
         In many cases, it won't matter, but if the userdata wrappers have different 
         memory ownership rules, it could matter.
         But this is really an argument to fix the SWIG implementation to use 1-to-1 mappings
         which prevents these ambiguities from happening.
       */
      JSValueUnprotect(context, current_object);
      
		  break;
	  }
  }

  /* Should it be an error if you try to remove an association that doesn't exist?
	 If so, deleted_index == 0 at this point. You can use that to check.
  */

  /* We don't want to leave holes in the array, so shift all the entries back overwriting the deleted slot. */
  if(deleted_index != -1)
  {
	  for(i=deleted_index; i<cdata_A->refOwnerListCurrentLength; i++)
	  {
      cdata_A->refOwnerList[i] = cdata_A->refOwnerList[i+1];
	  }
	  /* now delete the last spot */
    cdata_A->refOwnerList[cdata_A->refOwnerListCurrentLength] = NULL;
    cdata_A->refOwnerListCurrentLength = cdata_A->refOwnerListCurrentLength - 1;
  }

}


