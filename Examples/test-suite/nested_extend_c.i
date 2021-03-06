%module nested_extend_c

#if !defined(SWIGOCTAVE) && !defined(SWIG_JAVASCRIPT_V8)
%extend hiA {
  hiA() {
   union hiA *self = (union hiA *)malloc(sizeof(union hiA));
   self->c = 'h';
   return self;
  }
  char hi_extend() {
    return $self->c;
  }
}
%extend lowA {
  lowA() {
    struct lowA *self = (struct lowA *)malloc(sizeof(struct lowA));
    self->name = 0;
    self->num = 99;
    return self;
  }
  int low_extend() {
    return $self->num;
  }
}

%extend hiB {
  hiB() {
   union hiB *self = (union hiB *)malloc(sizeof(union hiB));
   self->c = 'h';
   return self;
  }
  char hi_extend() {
    return $self->c;
  }
}
%extend lowB {
  lowB() {
    struct lowB *self = (struct lowB *)malloc(sizeof(struct lowB));
    self->name = 0;
    self->num = 99;
    return self;
  }
  int low_extend() {
    return $self->num;
  }
}
#endif

%inline %{
typedef struct NestedA {
    int a;
    union hiA {
        char c;
        int d;
    } hiA_instance;

    struct lowA {
        char *name;
        int num;
    } lowA_instance;
} NestedA;

typedef struct {
    int a;
    union hiB {
        char c;
        int d;
    } hiB_instance;

    struct lowB {
        char *name;
        int num;
    } lowB_instance;
} NestedB;
%}

