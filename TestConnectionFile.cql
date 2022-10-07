/*
    This file provides one of the most basic functionalities in CQL.
    It define different age ranges and tells you which one your patient belongs to. i.e. returns true.
    Use this file to test your connection to the FHIR Hapi server on dataphoria CQL engine
*/
library TestConnection version '1.0'
using FHIR version '4.0.1' 

parameter "Measurement Period" Interval<DateTime>
default Interval[@2022-01-01T00:00:00.0, @2022-10-10T00:00:00.0)  
  
context Patient

define "AgeRange-old at end of Measurement Period":
  AgeInYearsAt(end of "Measurement Period") between 60 and 110
    
define "AgeRange-middle at end of Measurement Period":
  AgeInYearsAt(end of "Measurement Period") between 20 and 59
    
define "AgeRange-young at end of Measurement Period":
  AgeInYearsAt(end of "Measurement Period") < 19   