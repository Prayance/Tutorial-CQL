/*
    This use case is a very simplistic version of checking if the patient has normal temperature, and is an adult.
    Patient: 5342998

    Any CQL library must contain a library declaration line as the first line of the library.
    Use the syntax:
    library libraryName version 'number.number.number'
*/
library myLibrary version '1'
//All libraries and CQL expressions shall use FHIR based data models and you need to specify the version.
using FHIR version '4.0.1'

//FHIRHelpers is a common asset library details at: http://fhir.org/guides/cqf/common/Library-FHIRHelpers.html
include FHIRHelpers version '4.0.1' called FHIRHelpers

/*
    This example includes only the snowmed ct codesystem. You can use multiple codesystems
    If you want to add a specific version you follow the syntax:
    codesystem "codesystemName": 'codesystemLink' version 'versionLink'
*/
codesystem "ConditionClinicalStatusCodes": 'http://terminology.hl7.org/CodeSystem/condition-clinical'
codesystem "AllergyIntoleranceClinicalStatusCodes": 'http://terminology.hl7.org/CodeSystem/allergyintolerance-clinical'
codesystem "AllergyIntoleranceVerificationStatusCodes": 'http://terminology.hl7.org/CodeSystem/allergyintolerance-verification'
codesystem "Diagnosis Role": 'http://terminology.hl7.org/CodeSystem/diagnosis-role'
codesystem "LOINC": 'http://loinc.org'
codesystem "MedicationRequestCategory": 'http://terminology.hl7.org/CodeSystem/medicationrequest-category'
codesystem "ConditionVerificationStatusCodes": 'http://terminology.hl7.org/CodeSystem/condition-ver-status'
codesystem "SNOMEDCT": 'http://snomed.info/sct'
codesystem "RoleCode": 'http://terminology.hl7.org/CodeSystem/v3-RoleCode'
/*
    Value sets are lists of codes and corresponding terms
    The local identifier for the value set within CQL should be the same as the name of the value set in the https://vsac.nlm.nih.gov/
*/
valueset "Encounter Inpatient SNOMEDCT Value Set":
   'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.666.7.307|20160929'

valueset "Active Condition": 'http://fhir.org/guides/cqf/common/ValueSet/active-condition'
valueset "Inactive Condition": 'http://fhir.org/guides/cqf/common/ValueSet/inactive-condition'

valueset "Emergency Department Visit": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.292'
valueset "Encounter Inpatient": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.666.5.307'
valueset "Observation Services": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1111.143'
//valueset "Active Condition Codes": 'http://example.org/fhir/ValueSet/active-condition-codes'
//valueset "Inactive Condition Codes": 'http://example.org/fhir/ValueSet/inactive-condition-codes'
/*
    All direct codes in CQL MUST be a code from the code system (this case snowmed ct) and not a url
*/
code "Birthdate": '21112-8' from "LOINC" display 'Birth date'
code "Body temperature": '8310-5' from "LOINC" display 'Body temperature'

// Condition Clinical Status Codes - Consider value sets for these
code "Allergy to Felis catus protein": '1208807009' from "SNOMEDCT" display 'Allergy to Felis catus protein'
code "active": 'active' from "ConditionClinicalStatusCodes" display 'active'
code "allergy-active": 'active' from "AllergyIntoleranceClinicalStatusCodes" display 'allergy-active'
code "allergy-confirmed": 'confirmed' from "AllergyIntoleranceVerificationStatusCodes" display 'allergy-confirmed'
code "allergy-inactive": 'inactive' from "AllergyIntoleranceClinicalStatusCodes" display 'allergy-inactive'
code "allergy-refuted": 'refuted' from "AllergyIntoleranceVerificationStatusCodes" display 'allergy-refuted'
code "allergy-resolved": 'resolved' from "AllergyIntoleranceClinicalStatusCodes" display 'allergy-resolved'
code "allergy-unconfirmed": 'unconfirmed' from "AllergyIntoleranceVerificationStatusCodes" display 'allergy-unconfirmed'
code "Billing": 'billing' from "Diagnosis Role" display 'Billing'
code "Community": 'community' from "MedicationRequestCategory" display 'Community'
code "confirmed": 'confirmed' from "ConditionVerificationStatusCodes" display 'confirmed'
code "Dead": '419099009' from "SNOMEDCT" display 'Dead'
code "differential": 'differential' from "ConditionVerificationStatusCodes" display 'differential'
code "Discharge": 'discharge' from "MedicationRequestCategory" display 'Discharge'
code "entered-in-error": 'entered-in-error' from "ConditionVerificationStatusCodes" display 'entered-in-error'
code "ER": 'ER' from "RoleCode" display 'Emergency room'
code "ICU": 'ICU' from "RoleCode" display 'Intensive care unit'
code "inactive": 'inactive' from "ConditionClinicalStatusCodes" display 'inactive'
code "provisional": 'provisional' from "ConditionVerificationStatusCodes" display 'provisional'
code "recurrence": 'recurrence' from "ConditionClinicalStatusCodes" display 'recurrence'
code "refuted": 'refuted' from "ConditionVerificationStatusCodes" display 'refuted'
code "relapse": 'relapse' from "ConditionClinicalStatusCodes" display 'relapse'
code "remission": 'remission' from "ConditionClinicalStatusCodes" display 'remission'
code "resolved": 'resolved' from "ConditionClinicalStatusCodes" display 'resolved'
code "unconfirmed": 'unconfirmed' from "ConditionVerificationStatusCodes" display 'unconfirmed'


parameter "MeasurementPeriod" Interval<DateTime>
  default Interval[@2009-01-01T00:00:00.0, @2022-01-01T00:00:00.0)

context Patient

define function "LengthInDays"(Value Interval<DateTime> ):
  difference in days between start of Value and end of Value
  
define "Inpatient Encounter":
  [Encounter: "Encounter Inpatient"] EncounterInpatient
  		where EncounterInpatient.status = 'finished'
  		    and "LengthInDays"(EncounterInpatient.period) <= 120
  			and EncounterInpatient.period ends during "MeasurementPeriod"
              

define "aFever": 
  exists(ResolvedCondition([Condition: "Body temperature"]))  
  
define "hasFever": 
  exists(ActiveCondition([Condition: "Body temperature"]))
    
define "hadFever": 
  exists(InactiveCondition([Condition: "Body temperature"]))
        
    
define "InDemographic":
	AgeInYearsAt(start of MeasurementPeriod) >= 18
      
define "CloseToDemographic":
	AgeInYearsAt(start of MeasurementPeriod) < 18 and AgeInYearsAt(start of MeasurementPeriod) >= 16

define "SendAmessage":
    if "InDemographic"  then 'We got you!'
      else if "CloseToDemographic" then 'You are close to demographic!'
    else 'Enjoy life!'

//define a different time frame
define "period": Interval[@2022-01-01T00:00:00.0, @2022-10-10T00:00:00.0)

define "gender": Patient.gender

define "Diagnosis":
    [Condition]

define "Hospital admissions":
    [Encounter]

define "Lab tests":
    [Observation]

      
define "Errors":
  null
      
define function InactiveCondition(CondList List<Condition>):
  CondList C where C.verificationStatus ~ "inactive"

define function ResolvedCondition(CondList List<Condition>):
  CondList C where C.verificationStatus ~ "resolved"
  
define function ActiveCondition(CondList List<Condition>):
  CondList C
    where C.clinicalStatus ~ "active"
      and C.abatement is null  
    
    