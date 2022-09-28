// Valid Patient: 25298
// Invalid Patient: P48

library TestArtifact version '1'
using FHIR version '4.0.0'
include "FHIRHelpers" version '4.0.0' called FHIRHelpers

codesystem "SNOMED": 'http://snomed.info/sct'
codesystem "ICD-10-CM": 'urn:oid:2.16.840.1.113883.6.90'
codesystem "CONDCLINSTATUS": 'http://terminology.hl7.org/CodeSystem/condition-clinical'
codesystem "CONDVERSTATUS": 'http://terminology.hl7.org/CodeSystem/condition-ver-status'

code "Essential hypertension (disorder) code": '59621000' from "SNOMED" display 'Essential hypertension (disorder)'
code "Malignant hypertensive chronic kidney disease (disorder) code": '285831000119108' from "SNOMED" display 'Malignant hypertensive chronic kidney disease (disorder)'
code "Condition Active code": 'active' from "CONDCLINSTATUS" display 'Active'
code "Condition Confirmed code": 'confirmed' from "CONDVERSTATUS" display 'Confirmed'

code "Fever (ICD-10)": 'R50.9' from "ICD-10-CM" display 'fever ICD-10'
code "Fever (SNOMED)": '267036007' from "SNOMED" display 'fever SNOMED'
code "Cough (ICD-10)": 'R05' from "ICD-10-CM" display 'cough ICD-10'
code "Cough (SNOMED)": '49727002' from "SNOMED" display 'cough SNOMED'
code "Sense of Smell Impaired (ICD-10)": 'R43.0' from "ICD-10-CM" display 'Sense of Smell Imparied ICD-10'
code "Sense of Smell Impaired (SNOMED)": '83156004' from "SNOMED" display 'Sense of Smell Imparied SNOMED'
code "Fatigue (SNOMED)": '84229001' from "SNOMED" display 'Fatigue SNOMED'
code "Myalgia (ICD-10)": 'M79.1' from "ICD-10-CM" display 'Myalgia ICD-10'
code "Myalgia (SNOMED)": '68962001'  from "SNOMED" display 'Myalgia SNOMED'
code "Artralgia (ICD-10)": 'M25.50' from "ICD-10-CM" display 'Artralgia ICD-10'
code "Artralgia (SNOMED)": '57676002' from "SNOMED" display 'Artralgia SNOMED'
code "Tight Chest (ICD-10)": 'R098' from "ICD-10-CM" display 'Tight Chest ICD-10'
code "Tight Chest (SNOMED)": '23924001'  from "SNOMED" display 'Tight Chest SNOMED'
code "Gastrointestinal symptoms (ICD-10)": 'R198' from "ICD-10-CM" display 'Gastrointestinal symptoms ICD-10'
code "Gastrointestinal symptoms (SNOMED)": '267045008'  from "SNOMED" display 'Gastrointestinal symptoms SNOMED'
code "Headache (ICD-10)": 'G438' from "ICD-10-CM" display 'Headache ICD-10'
code "Headache (SNOMED)": '25064002'  from "SNOMED" display 'Headache SNOMED'
code "Dizziness (ICD-10)": 'R42' from "ICD-10-CM" display 'Dizziness ICD-10'
code "Dizziness (SNOMED)": '404640003'  from "SNOMED" display 'Dizziness SNOMED'
concept "Condition Active": { "Condition Active code" } display 'Active'
concept "Condition Confirmed": { "Condition Confirmed code" } display 'Confirmed'
parameter "Measurement Period" Interval<DateTime>
    default Interval[@2020-11-11T00:00:00.0, @2020-12-12T00:00:00.0)  
  
context Patient

define "AgeRange-old at end of Measurement Period":
  AgeInYearsAt(end of "Measurement Period") between 60 and 110
    
define "AgeRange-middle at end of Measurement Period":
  AgeInYearsAt(end of "Measurement Period") between 20 and 59
    
define "AgeRange-young at end of Measurement Period":
  AgeInYearsAt(end of "Measurement Period") < 19

//Define Covid-19 tiers
define "England-Tier3":
    { 'South Yorkshire', 'West Yorkshire', 'North East Lincolnshire', 'North Lincolnshire', 'Kingston upon Hull/Hull', 'East Riding of Yorkshire' }
define "England-Tier2":
    { 'Bedfordshire and Milton Keynes', 'Cambridgeshire', 'Essex', 'Hertfordshire', 'Norfolk', 'Suffolk', 'Northamptonshire', 'Rutland', 'London', 'Cumbria', 'Liverpool City Region', 'Warrington and Cheshire', 'South East', 'Bracknell Forest', 'Brighton and Hove', 'Buckinghamshire', 'East Sussex', 'Hampshire', 'Oxfordshire', 'Reading', 'Surrey', 'West Berkshire', 'West Sussex', 'Windsor and Maidenhead', 'Wokingham', 'South West', 'Bath', 'Bournemouth, Christchurch and Poole', 'Devon', 'Dorset', 'Gloucestershire', 'Somerset', 'Wiltshire and Swindon', 'West Midlands', 'Herefordshire', 'Shropshire and Telford & Wrekin', 'Worcestershire', 'Yorkshire', 'City of York', 'North Yorkshire' }
define "England-Teir1":
    { 'Isle of Wight', 'Cornwall', 'Isles of Scilly'}
      
// Test if patient in tier3
define "PatientInTier3":
    if exists ([Condition: Patient.address.district.value in "England-Tier3"]) then true
      else false

//test if patient has the symptoms
define "HasFever":
  exists(ActiveCondition([Condition: "Fever (ICD-10)"])) or exists(ActiveCondition([Condition: "Fever (SNOMED)"]))
define "HasCough":
  exists(ActiveCondition([Condition: "Cough (ICD-10)"])) or exists(ActiveCondition([Condition: "Cough (SNOMED)"]))
define "HasSenseOfSmellImpared":
  exists(ActiveCondition([Condition: "Sense of Smell Impaired (ICD-10)"])) or exists(ActiveCondition([Condition: "Sense of Smell Impaired (SNOMED)"]))
    
define "HasFatigue":
    exists(ActiveCondition([Condition: "Fatigue (SNOMED)"]))
define "HasMyalgia":
  exists(ActiveCondition([Condition: "Myalgia (ICD-10)"])) or exists(ActiveCondition([Condition: "Myalgia (SNOMED)"]))  
    
define "HasArtralgia":
  exists(ActiveCondition([Condition: "Artralgia (ICD-10)"])) or exists(ActiveCondition([Condition: "Artralgia (SNOMED)"]))      
define "HasTightChest":
  exists(ActiveCondition([Condition: "Tight Chest (ICD-10)"])) or exists(ActiveCondition([Condition: "Tight Chest (SNOMED)"]))    
    
define "HasGastrointestinalSymptoms":
  exists(ActiveCondition([Condition: "Gastrointestinal symptoms (ICD-10)"])) or exists(ActiveCondition([Condition: "Gastrointestinal symptoms (SNOMED)"]))      
    
define "HasHeadache":
  exists(ActiveCondition([Condition: "Headache (ICD-10)"])) or exists(ActiveCondition([Condition: "Headache (SNOMED)"]))  
    
define "HasDizziness":
  exists(ActiveCondition([Condition: "Dizziness (ICD-10)"])) or exists(ActiveCondition([Condition: "Dizziness (SNOMED)"]))  

/* Not really used but good to have */
define "MeetsInclusionCriteria":
    ("AgeRange-old at end of Measurement Period"
  and "HasFever") or  ("AgeRange-old at end of Measurement Period"
  and "HasCough" ) or     ("AgeRange-old at end of Measurement Period"
  and "HasSenseOfSmellImpared" )
define "InPopulation":
  "MeetsInclusionCriteria" and not "MeetsExclusionCriteria"

//Adults that vomit do not have covid-19 (usually)
define "MeetsExclusionCriteria":
  not "HasFever" and not "HasCough" and not "HasGastrointestinalSymptoms"
    and "AgeRange-young at end of Measurement Period"

// High, medium, low risk populations to go into an ICU (based on the news)
define "InHighRiskPopulation":
    ("AgeRange-old at end of Measurement Period"
  and "HasFever") or  ("AgeRange-old at end of Measurement Period"
  and "HasCough" )  or    ("AgeRange-old at end of Measurement Period"
  and "HasSenseOfSmellImpared" )
 and not "MeetsExclusionCriteria"
    
define "InMediumRiskPopulation":
    ("AgeRange-middle at end of Measurement Period"
  and "HasFever") or  ("AgeRange-middle at end of Measurement Period"
  and "HasCough" )  or    ("AgeRange-middle at end of Measurement Period"
  and "HasSenseOfSmellImpared" )
 and not "MeetsExclusionCriteria"
define "InLowRiskPopulation":
    ("AgeRange-young at end of Measurement Period"
  and "HasFever") or  ("AgeRange-young at end of Measurement Period"
  and "HasCough" )  or    ("AgeRange-young at end of Measurement Period"
  and "HasSenseOfSmellImpared" ) or   ("AgeRange-young at end of Measurement Period"
  and "HasGastrointestinalSymptoms" )
 and not "MeetsExclusionCriteria"    
 
define "ICUAdviceToDoctor":
  if "InHighRiskPopulation" or "InMediumRiskPopulation" then 'Posible problems if covid-19 test is true. Give them a test as soon as possible'
  else 'Give them a test as soon as possible, but low chance of ICU'    
    
//Shall we suggest testing?     
define "NeedToHave":
  "HasFever" or "HasCough" or "HasSenseOfSmellImpared" or     ("AgeRange-young at end of Measurement Period"
  and "HasGastrointestinalSymptoms" )
define "CouldHave":
  "HasFatigue" or "HasMyalgia" or "HasArtralgia" or "HasTightChest" or "HasHeadache"
define "PotentialToHave":
  "HasDizziness" or "HasGastrointestinalSymptoms"
  
define "AnyReasonToTest":
    "PotentialToHave" or "CouldHave" or "NeedToHave"
    
define "CovidTestRationale":
    if ("PatientInTier3" and "NeedToHave") or ("PatientInTier3" and "CouldHave") then 'Go get tested as soon as possible'
      else if "PatientInTier3" and "PotentialToHave" then 'Call 111 for advice and do not panick!'
    else 'Enjoy life!'
  
define "Errors":
  null
define function Confirmed(CondList List<Condition>):
  CondList C where C.verificationStatus ~ "Condition Confirmed code"
define function ActiveCondition(CondList List<Condition>):
  CondList C
    where C.clinicalStatus ~ "Condition Active code"
      and C.abatement is null