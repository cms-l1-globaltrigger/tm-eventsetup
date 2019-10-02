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
%include <std_string.i>

namespace std {
  %template(AlgoMap) map<string, tmeventsetup::esAlgorithm *>;
  %template(CondMap) map<string, tmeventsetup::esCondition *>;
  %template(ScaleMap) map<string, tmeventsetup::esScale *>;
  %template(PrecMap) map<string, unsigned int>;
  %template(ObjVec) vector<tmeventsetup::esObject>;
  %template(CutVec) vector<tmeventsetup::esCut>;
  %template(BinVec) vector<tmeventsetup::esBin>;
  %template(StrVec) vector<string>;
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

%include "tmEventSetup/tmEventSetup.hh"
%include "tmEventSetup/esTypes.hh"
%include "tmEventSetup/esTriggerMenu.hh"
%include "tmEventSetup/esAlgorithm.hh"
%include "tmEventSetup/esCondition.hh"
%include "tmEventSetup/esObject.hh"
%include "tmEventSetup/esCut.hh"
%include "tmEventSetup/esCutValue.hh"
%include "tmEventSetup/esScale.hh"
%include "tmEventSetup/esBin.hh"
