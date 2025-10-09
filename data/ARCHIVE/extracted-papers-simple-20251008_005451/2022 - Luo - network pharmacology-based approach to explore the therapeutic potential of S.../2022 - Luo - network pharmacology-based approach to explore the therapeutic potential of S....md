## Page 1

PLOS ONE
RESEARCHARTICLE
A network pharmacology-based approach to
explore the therapeutic potential of Sceletium
tortuosum in the treatment of
neurodegenerative disorders
YangwenLuo1,LuchenShan1,LipengXu1,SrinivasPatnala2,IsadoreKanfer2¤,JiahaoLi1,
PeiYu1*,XuJunID 1*
a1111111111 1 CollegeofPharmacy,JinanUniversity,Guangzhou,China,2 FacultyofPharmacy,RhodesUniversity,
a1111111111 Grahamstown,SouthAfrica
a1111111111
¤ Currentaddress:LeslieDanFacultyofPharmacy,UniversityofToronto,Toronto,Canada
a1111111111
*peiyu@jnu.edu.cn(PY);xujun@jnu.edu.cn(JX)
a1111111111
Abstract
Sceletiumtortuosum(SCT)hasbeenutilizedmedicinallybyindigenousKoi-Sanpeoplepur-
OPENACCESS
portedlyformoodelevation.SCTextractsarereportedtobeneuroprotectiveandhaveeffi-
Citation:LuoY,ShanL,XuL,PatnalaS,KanferI,
cacyinimprovingcognition.However,itisstillunclearwhichofthepharmacological
LiJ,etal.(2022)Anetworkpharmacology-based
approachtoexplorethetherapeuticpotentialof mechanismsofSCTcontributetothetherapeuticpotentialforneurodegenerativedisorders.
Sceletiumtortuosuminthetreatmentof Hence,thisstudyinvestigatedtwoaspects–firstly,theabilitiesofneuroprotectivesub-frac-
neurodegenerativedisorders.PLoSONE17(8):
tionsfromSCTonscavengingradicals,inhibitingsomeusualtargetsrelevanttoAlzheimer’s
e0273583.https://doi.org/10.1371/journal.
disease(AD)orParkinson’sdisease(PD),andsecondlyutilizingthenetworkpharmacology
pone.0273583
relatedmethodstosearchprobablemechanismsusingSurflex-Dockprogramtoshowthe
Editor:OksanaLockridge,UniversityofNebraska
keytargetsandcorrespondingSCTconstituents.Theresultsindicatedsub-fractionsfrom
MedicalCenter,UNITEDSTATES
SCTcouldscavenge2,2-diphenyl-1-picrylhydrazyl(DPPH)radical,inhibitacetylcholinester-
Received:February24,2022
ase(AChE),monoamineoxidasetypeB(MAO-B)andN-methyl-D-asparticacidreceptor
Accepted:August10,2022
(NMDAR).Furthermore,theresultsofgeneontologyanddockinganalysesindicatedthe
Published:August25,2022 keytargetsinvolvedintheprobabletreatmentofADorPDmightbeAChE,MAO-B,
Copyright:©2022Luoetal.Thisisanopenaccess NMDARsubunit2B(GluN2B-NMDAR),adenosineA 2A receptorandcannabinoidreceptor2,
articledistributedunderthetermsoftheCreative andthecorrespondingconstituentsinSceletiumtortuosummightbeN-trans-feruloyl-3-
CommonsAttributionLicense,whichpermits
methyldopamine,dihydrojoubertiamineandothermesembrinetypealkaloids.Insummary,
unrestricteduse,distribution,andreproductionin
thisstudyhasprovidednewevidenceforthetherapeuticpotentialofSCTinthetreatmentof
anymedium,providedtheoriginalauthorand
sourcearecredited. ADorPD,aswellasthekeytargetsandnotableconstituentsinSCT.Therefore,wepro-
poseSCTcouldbeanaturalchemicalresourceforleadcompoundsinthetreatmentof
DataAvailabilityStatement:Allrelevantdataare
withinthepaper. neurodegenerativedisorders.
Funding:Theauthor(s)receivednospecific
fundingforthiswork.
Competinginterests:Theauthorshavedeclared
thatnocompetinginterestsexist.
Introduction
Abbreviations:SCT,Sceletiumtortuosum;MPP+,
1-methyl-4-phenylpyridinium;AChE,
Sceletiumtortuosum(L.)N.E.Br(SCT),aSouthAfricanherb,withalonghistoryofuseby
Acetylcholinesterase;MAO,monoamineoxidase; Koi-Sannatives,isreportedtohavevariouspharmacologicalactivitiessuchasanti-depressant
PLOSONE|https://doi.org/10.1371/journal.pone.0273583 August25,2022 1/21

## Page 2

PLOS ONE ExplorethetherapeuticpotentialofSceletiumtortuosuminthetreatmentofneurodegenerativedisorders
NMDAR,N-methyl-D-asparticacidreceptor;AD, [1],anti-anxiety[2],anti-epileptic[3]andanalgesic[4]activities.Itsextractsarereportedto
Alzheimer’sdisease;PD,Parkinson’sdisease; haveshownefficacyinimprovingcognition[5,6].Cognitiondeficitisapredominantlygen-
DPPH,1,1-diphenyl-2-picrylhydrazyl;A2AR,
eralsymptomofAlzheimer’sdisease(AD)andinsomecasesofParkinson’sdiseases(PD)–
adenosineA2Areceptor;CB2R,cannabinoid
henceitispostulatedthatneurodegenerativedisordersthatcouldbetreatedbycompounds
receptor2;KEGG,KyotoEncyclopediaofGenes
thatpossessneuroprotectiveeffects[7–12].Consideringthattherearecertainneuroprotective
andGenomes.
constituentsinSCT,whicharereportedtohavethetherapeuticpotentialinthetreatmentof
neurodegenerativediseases,thereisaneedtoinvesigatetheprobablemechanismsthatcon-
tributetothepossibletreatmentofneurodegenerativedisorders,especiallyinADorPDwith
cognitiveimpairments.
“Networkpharmacology”(NP)methodshavebeenusuallyappliedinthisformofresearch
toaccessprimarymechanismsofcertaintraditionalChinesemedicinesformulaaccordingto
theirtraditionalindications[13–16].SomestudieshavealsousedNPtoexplorethepossible
novelindicationsforcomplicatedChinesetraditionalmedicines[17,18].ApplicationofNP
couldbefurtherunderstoodbasedonthepublishedreportbyFangJSetalwhoproposedand
decipheredmechanismofactionforsomeofthemostwidelystudiedmedicinalherbsusedin
thetreatmentofAD[19].
Ourpreviousstudy[20]hasshowedtheneuroprotectivesub-fractionsandpossibleneuro-
protectiveconstituents(Fig1)intheneuroprotectivesub-fractionsextractedfromSCT.The
petroleumetherandethylacetatefractionswereconfirmedtopossessneuroprotectiveefficacy,
beenfurtherseparatedbysilicagelcolumntoobtainsub-fractionstestedbycellexperiments.
Furthermore,naturalproductsgenerallyconsistofvariousanddiverseactiveconstituents
dependingontheextractionprocess[21],whichcanleadtoneuroprotectivefractionsthat
exertneuroprotectiveeffectofSCTandprobablycausedduetomultipleconstituents.Thus,it
makessuchinvestigationslaboriousanddifficulttodeciphertheelicitedmechanisms.Hence,
investigatingthepossibilityofSCTextractfortreatingneurodegenerativedisorders,asaninte-
gratedsystemasappliedbytraditionalChinesemedicine,wouldprovideinsightbyutilizing
NPmethodsisalogicalandscientificapproach.
Inthisstudy,spectrophotometricassayswereperformedonSCTsub-fractionstoassess
neuroprotectiveactionrelatedefficaciesbasedonthescavengingradicals,inhibitingacetylcho-
linesterase(AChE),monoamineoxidases(MAOs)andN-methyl-D-asparticacidreceptor
(NMDAR).Subsequently,relevantNPmethodsandmoleculardockingwereperformedto
understandthepossiblemechanismsthatprovideevidencetocorelatethetherapeuticpoten-
tialofSCTinthetreatmentofADorPD.
Furthermore,itisimportanttoidentifythekeytargets,andthecorrespondingconstituents
inneuroprotectivesub-fractionsinvolvedintheprobabletreatmentofADorPD[2,4,22–33].
Methods
Theneuroprotectivesub-fractionsfromSCTandtheiridentified
constituents
Basedonourpreviousstudy[20],SCTplantpowderwasextractedwithalcoholandwhich
wasfurtherextractedwithpetroleumetherandethylacetate.Thepetroleumetherandethyl
acetatefractionswereconfirmedtopossessneuroprotectiveefficacyonMPP+-injuredN2a
cellsorL-glutamate-injuredPC12cells.Theactivefractionswerefurtherseparatedbysilica
gelcolumntoobtainsub-fractions.Thesub-fractionswerealsotestedbycellexperiments[34–
36]togivefourneuroprotectivesub-fractions–P5,P6,E1andE3(“P”and“E”meanthesub-
fractionsofpetroleumetherandethylacetatefractionsrespectively).Theactivesub-fractions
wereonceagainpreliminarilyidentifiedtheconstituentsthatwereseparatedandidentified
PLOSONE|https://doi.org/10.1371/journal.pone.0273583 August25,2022 2/21

## Page 3

PLOS ONE ExplorethetherapeuticpotentialofSceletiumtortuosuminthetreatmentofneurodegenerativedisorders
Fig1.Theconstituentsofneuroprotectivesub-fractionsfromSCTinpreviousstudy.(tRrepresentstheirretentiontimeinUPLC).
https://doi.org/10.1371/journal.pone.0273583.g001
fromSCTinthecurrentstudy.Thechemicalstructuresoftheseconstituentsaredepictedin
Fig1.
DPPHscavengingassay
Theabilityoftheneuroprotectivesub-fractionsfromSCTtoscavenge2,2-diphenyl-1-picryl-
hydrazyl(DPPH)radicalwastestedin96-wellpolystyrenemicrotiterplates(Corning1).The
extractionandseparationmethodstoobtaintheneuroprotectivesub-fractionswereper-
formedasdescribedinthepreviousstudy[20].DPPH(TCI,Japan)wasdissolvedinmethanol
PLOSONE|https://doi.org/10.1371/journal.pone.0273583 August25,2022 3/21

## Page 4

PLOS ONE ExplorethetherapeuticpotentialofSceletiumtortuosuminthetreatmentofneurodegenerativedisorders
toobtainaconcentrationof100μM.Thewellscontained100μLDPPHandthenadded100μL
ofsub-fractionsamplesindifferentconcentrations.Blankwellscontainedmethanolinplaceof
DPPHandcontrolwellscontainedonlymethanolinplaceofsamples.Aftershockingona
microoscillator,theplatewaskeptinthedarkfor50minutes.Theabsorbancewasdetectedata
wavelengthof517nmusingamicroplatereader(Bio-TekInstrumentsInc,USA).Theclearance
percentofDPPHwasexpressedasmean±SEMcalculatedbyfollowingformula:
A (cid:0) ðA (cid:0) A Þ
Clearanceð%Þ¼ control sample blank �100%
A
control
AChEinhibitionassay
TheexperimenttotesttheAChEinhibitingabilityofneuroprotectivesub-fractionsofSCT
wasperformedasperproceduredescribedbyEllman[37,38].160μLofPBS(0.1MpH=8),
10μLofsampleand10μLofAChE(0.5U/mL,Solarbio,Beijing)weremixedin96wellsplate
for20minat4˚C,andthenthewellswereadded10μLof2,2’-dithiodibenzoicacid(10mM,
MedChemExpress)and10μLofacetylthiocholineiodide(10mM,Solarbio,Beijing)for
another30minat37˚C.Theabsorbancewasdetectedatawavelengthof405nm.Blankwells
hadPBSaddedinplaceofAChEandcontrolwellshadPBSaddedinplaceofsamples.
MAOsinhibitionassay
TheMAOsinhibitionpercentofneuroprotectivesub-fractionsfromSCTwasmeasuredby
followingproceduresdescribedbyHoltwithsomemodifications[39].
ThisstudyisgotpassbyJinanUniversityLaboratoryAnimalEthicalCommittee.The
IACUCissuenumberis20220225–03.Allstudiesrelatedtoanimalswereperformedinaccor-
dancewiththestandardssetforthintheeightheditionofGuidefortheCareandUseofLabo-
ratoryanimals,publishedbytheNationalAcademyofSciences,theNationalAcademiesPress,
WashingtonD.C(Licensenumber:SCXK(粤)2018-0002).WeusePentobarbitalSodiumas
anesthesiaandreducethepainofdeathinratsbyexcessiveanaesthesia.
FemaleSprague—Dawleyrat(286g)waskilledbyanesthetic,anditsliversweredissected
out,washedinice-coldPBS(0.2M,pH7.6).Livertissue(7g)washomogenized1:20(w/v)in
0.3Msucrosewithamechanicalhomogenizer.Followingcentrifugationat1100gfor12min,
thesupernatantwasfurthercentrifugedat10000gfor30mintoobtainacrudemitochondrial
pellet,whichwasresuspendedin40mlofPBSusedasthesourceofMAOs.
40μLofMAOsand40μLofsampleswereaddedinthewellsfor20minat37˚Candthen
thesupplementoftheenzymesubstrateandchromogenicreagentwereaddedfor60minat
37˚C.Theenzymesubstratewastyramine(5mM,Aladdin,Shanghai)andthechromogenic
reagentwasamixturecontainedvanillicacid(5mM,Shanghaiyuanye,China),4-aminoanti-
pyrine(1mM,Shanghaiyuanye,China),peroxidase(5U/mL,Solarbio,Beijing)inPBS.The
absorbancewasdetectedatawavelengthof490nm.BlankwellshadPBSaddedinplaceof
tyramineandcontrolwellshadPBSaddedinplaceofsamples.
TheinhibitionpercentagesofAChEandMAOswereexpressedasmean±SEMcalculated
byfollowingformula:
A (cid:0) ðA (cid:0) A Þ
Inhibitionpercentð%Þ¼ control sample blank �100%
A
control
Primarycultureofrathippocampalneurons
ThehippocampustissuewasseparatedfromSprague-Dawleyneonatalratandplacedincold
phosphatebuffersalineunderanasepsiscondition,andthenwasdigestedwith0.25%trypsin
PLOSONE|https://doi.org/10.1371/journal.pone.0273583 August25,2022 4/21

## Page 5

PLOS ONE ExplorethetherapeuticpotentialofSceletiumtortuosuminthetreatmentofneurodegenerativedisorders
for20minat37˚C.Aftertrypsinization,hippocampalneuronsweresuspendedinDMEM
(Gibco)containing10%horseserum(Gibco)andculturedinpolyethylenimine-coatedcover-
slipsatadensityof105/cm2for4hat37˚C.Themediumwasreplacedwithneurobasal
medium(Gibco)containingB-27supplement(Gibco)andL-glutamine(Gibco),andthecells
wereculturedat37˚Cinahumidifiedenvironmentof95%airand5%CO for7days.
2
Wholecellpatchclamp
Toinvestigatetheeffectoftwosub-fractionsfromSCTontheNMDARmediatedcurrent,
wholecellpatchclampwasusedtotherecordofNMDARcurrentbyanamplifier(EPC-10,
HEKA,Germany).Beforerecording,anegativepressurewasexertedonthehippocampalneu-
ron’ssurfacethroughmicroelectrodeandformedaGOsealresistance,thenthemembrane
potentialwaskeptin-70mV.ThehippocampalneuronswereexposedtoNMDA(100μM),
Glycine(10μM)andsamplesindifferentconcentrationsorD-2-Amino-5-phosphonovaleric
acid(D-AP5)(100μM).
NMDA(100μM)andGlycine(10μM)wereusedtoactivatetheNMDAcurrent.D-AP5,a
NMDARinhibitor,wasusedasapositivecontrol.Thecurrentsignalswererecordedbythe
amplifierunderaGap-freemodeandstoredinPatchMastersoftware(HEKA,Germany).
Recordingwasallowedtostartatleast5minaftertheruptureofpatchmembranetoensure
stabilizationoftheintracellularmilieu.Neuronsthatshowedunstableorlarge(morethan
*50pA)holdingcurrentswererejected.Theseriesresistance(<15MO)andmembrane
capacitancewerecompensatedandcheckedregularlyduringtherecording.
TheinhibitionpercentageofNMDARwascalculatedaccordingtotheformula:(1-(I
NMDA
/I ))x100%.Datawereexpressedasmean±S.E.M.
+Glycine+Compound NMDA+Glycine
Extracellularfluid(pH7.4)contained140mMNaCl,4mMKCl,2mMCaCl •2H O,10
2 2
mMHEPES,5mMD-Glucose,0.5μMTTX,10μMNBQX,10μMStrychnineand10μM
Bicuculline.Intracellularfluid(pH7.2)contained10mMNaCl,110mMCsMeS,2mM
MgCl •6H O,10mMHEPES,10mMEGTA,2mMNa -ATP,0.2mMNa -GTP.
2 2 2 2
NetworkpharmacologymethodstodecipherpossiblemechanismsofSCT
TargetsoftheconstituentsidentifiedfromSCTinourpreviousstudywereobtainedfrom
PolypharmacologyBrowser2(https://ppb2.gdb.tools/)[40].Methods:ECfp4NaiveBayes
MachineLearningmodelproducedontheflywith2000nearestneighborsfromextendedcon-
nectivityfingerprintECfp4.Targetsofneurodegenerativedisorderwereelementsoftheinter-
sectionsetobtainedfromGeneCards[41](https://www.genecards.org/,Relevancescore�10)
andDisGeNET[42](https://www.disgenet.org/,Scoregda�0.1)databasesusingfollowing
keywords:Alzheimer’sdisease,Parkinson’sdisease,amyotrophiclateralsclerosis,spinocere-
bellarataxia,Lewybodies,frontotemporaldementia,Huntington’sdiseaseandepilepsy.
Protein–proteininteractiondatawereacquiredfromSTRING11.0[43](https://string-db.
org/cgi/input.pl)withthespecieslimitedto“Homosapiens”.
GOandKEGGpathwayenrichmentanalyseswereperformedbyDAVIDBioinformatics
Resources6.8[44](https://david.ncifcrf.gov/).Thetargetsfromtheintersectionsetoftargets
oftheconstituentsanddiseasesweresubmittedtoobtainthetermsofbiologicalprocess,
molecularfunction,cellularcomponentandKyotoEncyclopediaofGenesandGenomes
(KEGG)pathways.
AllvisualizednetworkmodelswereestablishedviaCytoscape3.8.0.Thetopologicalfeature
ofeachnodeinnetworkmodelwasassessedbycalculatingthreeparametersnamed“Degree”,
“BetweennessCentrality(BC)”and“ClosenessCentrality(CC)byNetworkAnalyzetoolin
Cytoscapesoftware.
PLOSONE|https://doi.org/10.1371/journal.pone.0273583 August25,2022 5/21

## Page 6

PLOS ONE ExplorethetherapeuticpotentialofSceletiumtortuosuminthetreatmentofneurodegenerativedisorders
Preliminaryverificationforthepossiblemechanismsbysurflex-dock
TheconstituentswerepreparedbySybyl-X2.0.Asdockingligands,theirenergywasmini-
mizedaccordingfollowingparametersettings:Powellmethod,0.005kcal/mol�Agradientter-
mination,1000maxiterationandGasteiger-Huckelcharges.Othersettingswerekeptdefault.
TheproteinstructureswereobtainedfromPDBProteinDataBank(http://www.rcsb.org/).
Tomakedockingpockets,theproteinstructureswereextractedligandsubstructure,repaired
sidechains,addedhydrogensandminimizedtheirenergy.Protomolgenerationmodewas
selectedas“Ligand”andothersettingsweredefault.Referencemoleculesweresetastheirorig-
inalligands.ResultsofTotalScorewereoutputasthecriteriontocomparingthepredictive
affinities.
Statisticalmethod
Eachvaluewasanaverageofdatafrom3independentexperimentsandeachexperiment
included3replicates.Datawereexpressedasmean±SEMandanalyzedusingGraphPad
PrismV8.0(GraphPadSoftware,Inc.,SanDiego,CA,USA).One-wayanalysisofvariance
(ANOVA)andDunnett’stestwereusedtoevaluatestatisticaldifferences.
Results
SCTsub-fractionsscavengeDPPHradical
ThescavengingabilityofDPPHradicaloftheSCTsub-fractionsisdepictedinFig2.Theclear-
ancepercentagesoffoursub-fractionscouldallreachmorethan40%attheirhighestconcen-
tration(500μg/mL).FractionE3wasthemostpotentsub-fractiononscavengingDPPH
radicalamongthesefourneuroprotectivesub-fractionsfromSCT,althoughweakerthanthe
positivecompounds–vitaminC.
SCTsub-fractionsinhibitAChE
TheAChEinhibitionpercentoffoursub-fractionscouldreachmorethan40%attheirhighest
concentration(1000μg/mL).SincecontrasttoHuperzine–aAChEinhibitor,theireffectson
Fig2.TheDPPHclearancepercentagesofactivesub-fractions.Datawereexpressedasmean±S.E.M.fromthedata
obtainedfromthreeindependentexperiments(n=3).NSrepresentsthemeanofgrouphasnosignificantdifferent
withthemeanofcontrolgroup.
https://doi.org/10.1371/journal.pone.0273583.g002
PLOSONE|https://doi.org/10.1371/journal.pone.0273583 August25,2022 6/21

## Page 7

PLOS ONE ExplorethetherapeuticpotentialofSceletiumtortuosuminthetreatmentofneurodegenerativedisorders
Fig3.Theinhibitionpercentagesofactivesub-fractionsonAChE.Datawereexpressedasmean±S.E.M.obtained
fromthreeindependentexperiments(n=3).NSrepresentsthemeanofgrouphasnosignificantdifferencecompared
tothemeanofcontrolgroup.
https://doi.org/10.1371/journal.pone.0273583.g003
AChEwereconsideredasslightefficacy.ItalsoshowedthatfractionE1exhibitedmorethan
60%inhibitionpercentonAChE,whichwasthemostpotentsub-fractionamongtheextracts
(Fig3).
SCTsub-fractionsinhibitMAOs
TheresultsdepictedinFig4showed,MAO-Aselectiveinhibitor—clorgilinecouldinhibitthe
MAOsbyabout60%at50μM,whileMAO-Bselectiveinhibitor–pargylinecouldinhibitthe
MAOsbycloseto100%at50μM.Sincetheenzymesubstratewastyramine,whichcouldbe
commonenzymesubstrateforbothMAO-AandMAO-B,theenzymeactivityoftheMAOs
weusedinthisstudywasconsideredtobecontributedmainlybyMAO-B[45].
ExceptfractionE3,otherthreeactivesub-fractionspresentedmorethan40%inhibition
percentonMAOsattheirhighestconcentration(1000μg/mL).Theobservedinhibitionresults
wereregardedasmild.
SCTsub-fractionsinhibitNMDAR
ComparedtoZembrin1,themorepotentneuroprotectiveP5andE1fractions(compared
withP6andE3inourpreviousstudy[20])showedpotentinhibitingeffectonNMDAR-medi-
atedcurrent(Fig5).However,thiseffectisnotsignificantenoughtobeconsideredasmain
mechanismthatelicitsantidepressantactionofSCT.
Commontargetsofconstituentsandneurodegenerativediseases
Asindicatedinthepreviousstudy,theneuroprotectivesub-fractionsandunderlyingneuro-
protectiveconstituents(structureswereshowninFig1)inSCT[20].UsingPolypharmacology
Browser2,thepredictivetargetsoftheconstituentsfromneuroprotectivesub-fractionswere
comparedwiththetargetsofneurodegenerativediseasescollectedfromGeneCardsandDis-
GeNETdatabases.TheresultsoftheirintersectionswereshowedasFig6.Althoughtheper-
centofoverlappingtargetsintargetsofHDwasthemaximumvalue(16.67%)amongthese
neurodegenerativediseases,therewereonly5overlappingtargetsfromtheintersection.
PLOSONE|https://doi.org/10.1371/journal.pone.0273583 August25,2022 7/21

## Page 8

PLOS ONE ExplorethetherapeuticpotentialofSceletiumtortuosuminthetreatmentofneurodegenerativedisorders
Fig4.Theinhibitionpercentagesofactivesub-fractionsonMAOs.Datawereexpressedasmean±S.E.M.obtained
fromthreeindependentexperiments(n=3).NSrepresentsthemeanofgroupshowednosignificantdifferencewith
themeanofcontrolgroup.
https://doi.org/10.1371/journal.pone.0273583.g004
Therefore,ADorPDwasselectedasadaptablediseasebecauseofthelargernumberandper-
centageofcommontargets(Table1)thanotherdiseaseconditions.
GOandKEGGpathwayenrichmentanalysis
TheoverlappingtargetsofconstituentsandAD/PDcouldenrichinmorethan20termsofbio-
logicalprocesses(thetermsofwhichPvalue<0.001wereshowedasFig7),whichmainly
involvedresponsetodrug(GO:0042493),chemicalsynaptictransmission(GO:0007268),loco-
motorybehavior(GO:0007626),memory(GO:0007613),learning(GO:0007612,
GO:0008542),responsetoamphetamine(GO:0001975),behavioralresponsetococaine
(GO:0048148),dopaminergicsynaptictransmission(GO:0001963),prepulseinhibition
(GO:0060134),etc.ThesebiologicalprocessesindicatethattheextractsofSCTcouldexert
neurologicalactivitiesthatarehelpfultotreatcognitiondeficitandbehavioraldisorders.The
analysisofcellularfunctions(Fig8)showedthatthesetargetsmainlyincludeddopaminebind-
ing(GO:0035240),dopamineneurotransmitterreceptoractivity(GO:0004952),beta-amyloid
binding(GO:0001540),drugbinding(GO:0008144),enzymebinding(GO:0019899),etc.
Moreover,theseoverlappingtargetsaremainlyintegralcomponentofplasmamembrane
(GO:0005887),locateonplasmamembrane(GO:0016021)andcellsurface(GO:0009986),dis-
tributeondendrite(GO:0030425)andaxon(GO:0030424)(Fig8).KEGGpathwayanalysisof
thesetargetssuggestedthattheyplayaroleinneuroactiveligand-receptorinteraction
(hsa04080),serotonergicsynapse(hsa04726),dopaminergicsynapse(hsa04728),Alzheimer’s
disease(hsa05010),alcoholism(hsa05034),cAMPsignalingpathway(hsa04024),Parkinson’s
disease(hsa05012),calciumsignalingpathway(hsa04020),amphetamineaddiction(hsa05031)
(Fig9).
PLOSONE|https://doi.org/10.1371/journal.pone.0273583 August25,2022 8/21

## Page 9

PLOS ONE ExplorethetherapeuticpotentialofSceletiumtortuosuminthetreatmentofneurodegenerativedisorders
Fig5.Theinhibitionpercentagesofactivesub-fractionsonNMDAR-mediatedcurrent.Datawereexpressedasmean±S.E.M.D-AP5group:n=4,other
groups:n=3.NSrepresentsthemeanofgrouphasnosignificantdifferentwiththemeanofcontrolgroup.
https://doi.org/10.1371/journal.pone.0273583.g005
Constituents–targets–diseasenetworkdiagram
Theinteractionsoftheoverlappingtargets,constituentsandtheirpossibletargetsandtargets
ofADorPDwerefedintocytoscape3.8.0softwaretoobtainaconstituents-targets-disease
networkdiagram(Fig10).Inthisnetworkdiagram,therewere59nodesand345edges,
including23constituents,30targets,2diseases,4sub-fractionsand1plant.Theresultofnet-
workanalysis(Table2)showedthatdegreesofthetargets,ofwhichgenenamesareSLC6A4,
DRD2,ACHE,HTR1A,SLC6A3,HTT,APP,HTR2A,MAOB,BACE1,DRD3,TNF,CNR2,
BCHE,DRD1andGRIN2B,aremorethan13withbetweennesscentralitiesmorethan0.005
andclosenesscentralitiesmorethan0.5.Thedegreesofallconstituentsinthisdiagramare
equalorgreaterthan6.
KeytargetsinthepossiblemechanismsofSCTinthetreatmentofADor
PD
Targetswithagreaterdegreevalue(morethan13)orenrichedinADorPDKEGGpathway
wereselectedtobedockedwithconstituentsfromneuroprotectivesub-fractionsbySurflex-
Dock(TotalScoreresultsshowedasFig11).
TheTotalScoreresultsindicatedthatmanyvitaltargetsinvolvedinADorPD,forexample
AChE(ACHE),MAO-B(MAOB),GluN2B-NMDAR(GRIN2B),adenosineA2Areceptor
(A2AR,ADORA2A)andcannabinoidreceptor2(CB2R,CNR2),havepotentpredictedbind-
ingactivitywithseveralSCTconstituents.Moreover,SCTconstituentsasFig12showedhave
higherTotalScorewithcorrespondingtargets,whichindicatedthattheyaremorepossibleto
affectthetargetstoexertneuroprotectiveefficacyforthetreatmentofADorPD.
PLOSONE|https://doi.org/10.1371/journal.pone.0273583 August25,2022 9/21

## Page 10

PLOS ONE ExplorethetherapeuticpotentialofSceletiumtortuosuminthetreatmentofneurodegenerativedisorders
Fig6.Theintersectionoftargetsfromconstituentsanddiseases.AD:Alzheimer‘sDisease;PD:Parkinson’sDisease;
ALS:AmyotrophicLateralSclerosis;SCA:SpinocerebellarAtaxia;LBD:LewyBodyDementia;FTD:Frontotemporal
Dementia;HD:Huntington’sDisease.
https://doi.org/10.1371/journal.pone.0273583.g006
Table1. OverlappingtargetsofconstituentsandAD/PD.
Gene Commonname
ESR2 Estrogenreceptorbeta
MAOB MonoamineoxidasetypeB
HTR6 5-hydroxytryptaminereceptor6
CYP2D6 CytochromeP4502D6
ACHE Acetylcholinesterase
SLC6A4 Sodium-dependentserotonintransporter
SLC6A3 Sodium-dependentdopaminetransporter
BACE1 Beta-secretase1
HTR2A 5-hydroxytryptaminereceptor2A
CNR2 Cannabinoidreceptor2
BCHE Cholinesterase
ALOX5 Polyunsaturatedfattyacid5-lipoxygenase
APP Amyloid-betaprecursorprotein
TSPO Translocatorprotein
GSK3B Glycogensynthasekinase-3beta
PTGS2 ProstaglandinG/Hsynthase2
ADAM17 Disintegrinandmetalloproteinasedomain-containingprotein17
BACE2 Beta-secretase2
GRIN2B N-methylD-aspartatereceptorsubtype2B
(Continued)
PLOSONE|https://doi.org/10.1371/journal.pone.0273583 August25,2022 10/21

### Table 1 (Page 10)

| Commonname |
| --- |
| Estrogenreceptorbeta |
| MonoamineoxidasetypeB |
| 5-hydroxytryptaminereceptor6 |
| CytochromeP4502D6 |
| Acetylcholinesterase |
| Sodium-dependentserotonintransporter |
| Sodium-dependentdopaminetransporter |
| Beta-secretase1 |
| 5-hydroxytryptaminereceptor2A |
| Cannabinoidreceptor2 |
| Cholinesterase |
| Polyunsaturatedfattyacid5-lipoxygenase |
| Amyloid-betaprecursorprotein |
| Translocatorprotein |
| Glycogensynthasekinase-3beta |
| ProstaglandinG/Hsynthase2 |
| Disintegrinandmetalloproteinasedomain-containingprotein17 |
| Beta-secretase2 |
| N-methylD-aspartatereceptorsubtype2B |

## Page 11

PLOS ONE ExplorethetherapeuticpotentialofSceletiumtortuosuminthetreatmentofneurodegenerativedisorders
Table1. (Continued)
Gene Commonname
CTSD CathepsinD
TNF Tumornecrosisfactor
HTR1A 5-hydroxytryptaminereceptor1A
DRD3 DopamineD3receptor
DRD2 DopamineD2receptor
DRD1 DopamineD1receptor
ADORA2A AdenosinereceptorA2a
HTT Huntingtin
https://doi.org/10.1371/journal.pone.0273583.t001
Discussion
TheoutcomesofthisstudydemonstratedtheefficaciesofSCTneuroprotectivesub-fractions
inscavengingDPPHradical,inhibitingAChE,MAOsandNMDARbyexperimentsper-
formedusinginvitromodels.
Fig7.Enrichmentanalysesforconstituents-AD/PDcommontargets:Biologicalprocess.
https://doi.org/10.1371/journal.pone.0273583.g007
PLOSONE|https://doi.org/10.1371/journal.pone.0273583 August25,2022 11/21

### Table 1 (Page 11)

| Commonname |
| --- |
| CathepsinD |
| Tumornecrosisfactor |
| 5-hydroxytryptaminereceptor1A |
| DopamineD3receptor |
| DopamineD2receptor |
| DopamineD1receptor |
| AdenosinereceptorA2a |
| Huntingtin |

## Page 12

PLOS ONE ExplorethetherapeuticpotentialofSceletiumtortuosuminthetreatmentofneurodegenerativedisorders
Fig8.Enrichmentanalysesforconstituents-AD/PDcommontargets:Molecularfunctionandcellularcomponent.
https://doi.org/10.1371/journal.pone.0273583.g008
Theclearancepercentoffoursub-fractionscouldreachmorethan40%at500μg/mL.In
contrasttotheradicalscavengingefficacyofSCTextractinthepreviousstudy,E3couldpres-
entcomparativeperformanceonscavengingDPPHradical[46],whichindicatedtheconstitu-
entswithantioxidanteffectofSCTwasenrichedintheethylacetatesub-fraction.
Antioxidativeeffectisaknownmechanismofcertaincompoundselicitingneuroprotective
action[7,47–49].TheresultsfurthersuggestthatSCThaspotentialtotreatneurodegenerative
disordersthroughitsantioxidativeeffect.
ThestudyalsoshowedmoderateinhibitingeffectofSCTneuroprotectivesub-fractionson
AChE,whichwasmorepotentthantheeffectofSCTextractinpreviousstudybasedoncom-
paringtheirtestconcentrations[50].ThereductionofacetylcholinelevelinADpatientmay
causecognitiveandmemoryimpairments[51].Hence,AChEmayacceleratetheprogression
ofADthoughpromotingthefibrationofβ-amyloid[52].Scopolamine,amuscarinicreceptor
antagonist,producesablockingoftheactivityofthemuscarinicacetylcholinereceptor,and
theconcomitantappearanceoftransientcognitiveamnesiaandelectrophysiologicalchanges,
whichresemblethoseobservedinAD[53,54].TherearecertainAChEinhibitorsapproved
forAD,forexample,donepezilandgalanthamine.Infact,somestudieshaddescribedtheneu-
roprotectiveeffectofAChEinhibitor[22,23].Hence,inhibitingAChEappearstobeanunder-
lyingmechanismoftheneuroprotectiveactionofSCT.
TheresultsofMAOsinhibitingassayshowed,exceptE3,otherthreeactivesub-fractions
(P5,P6andE1)allpresentedmorethan40%inhibitionpercentonMAOsat1000μg/mL,
whichisstillmorepotentthantheinhibitingeffectofSCTextractonMAO-Abycomparing
theirconcentrations[50].SinceMAO-Aselectiveinhibitor(clorgyline)couldnotinhibitthe
crudeMAOscloseto100%at50μM,whileMAO-Bselectiveinhibitor(pargyline)could
inhibititcloseto100%atat50μM.Thisresultindicatedthatenzymeactivityofthecrude
MAOsusedinthisstudymainlycontributedbyMAO-B[39,45].ExcessMAOscatalyzeoxida-
tionofaminosubstancecausingthegenerationofoxidativestress[55,56].Moreover,a
MAO-Binhibitor–selegilineapprovedforPDwasreportedtosuppressexcessGABApro-
ducedfromastrocytesandrestorestheimpairedspikeprobability,synapticplasticity,and
learningandmemoryinthemice[24].However,someclinicaltrialsshowedthatthecognitive
functionoftheplacebogrouphadnosignificantdifferencecomparedtothegrouptreated
PLOSONE|https://doi.org/10.1371/journal.pone.0273583 August25,2022 12/21

## Page 13

PLOS ONE ExplorethetherapeuticpotentialofSceletiumtortuosuminthetreatmentofneurodegenerativedisorders
Fig9.Enrichmentanalysesforconstituents-AD/PDcommontargets:KEGGpathway.
https://doi.org/10.1371/journal.pone.0273583.g009
withselegilineforalongtermtherapy[25,26].Insteadofirreversibleinhibitorlikeselegiline,
areversibleMAO-Binhibitor(KDS2010)doesnotinducecompensatorymechanismsina
longtermtherapy,whichfurtherattenuatedincreasedastrocyticGABAlevelsandastrogliosis,
enhancedsynaptictransmission,rescuedlearningandmemoryimpairmentsinAPP/PS1mice
[27].Thereby,MAO-BisconsideredasakeytargetofSCTinthetreatmentofADorPD.
Furthermore,P5andE1fractionsSCTpresentedanon-significantinhibitionofNMDAR-
mediatedcurrentinhippocampalneuronsofSprague-Dawleyneonatalrats,whichwasmore
potentthantheeffectofZembrin1onNMDAR-mediatedcurrentandconsistentwithprevi-
ousresults[57].NMDAR,anionotropicglutamatereceptor,whichconstituteacalcium-per-
meablecomponentoffastexcitatoryneurotransmission,havebeenverifiedtoparticipate
neuro-physiologicallyinmanycellsignalingpathwaysresultinginseveralneurologicaldis-
eases.AnNMDARinhibitor–esketaminewasapprovedfordepressivedisorderoughttohis
rapidantidepressantaction.ThepreviousstudiesshowedthepotentialofSCTontreating
depressivedisorder[2,4,28–33].However,theresultsofthisstudyindicatedthattheinfluence
onNMDARofthesetwofractionsmaybeasubsequenteffectresultedfromaffectingothertar-
getsbutnotNMDAR.Thusleadingtoapossibilitythattheanti-depressiveactionofSCT
PLOSONE|https://doi.org/10.1371/journal.pone.0273583 August25,2022 13/21

## Page 14

PLOS ONE ExplorethetherapeuticpotentialofSceletiumtortuosuminthetreatmentofneurodegenerativedisorders
Fig10.SCT-sub-fraction-constituents-targets-diseasenetworkdiagram.
https://doi.org/10.1371/journal.pone.0273583.g010
PLOSONE|https://doi.org/10.1371/journal.pone.0273583 August25,2022 14/21

## Page 15

PLOS ONE ExplorethetherapeuticpotentialofSceletiumtortuosuminthetreatmentofneurodegenerativedisorders
Table2. Theresultsoftopologicalanalysisforthenetwork.
NodeName Degree BetweennessCentrality ClosenessCentrality
SLC6A4 32 0.06260 0.62766
DRD2 31 0.05874 0.64130
ACHE 30 0.10778 0.65556
HTR1A 30 0.07519 0.64130
SLC6A3 26 0.03614 0.59596
HTT 23 0.03893 0.57282
APP 20 0.04156 0.57843
HTR2A 20 0.02568 0.56731
MAOB 20 0.02614 0.55140
BACE1 19 0.05334 0.57282
DRD3 17 0.01538 0.55660
TNF 15 0.08981 0.52679
CNR2 15 0.02514 0.55140
BCHE 14 0.01292 0.53636
DRD1 13 0.00678 0.52212
GRIN2B 13 0.00617 0.52212
PTGS2 12 0.02749 0.51754
CYP2D6 12 0.00583 0.53153
GSK3B 10 0.01317 0.47967
ADAM17 7 0.00234 0.45385
ADORA2A 7 0.00621 0.50000
ALOX5 7 0.00475 0.45385
HTR6 7 0.00442 0.49167
BACE2 6 0.00107 0.43704
CTSD 5 0.00113 0.42143
ESR2 5 0.00722 0.42143
TSPO 5 0.00034 0.41259
TNFRSF1A 4 0.00171 0.36646
RIPK1 3 0 0.35119
TRAF2 3 0 0.35119
1.19 12 0.02202 0.51304
4.97 11 0.00727 0.50000
3.45 10 0.00977 0.50000
3.86 10 0.01547 0.50000
5.26 10 0.03077 0.50427
1.44 9 0.00425 0.49580
3.28 9 0.00307 0.50000
1.24 9 0.00949 0.49580
2.67 9 0.00869 0.48361
2.12 8 0.00342 0.48361
2.731 8 0.00244 0.49167
3.50 8 0.00250 0.47967
1.93 8 0.00212 0.45385
2.73 7 0.02801 0.45385
4.03 7 0.00167 0.47581
4.14 7 0.00193 0.47581
2.11 7 0.00152 0.45038
(Continued)
PLOSONE|https://doi.org/10.1371/journal.pone.0273583 August25,2022 15/21

### Table 1 (Page 15)

| Degree | BetweennessCentrality |
| --- | --- |
| 32 | 0.06260 |
| 31 | 0.05874 |
| 30 | 0.10778 |
| 30 | 0.07519 |
| 26 | 0.03614 |
| 23 | 0.03893 |
| 20 | 0.04156 |
| 20 | 0.02568 |
| 20 | 0.02614 |
| 19 | 0.05334 |
| 17 | 0.01538 |
| 15 | 0.08981 |
| 15 | 0.02514 |
| 14 | 0.01292 |
| 13 | 0.00678 |
| 13 | 0.00617 |
| 12 | 0.02749 |
| 12 | 0.00583 |
| 10 | 0.01317 |
| 7 | 0.00234 |
| 7 | 0.00621 |
| 7 | 0.00475 |
| 7 | 0.00442 |
| 6 | 0.00107 |
| 5 | 0.00113 |
| 5 | 0.00722 |
| 5 | 0.00034 |
| 4 | 0.00171 |
| 3 | 0 |
| 3 | 0 |
| 12 | 0.02202 |
| 11 | 0.00727 |
| 10 | 0.00977 |
| 10 | 0.01547 |
| 10 | 0.03077 |
| 9 | 0.00425 |
| 9 | 0.00307 |
| 9 | 0.00949 |
| 9 | 0.00869 |
| 8 | 0.00342 |
| 8 | 0.00244 |
| 8 | 0.00250 |
| 8 | 0.00212 |
| 7 | 0.02801 |
| 7 | 0.00167 |
| 7 | 0.00193 |
| 7 | 0.00152 |

## Page 16

PLOS ONE ExplorethetherapeuticpotentialofSceletiumtortuosuminthetreatmentofneurodegenerativedisorders
Table2. (Continued)
NodeName Degree BetweennessCentrality ClosenessCentrality
2.97 7 0.00471 0.47967
3.35 7 0.01321 0.50427
4.07 7 0.00184 0.48361
5.261 7 0.00153 0.47200
3.71 6 0.00130 0.46825
4.22 6 0.00612 0.45385
https://doi.org/10.1371/journal.pone.0273583.t002
extractcanbeduetoinhibitionefficacyofmesembrineandmesembrenoneonphosphodies-
terase-4andserotonintransporter[58].
Therefore,resultsoftheinvitroexperimentsindicatedthatthereareneuroprotectivecon-
stituentsinSCTcouldprotectneuronstotreatneurodegenerativedisordersbyscavenging
radicals,inhibitingAChE,MAOsandNMDAR.Differentsub-fractionsrepresenteddifferent
degreesofinfluenceonAChE,MAOsandNMDAR.
Moreover,theneuroprotectivesub-fractionsofSCTusedtoassessthepotentialusetotreat
ADorPD,wasfurthersupportedbynetworkpharmacologyrelatedmethodsappliedinthis
study,whichwasalsosupportedbytheobservedinfluenceofSCTextractoncognition[5,6].
Amongseveralneurodegenerativedisorders,thetargetsofADorPDfromdatabasehavemost
overlappingnumberswiththetargetspredictedbyPolypharmacologyBrowser2.Itisunder-
stoodthattheoverlappingtargetscouldbeinvolvedinmemory,learningandbehaviorrelated
biologicalprocessandenrichinADandPDcorrespondingKEGGpathway.Thenetwork
analysisandSurflex-Dockresultshaveindicatedthatsomekeytargets,AChE,MAO-B,
GluN2B-NMDAR,A2ARandCB2R,canbeinfluencedbySCTintheprobabletreatmentof
Fig11.Surflex-dockresultsofSCTconstituentswithkeytargetsintotalscore.
https://doi.org/10.1371/journal.pone.0273583.g011
PLOSONE|https://doi.org/10.1371/journal.pone.0273583 August25,2022 16/21

### Table 1 (Page 16)

| Degree | BetweennessCentrality |
| --- | --- |
| 7 | 0.00471 |
| 7 | 0.01321 |
| 7 | 0.00184 |
| 7 | 0.00153 |
| 6 | 0.00130 |
| 6 | 0.00612 |

## Page 17

PLOS ONE ExplorethetherapeuticpotentialofSceletiumtortuosuminthetreatmentofneurodegenerativedisorders
Fig12.ConstituentsfromSCTwiththeirpossibletargetspredictedbytotalscoreinsurflex-dock.
https://doi.org/10.1371/journal.pone.0273583.g012
ADorPD,andotherconstituentsSCTorsimilarmoietiesofclosechemicalstructures,suchas
egonie,sceletiumA4,dihydrojoubertiamine,N-trans-feruloyl-3-methyldopamine,N-methyl-
dihydrojoubertinamineandsoon,shouldbeconcernedtohavepotentialinaffectingoncorre-
spondingtargets(Fig12).
Inthisstudy,theprimarypurposewastoexplorepossibletargetsoftheneuroprotective
SCTonneurodegenerativedisordersbynetworkpharmacology.Accordingtotheidentified
constituentsfromSCTinourpreviousstudy,theresultsofnetworkpharmacologystudies
indicatedsomepotentialtargets(AChE,MAOsandNMDAR)forSCT.Therefore,theneuro-
protectiveSCTsub-factionswerefurthertestedinvitrofortheirefficacyonthepotentialtar-
gets.Encouragingly,theresultsofthefraction-targetsinvitroexperimentsactuallysupported
thenetworkpharmacologyresultsinthisstudy.However,differentsub-factionscontaineddif-
ferentnaturalproducts,thecontentofnaturalproductswerealsovarious,whichresultedin
thedifferenteffectsofdifferentsub-factionstothesepotentialtargetinthisstudy.Certainly,in
thenextstage,thefurtherstudieswouldcarryouttoexplainthebioactivitymechanismofdif-
ferentsub-fractionsontheirspecifictargets.
PLOSONE|https://doi.org/10.1371/journal.pone.0273583 August25,2022 17/21

## Page 18

PLOS ONE ExplorethetherapeuticpotentialofSceletiumtortuosuminthetreatmentofneurodegenerativedisorders
Conclusion
SCTneuroprotectivesub-fractionshavemoderatepotencyofscavengingradicals,inhibiting
AChE,MAOsandNMDAR,whicharethepossiblemechanismsofitsneuroprotectiveeffect.
TheidentifiedandotherrelatedconstituentsinSCTmayhaveaffectsonbiologicalsystemsto
alterAChE,MAO-B,GluN2B-NMDAR,A2ARandCB2R,toexerttheirtherapeuticpotential
intheprobabletreatmentofADorPD.
AuthorContributions
Datacuration:YangwenLuo.
Formalanalysis:YangwenLuo.
Methodology:LuchenShan,LipengXu.
Projectadministration:PeiYu,XuJun.
Resources:SrinivasPatnala,IsadoreKanfer.
Validation:YangwenLuo.
Visualization:YangwenLuo.
Writing–originaldraft:YangwenLuo.
Writing–review&editing:YangwenLuo,SrinivasPatnala,IsadoreKanfer,JiahaoLi.
References
1. FilipovicSR,Covickovic-SternicN,Stojanovic-SvetelM,LecicD,KosticVS.DepressioninParkinson’s
disease:anEEGfrequencyanalysisstudy.ParkinsonismRelatDisord.1998;4(4):171–8.https://doi.
org/10.1016/s1353-8020(98)00027-3PMID:18591107
2. GerickeN,HarveyA,ViljoenA,HofmeyrD,inventors;H.L.Hall&SonsLimited,S.Afr..assignee.Sce-
letiumextractandusesthereofpatentUS20120004275A1.2012.
3. DimpfelW,inventor;HG&HPharmaceuticalsPty.Ltd.,S.Afr..assignee.Mesembrenoland/ormesem-
branolforprophylaxisandtreatmentofpatientssufferingfromepilepsyandassociateddiseasespatent
WO2019021196A1.2019.
4. LoriaMJ,AliZ,AbeN,SufkaKJ,KhanIA.EffectsofSceletiumtortuosuminrats.JournalofEthnophar-
macology.2014;155(1):731–5.https://doi.org/10.1016/j.jep.2014.06.007PMID:24930358
5. ChiuS,GerickeN,Farina-WoodburyM,BadmaevV,Raheb,etal.Proof-of-ConceptRandomizedCon-
trolledStudyofCognitionEffectsoftheProprietaryExtractSceletiumtortuosum(Zembrin)Targeting
Phosphodiesterase-4inCognitivelyHealthySubjects:ImplicationsforAlzheimer’sDementia.Evid
BasedComplementAlternatMed.2014;2014:682014.https://doi.org/10.1155/2014/682014PMID:
25389443
6. HoffmanJR,MarkusI,Dubnov-RazG,GepnerY.ErgogenicEffectsof8DaysofSceletiumTortuosum
SupplementationonMood,VisualTracking,andReactioninRecreationallyTrainedMenandWomen.
JStrengthCondRes.2020;34(9):2476–81.https://doi.org/10.1519/JSC.0000000000003693PMID:
32740286
7. SinghSK,SrivastavS,CastellaniRJ,Plascencia-VillaG,PerryG.NeuroprotectiveandAntioxidant
EffectofGinkgobilobaExtractAgainstADandOtherNeurologicalDisorders.Neurotherapeutics.2019;
16(3):666–74.https://doi.org/10.1007/s13311-019-00767-8PMID:31376068
8. DaviesJ,ChenJ,PinkR,CarterD,SaundersN,SotiriadisG,etal.Orexinreceptorsexertaneuropro-
tectiveeffectinAlzheimer’sdisease(AD)viaheterodimerizationwithGPR103.SciRep.2015;5:12584.
https://doi.org/10.1038/srep12584PMID:26223541
9. ChenP-H,ChengF-Y,ChengS-J,ShawJ-S.PredictingcognitivedeclineinParkinson’sdiseasewith
mildcognitiveimpairment:aone-yearobservationalstudy.Parkinson’sDis.2020:8983960.https://doi.
org/10.1155/2020/8983960PMID:33178412
10. EnacheD,PereiraJB,JelicV,WinbladB,NilssonP,AarslandD,etal.IncreasedCerebrospinalFluid
ConcentrationofZnT3IsAssociatedwithCognitiveImpairmentinAlzheimerDisease.JAlzheimer’s
Dis.2020;77(3):1143–55.
PLOSONE|https://doi.org/10.1371/journal.pone.0273583 August25,2022 18/21

## Page 19

PLOS ONE ExplorethetherapeuticpotentialofSceletiumtortuosuminthetreatmentofneurodegenerativedisorders
11. ScottXO,StephensME,DesirMC,DietrichWD,KeaneRW,PablodeRiveroVaccariJ.Theinflamma-
someadaptorproteinASCinmildcognitiveimpairmentandAlzheimer’sdisease.IntJMolSci.2020;21
(13):4674.https://doi.org/10.3390/ijms21134674PMID:32630059
12. Soles-TarresI,Cabezas-LlobetN,VaudryD,XifroX.Protectiveeffectsofpituitaryadenylatecyclase-
activatingpolypeptideandvasoactiveintestinalpeptideagainstcognitivedeclineinneurodegenerative
diseases.FrontCellNeurosci.2020;14:221.https://doi.org/10.3389/fncel.2020.00221PMID:
32765225
13. LiJ,LuC,JiangM,NiuX,GuoH,LiL,etal.Traditionalchinesemedicine-basednetworkpharmacology
couldleadtonewmulticompounddrugdiscovery.EvidBasedComplementAlternatMed.2012;
2012:149762.https://doi.org/10.1155/2012/149762PMID:23346189
14. XuJ,QiL,ChengL,ZhangY,XuJ,LouW.Networkpharmacology-basedstudyonmechanismof
IndigoNaturalisintreatmentofprimarybiliarycirrhosis.ZhongxiyiJieheGanbingZazhi.2020;30
(5):52–4,9,109.
15. PanY,XuF,GongH,WuF-f,ChenL,ZengY-l,etal.Networkpharmacology-basedstudyonthemech-
anismofGanfuleinthepreventionandtreatmentofprimarylivercancer.Zhongchengyao.2020;42
(12):62–9.
16. LiaoJ-mQinZ-j,YangQ-yLiR-q,XuW-c.Networkpharmacology-basedstudyonmechanismof
SpatholobussuberectusDunntreatinghepatocellularcarcinoma.GuangxiYixue.2020;42(14):72–7.
17. ZhengC-S,XuX-J,YeH-Z,WuG-W,LiX-H,XuH-F,etal.Networkpharmacology-basedpredictionof
themulti-targetcapabilitiesofthecompoundsinTaohongSiwudecoction,andtheirapplicationinosteo-
arthritis.ExpTherMed.2013;6(1):125–32.https://doi.org/10.3892/etm.2013.1106PMID:23935733
18. HongM,ZhangY,LiS,TanHY,WangN,MuS,etal.Anetworkpharmacology-basedstudyonthe
hepatoprotectiveeffectofFructusSchisandrae.Molecules.2017;22(10):1617/1-/11.
19. FangJ,WangL,WuT,YangC,GaoL,CaiH,etal.Networkpharmacology-basedstudyonthemecha-
nismofactionforherbalmedicinesinAlzheimertreatment.JournalofEthnopharmacology.2016;
196:281–92.https://doi.org/10.1016/j.jep.2016.11.034PMID:27888133
20. LuoY,PatnalaS,ShanL,XuL,DaiY,KanferI,etal.NeuroprotectiveEffectofExtract-fractionsfrom
SceletiumtortuosumandtheirPreliminaryConstituentsIdentificationbyUPLC-qTOF-MSwithCollision
EnergyandMassFragmentSoftware.JournalofPharmaceuticalandBiomedicalSciences.2021;11
(02):31–46.
21. PatnalaS,KanferI.Chapter6—Qualitycontrol,extractionmethods,andstandardization:Interface
betweentraditionaluseandscientificinvestigation.In:HenkelR,AgarwalA,editors.HerbalMedicinein
Andrology: AcademicPress;2021.p.175–87.
22. TommonaroG,Garcia-FontN,VitaleRM,PejinB,IodiceC,CanadasS,etal.Avarolderivativesas
competitiveAChEinhibitors,nonhepatotoxicandneuroprotectiveagentsforAlzheimer’sdisease.EurJ
MedChem.2016;122:326–38.https://doi.org/10.1016/j.ejmech.2016.06.036PMID:27376495
23. TakadaY,YonezawaA,KumeT,KatsukiH,KanekoS,SugimotoH,etal.Nicotinicacetylcholinerecep-
tor-mediatedneuroprotectionbydonepezilagainstglutamateneurotoxicityinratcorticalneurons.J
PharmacolExpTher.2003;306(2):772–7.https://doi.org/10.1124/jpet.103.050104PMID:12734391
24. JoS,YarishkinO,HwangYJ,ChunYE,ParkM,WooDH,etal.GABAfromreactiveastrocytesimpairs
memoryinmousemodelsofAlzheimer’sdisease.NatMed(NY,NY,US).2014;20(8):886–96.https://
doi.org/10.1038/nm.3639PMID:24973918
25. FroestlW,MuhsA,PfeiferA.Cognitiveenhancers(nootropics).Part2:drugsinteractingwithenzymes.
Update2014.JAlzheimersDis.2014;42(1):1–68.https://doi.org/10.3233/JAD-140402PMID:
24903780
26. WilcockGK,BirksJ,WhiteheadA,EvansSJG.Theeffectofselegilineinthetreatmentofpeoplewith
Alzheimer’sdisease:ameta-analysisofpublishedtrials.IntJGeriatrPsychiatry.2002;17(2):175–83.
https://doi.org/10.1002/gps.545PMID:11813282
27. ParkJ-H,JuYH,ChoiJW,SongHJ,JangBK,WooJ,etal.NewlydevelopedreversibleMAO-Binhibitor
circumventstheshortcomingsofirreversibleinhibitorsinAlzheimer’sdisease.SciAdv.2019;5(3):
eaav0316.https://doi.org/10.1126/sciadv.aav0316PMID:30906861
28. DimpfelW,SchombertL,GerickeN.ElectropharmacogramofSceletiumtortuosumextractbasedon
spectrallocalfieldpowerinconsciousfreelymovingrats.JEthnopharmacol.2016;177:140–7.https://
doi.org/10.1016/j.jep.2015.11.036PMID:26608705
29. SchellR.SceletiumtortuosumandMesembrine:APotentialAlternativeTreatmentforDepression.
UnitedStatesofAmerica: ScrippsCollege;2014.
30. DimpfelW,GerickeN,SulimanS,DipahGNC.Psychophysiologicaleffectsofzembrinusingquantita-
tiveEEGsourcedensityincombinationwitheye-trackingin60healthysubjects.Adouble-blind,ran-
domized,placebo-controlled,3-armedstudywithparalleldesign.NeurosciMed.2016;7(3):114–32.
PLOSONE|https://doi.org/10.1371/journal.pone.0273583 August25,2022 19/21

## Page 20

PLOS ONE ExplorethetherapeuticpotentialofSceletiumtortuosuminthetreatmentofneurodegenerativedisorders
31. DimpfelW,GerickeN,SulimanS,DipahGNC.EffectofZembrinonbrainelectricalactivityin60older
subjectsafter6weeksofdailyintake.Aprospective,randomized,double-blind,placebo-controlled,3-
armedstudyinaparalleldesign.WorldJNeurosci.2017;7(1):140–71.
32. CarpenterJM,AliZ,AbeN,KhanIA,JourdanMK,FountainEM,etal.TheeffectsofSceletiumtortuo-
sum(L.)N.E.Br.extractfractioninthechickanxiety-depressionmodel.JEthnopharmacol.2016;
193:329–32.https://doi.org/10.1016/j.jep.2016.08.019PMID:27553978
33. TerburgD,SyalS,RosenbergerLA,HeanyS,PhillipsN,GerickeN,etal.AcuteEffectsofSceletium
tortuosum(Zembrin),aDual5-HTReuptakeandPDE4Inhibitor,intheHumanAmygdalaanditsCon-
nectiontotheHypothalamus.Neuropsychopharmacology.2013;38(13):2708–16.https://doi.org/10.
1038/npp.2013.183PMID:23903032
34. SinghA,VermaP,RajuA,MohanakumarKP.Nimodipineattenuatestheparkinsonianneurotoxin,
MPTP-inducedchangesinthecalciumbindingproteins,calpainandcalbindin.JChemNeuroanat.
2019;95:89–94.https://doi.org/10.1016/j.jchemneu.2018.02.001PMID:29427747
35. KupschA,GerlachM,PupeterSC,SautterJ,DirrA,ArnoldG,etal.Pretreatmentwithnimodipinepre-
ventsMPTP-inducedneurotoxicityatthenigral,butnotatthestriatallevelinmice.NeuroReport.1995;
6(4):621–5.https://doi.org/10.1097/00001756-199503000-00009PMID:7605913
36. OtaH,OgawaS,OuchiY,AkishitaM.ProtectiveeffectsofNMDAreceptorantagonist,memantine,
againstsenescenceofPC12cells:ApossibleroleofnNOSandcombinedeffectswithdonepezil.Exp
Gerontol.2015;72:109–16.https://doi.org/10.1016/j.exger.2015.09.016PMID:26408226
37. EllmanGL,CourtneyKD,AndresVJr.,FeatherstoneRM.Anewandrapidcolorimetricdetermination
ofacetylcholinesteraseactivity.BiochemPharmacol.1961;7:88–95.https://doi.org/10.1016/0006-
2952(61)90145-9PMID:13726518
38. OrhanI,SenerB,ChoudharyMI,KhalidA.Acetylcholinesteraseandbutyrylcholinesteraseinhibitory
activityofsomeTurkishmedicinalplants.JEthnopharmacol.2004;91(1):57–60.https://doi.org/10.
1016/j.jep.2003.11.016PMID:15036468
39. HoltA,SharmanDF,BakerGB,PalcicMM.Acontinuousspectrophotometricassayformonoamineoxi-
daseandrelatedenzymesintissuehomogenates.AnalBiochem.1997;244(2):384–92.https://doi.org/
10.1006/abio.1996.9911PMID:9025956
40. AwaleM,ReymondJ-L.PolypharmacologyBrowserPPB2:TargetPredictionCombiningNearest
NeighborswithMachineLearning.JChemInfModel.2019;59(1):10–7.https://doi.org/10.1021/acs.
jcim.8b00524PMID:30558418
41. StelzerG,RosenN,PlaschkesI,ZimmermanS,TwikM,FishilevichS,etal.TheGeneCardsSuite:
FromGeneDataMiningtoDiseaseGenomeSequenceAnalyses.CurrProtocBioinformatics.2016;
54:1.30.1–1..3.https://doi.org/10.1002/cpbi.5PMID:27322403
42. PineroJ,Ramirez-AnguitaJM,Sauch-PitarchJ,RonzanoF,CentenoE,SanzF,etal.TheDisGeNET
knowledgeplatformfordiseasegenomics:2019update.NucleicAcidsRes.2020;48(D1):D845–D55.
https://doi.org/10.1093/nar/gkz1021PMID:31680165
43. SzklarczykD,GableAL,LyonD,JungeA,WyderS,Huerta-CepasJ,etal.STRINGv11:protein-pro-
teinassociationnetworkswithincreasedcoveragesupportingfunctionaldiscoveryingenome-wide
experimentaldatasets.NucleicAcidsRes.2019;47(D1):D607–D13.https://doi.org/10.1093/nar/
gky1131PMID:30476243
44. HuangDW,ShermanBT,LempickiRA.Systematicandintegrativeanalysisoflargegenelistsusing
DAVIDbioinformaticsresources.NatProtoc.2009;4(1):44–57.https://doi.org/10.1038/nprot.2008.211
PMID:19131956
45. StaffordGI,PedersenPD,Ja¨gerAK,StadenJV.MonoamineoxidaseinhibitionbysouthernAfricantra-
ditionalmedicinalplants.SouthAfricanJournalofBotany.2007;73(3):384–90.
46. KapewangoloP,TawhaT,NawindaT,KnottM,HansR.Sceletiumtortuosumdemonstratesinvitro
anti-HIVandfreeradicalscavengingactivity.SouthAfricanJournalofBotany.2016;106:140–3.
47. Gonzalez-BurgosE,LiaudanskasM,ViskelisJ,ZvikasV,JanulisV,Gomez-SerranillosMP.Antioxidant
activity,neuroprotectivepropertiesandbioactiveconstituentsanalysisofvaryingpolarityextractsfrom
Eucalyptusglobulusleaves.JFoodDrugAnal.2018;26(4):1293–302.https://doi.org/10.1016/j.jfda.
2018.05.010PMID:30249328
48. RenZ,ZhangR,LiY,LiY,YangZ,YangH.Ferulicacidexertsneuroprotectiveeffectsagainstcerebral
ischemia/reperfusion-inducedinjuryviaantioxidantandanti-apoptoticmechanismsinvitroandinvivo.
IntJMolMed.2017;40(5):1444–56.https://doi.org/10.3892/ijmm.2017.3127PMID:28901374
49. YousefAOS,FahadAA,AbdelMoneimAE,MetwallyDM,El-KhadragyMF,KassabRB.Theneuropro-
tectiveroleofcoenzymeQ10againstleadacetate-inducedneurotoxicityismediatedbyantioxidant,
anti-inflammatoryandanti-apoptoticactivities.IntJEnvironResPublicHealth.2019;16(16):2895.
PLOSONE|https://doi.org/10.1371/journal.pone.0273583 August25,2022 20/21

## Page 21

PLOS ONE ExplorethetherapeuticpotentialofSceletiumtortuosuminthetreatmentofneurodegenerativedisorders
50. CoetzeeDD,LopezV,SmithC.High-mesembrineSceletiumextract(Trimesemine®)isamonoamine
releasingagent,ratherthanonlyaselectiveserotoninreuptakeinhibitor.JEthnopharmacol.2016;
177:111–6.https://doi.org/10.1016/j.jep.2015.11.034PMID:26615766
51. YueW,LiY,ZhangT,JiangM,QianY,ZhangM,etal.ESC-derivedbasalforebraincholinergicneu-
ronsamelioratethecognitivesymptomsassociatedwithAlzheimer’sdiseaseinmousemodels.Stem
CellRep.2015;5(5):776–90.https://doi.org/10.1016/j.stemcr.2015.09.010PMID:26489896
52. InestrosaNC,DinamarcaMC,AlvarezA.Amyloid-cholinesteraseinteractions.ImplicationsforAlzhei-
mer’sdisease.FEBSJ.2008;275(4):625–32.https://doi.org/10.1111/j.1742-4658.2007.06238.xPMID:
18205831
53. SpinksA,WasiakJ.Scopolamine(hyoscine)forpreventingandtreatingmotionsickness.Cochrane
databaseofsystematicreviews.2011(6).https://doi.org/10.1002/14651858.CD002851.pub4PMID:
21678338
54. Ben-BarakJ,DudaiY.Scopolamineinducesanincreaseinmuscarinicreceptorlevelinrathippocam-
pus.BrainRes.1980;193(1):309–13.https://doi.org/10.1016/0006-8993(80)90973-7PMID:7378826
55. NaoiM,RiedererP,MaruyamaW.Modulationofmonoamineoxidase(MAO)expressioninneuropsy-
chiatricdisorders-geneticandenvironmentalfactorsinvolvedintypeAMAOexpression.JNeural
Transm.2016;123(2):91–106.https://doi.org/10.1007/s00702-014-1362-4PMID:25604428
56. YoudimMBH,BakhleYS.Monoamineoxidase:isoformsandinhibitorsinParkinson’sdiseaseand
depressiveillness.BrJPharmacol.2006;147(Suppl.1):S287–S96.https://doi.org/10.1038/sj.bjp.
0706464PMID:16402116
57. DimpfelW,FranklinR,GerickeN,SchombertL.EffectofZembrin(®)andfourofitsalkaloidconstitu-
entsonelectricexcitabilityoftherathippocampus.JEthnopharmacol.2018;223:135–41.https://doi.
org/10.1016/j.jep.2018.05.010PMID:29758341
58. HarveyAL,YoungLC,ViljoenAM,GerickeNP.PharmacologicalactionsoftheSouthAfricanmedicinal
andfunctionalfoodplantSceletiumtortuosumanditsprincipalalkaloids.JEthnopharmacol.2011;137
(3):1124–9.https://doi.org/10.1016/j.jep.2011.07.035PMID:21798331
PLOSONE|https://doi.org/10.1371/journal.pone.0273583 August25,2022 21/21

