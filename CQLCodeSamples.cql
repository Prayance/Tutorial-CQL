/*
    This use case is a very simplistic version of checking if the patient has normal temperature, and is an adult.
    Patient: 5342998
    Try those patients too: 2905670, 2929560

    Any CQL library must contain a library declaration line as the first line of the library.
    Use the syntax:
    library libraryName version 'number.number.number'
*/
library myLibrary version '1'
//All libraries and CQL expressions shall use FHIR based data models and you need to specify the version.
using FHIR version '4.0.1'

/*
  FHIRHelpers is a common asset library details at: http://fhir.org/guides/cqf/common/Library-FHIRHelpers.html
  If this does not work in dataphoria engine, remove the version and use 
  include FHIRHelpers called FHIRHelpers
*/
include FHIRHelpers version '4.0.1' called FHIRHelpers

/*
    This example includes references to some of the most common code systems, including Snowmedct and loinc.
    If you want to add a specific version you follow the syntax:
    codesystem "codesystemName": 'codesystemLink' version 'versionLink'
*/
codesystem "SNOMED": 'http://snomed.info/sct'
codesystem "LOINC": 'https://loinc.org/'
codesystem "ConditionCategoryCodes": 'http://terminology.hl7.org/CodeSystem/condition-category'
codesystem "ObservationCategoryCodes": 'http://terminology.hl7.org/CodeSystem/observation-category'
codesystem "ConditionClinicalStatusCodes": 'http://terminology.hl7.org/CodeSystem/condition-clinical'
/*
    Value sets are lists of codes and corresponding terms
    The local identifier for the value set within CQL should be the same as the name of the value set in the https://vsac.nlm.nih.gov/
*/
valueset "Active Condition": 'http://fhir.org/guides/cqf/common/ValueSet/active-condition'
valueset "Inactive Condition": 'http://fhir.org/guides/cqf/common/ValueSet/inactive-condition'

/*
    All direct codes in CQL MUST be a code from the code system (this case snowmed ct) and not a url
    I added some that may be helpful.
*/
code "Birthdate": '21112-8' from "LOINC" display 'Birth date'
code "Allergy to Felis catus protein": '1208807009' from "SNOMED" display 'Allergy to Felis catus protein'
code "active": 'active' from "ConditionClinicalStatusCodes" display 'active'
code "resolved": 'resolved' from "ConditionClinicalStatusCodes" display 'resolved'
code "inactive": 'inactive' from "ConditionClinicalStatusCodes" display 'inactive'
code "hypertension": '38341003' from "SNOMED" display 'hypertension'
code "rheumatoid arthritis": '69896004' from "SNOMED" display 'rheumatoid arthritis'

// The values of parameters are provided by the enviroment. 
parameter MeasurementPeriod Interval<DateTime>
    default Interval[@2019-01-01T00:00:00.0, @2022-10-10T00:00:00.0)

/*
    The context represents the accessibility of the data and by whom. 
        Context can be patient (data for the patient are accessible); 
        practitioner (data that are relevant to a single practitioner are accessible); 
        unfiltered (expressions do not refer to a specific context)
*/
context Patient

// The following 3 functions create a playful declaration of age ranges and whether a patient is on demographic or not with a message printout.
define "InDemographic":
	AgeInYearsAt(start of MeasurementPeriod) >= 18
      
define "CloseToDemographic":
	AgeInYearsAt(start of MeasurementPeriod) < 18 and AgeInYearsAt(start of MeasurementPeriod) >= 16

define "SendAmessage":
    if "InDemographic" then 'We got you!'
      else if "CloseToDemographic" then 'You are close to demographic!'
    else 'Enjoy life!'

//define a different time frame and then check if something is true
define "period": Interval[@2022-01-01T00:00:00.0, @2022-10-10T00:00:00.0)

//Print patient's gender
define "gender": Patient.gender



// The following 3 functions are showing all the relevant diagnosis, hospital admissions and lab tests of this patient
define "Diagnosis":
    [Condition]

define "Hospital admissions":
    [Encounter]

define "Lab tests":
    [Observation]

/********************************************************************************************************************
*********************************************************************************************************************
*******************Would you like to play with something before the hack day?****************************************
*******************Use the lines of code bellow and find out if the person has a cat allergy or not******************
*******************Why not making him have a cat allergy? ***********************************************************
*********************************************************************************************************************
********************************************************************************************************************* */

//check if a patient has a cat allergy - This is a sample code that will not work with the patient we have. 
define "hasActiveAllergy": 
  exists(ActiveCondition([Condition: "Allergy to Felis catus protein"]))

/*
    This is a sample of declaring a function. 
    The following function define active condition
*/   
define function ActiveCondition(CondList List<Condition>):
  CondList C
    where C.clinicalStatus ~ "active"
      and C.abatement is null  