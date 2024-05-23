%module(moduleimport="import $module") tmEventSetup

%{
#include "tmEventSetup/tmEventSetup.hh"
#include "tmEventSetup/esTypes.hh"
#include "tmEventSetup/esTriggerMenu.hh"
#include "tmEventSetup/esAlgorithm.hh"
#include "tmEventSetup/esCondition.hh"
#include "tmEventSetup/esObject.hh"
#include "tmEventSetup/esCut.hh"
#include "tmEventSetup/esCutValue.hh"
#include "tmEventSetup/esScale.hh"
#include "tmEventSetup/esBin.hh"
using namespace tmeventsetup;
%}

%include <std_map.i>
%include <std_vector.i>
%include <std_set.i>
%include <std_string.i>

%include "tmEventSetup/esCondition.hh"
%include "tmEventSetup/esObject.hh"
%include "tmEventSetup/esCut.hh"
%include "tmEventSetup/esCutValue.hh"
%include "tmEventSetup/esBin.hh"

namespace std {
  %template(AlgoMap) map<string, tmeventsetup::esAlgorithm *>;
  %template(CondMap) map<string, tmeventsetup::esCondition *>;
  %template(ScaleMap) map<string, tmeventsetup::esScale *>;
  %template(PrecMap) map<string, unsigned int>;
  %template(ObjVec) vector<tmeventsetup::esObject>;
  %template(CutVec) vector<tmeventsetup::esCut>;
  %template(BinVec) vector<tmeventsetup::esBin>;
  %template(StrVec) vector<string>;
  %template(StrSet) set<string>;
  %template(LlongVec) vector<long long>;
  %template(DoubleVec) vector<double>;
}

%{
  namespace swig {
    template <>  struct traits<tmeventsetup::esAlgorithm> {
      typedef pointer_category category;
     static const char* type_name() { return "tmeventsetup::esAlgorithm"; }
    };
    template <>  struct traits<tmeventsetup::esCondition> {
      typedef pointer_category category;
     static const char* type_name() { return "tmeventsetup::esCondition"; }
    };
    template <>  struct traits<tmeventsetup::esScale> {
      typedef pointer_category category;
     static const char* type_name() { return "tmeventsetup::esScale"; }
    };
  }
%}

typedef long esCombinationType;

%typemap(out) boost::optional<std::string> {
  if ($1) {
    $result = PyUnicode_FromString($1->c_str());
  } else {
    $result = Py_None;
    Py_INCREF(Py_None);
  }
}

%typemap(out) boost::optional<unsigned int> {
  if ($1) {
    $result = PyLong_FromUnsignedLong(static_cast<unsigned long>(*$1));
  } else {
    $result = Py_None;
    Py_INCREF(Py_None);
  }
}

%{
namespace tmeventsetup {
  extern const std::string& getGrammarVersion();
}
%}

namespace tmeventsetup {
  extern const std::string& getGrammarVersion();
}

%include "tmEventSetup/tmEventSetup.hh"
%include "tmEventSetup/esTypes.hh"
%include "tmEventSetup/esTriggerMenu.hh"
%include "tmEventSetup/esAlgorithm.hh"
%include "tmEventSetup/esCondition.hh"
%include "tmEventSetup/esScale.hh"
