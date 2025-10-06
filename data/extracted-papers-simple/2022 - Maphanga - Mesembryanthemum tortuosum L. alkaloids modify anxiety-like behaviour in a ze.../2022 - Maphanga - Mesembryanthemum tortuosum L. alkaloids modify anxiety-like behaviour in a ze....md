## Page 1

JournalofEthnopharmacology290(2022)115068
Contents lists available at ScienceDirect
Journal of Ethnopharmacology
journal homepage: www.elsevier.com/locate/jethpharm
Mesembryanthemum tortuosum L. alkaloids modify anxiety-like behaviour in
a zebrafish model
Veronica B. Maphangaa, Krystyna Skalicka-Wozniakb, Barbara Budzynskac, Andriana Skibab,
Weiyang Chena, Clement Agonia, Gill M. Enslina, Alvaro M. Viljoena,d,*
aDepartment of Pharmaceutical Sciences, Tshwane University of Technology, Private Bag X680, Pretoria, 0001, South Africa
bDepartment of Natural Products Chemistry, Medical University of Lublin, 1 Chodzki Street, 20-093, Lublin, Poland
cBehavioral Studies Laboratory, Department of Medicinal Chemistry, Medical University of Lublin, 4A Chodzki Street, 20-093, Lublin, Poland
dSAMRC Herbal Drugs Research Unit, Tshwane University of Technology, Pretoria, 0001, South Africa
A R T I C L E I N F O A B S T R A C T
Keywords: Ethnopharmacological relevance: Mesembryanthemum tortuosum L. (previously known as Sceletium tortuosum (L.) N.
Mesembryanthemum tortuosum E. Br.) is indigenous to South Africa and traditionally used to alleviate anxiety, stress and depression.
Sceletium alkaloids Mesembrine and its alkaloid analogues such as mesembrenone, mesembrenol and mesembranol have been
ADMET
identified as the key compounds responsible for the reported effects on the central nervous system.
Zebrafish larvae
Aim of the study: To investigate M. tortuosum alkaloids for possible anxiolytic-like effects in the 5-dpf in vivo
Reverse-thigmotaxis
zebrafish model by assessing thigmotaxis and locomotor activity.
Materials and methods: Locomotor activity and reverse-thigmotaxis, recognised anxiety-related behaviours in 5-
days post fertilization zebrafish larvae, were analysed under simulated stressful conditions of alternating light-
dark challenges. Cheminformatics screening and molecular docking were also performed to rationalize the
inhibitory activity of the alkaloids on the serotonin reuptake transporter, the accepted primary mechanism of
action of selective serotonin reuptake inhibitors. Mesembrine has been reported to have inhibitory effects on
serotonin reuptake, with consequential anti-depressant and anxiolytic effects.
Results: All four alkaloids assessed decreased the anxiety-related behaviour of zebrafish larvae exposed to the
light-dark challenge. Significant increases in the percentage of time spent in the central arena during the dark
phase were also observed when larvae were exposed to the pure alkaloids (mesembrenone, mesembrenol,
mesembrine and mesembrenol) compared to the control. However, mesembrenone and mesembranol demon-
strated a greater anxiolytic-like effect than the other alkaloids. In addition to favourable pharmacokinetic and
physicochemical properties revealed via in silico predictions, high-affinity interactions characterized the binding
of the alkaloids with the serotonin transporter.
Conclusions: M. tortuosum alkaloids demonstrated an anxiolytic-like effect in zebrafish larvae providing evidence
for its traditional and modern day use as an anxiolytic.
2000). Several alkaloids have been isolated from M. tortuosum, namely;
1. Introduction mesembrine, mesembranol, mesembrenone, and mesembrenol. The
modulation of the stress response is mediated via inhibition of serotonin
Mesembryanthemum tortuosum L. (Aizoaceae) is a succulent plant reuptake into raphe nuclei neurons; after repeated administration this
indigenous to the southwestern parts of South Africa (Loria et al., 2014) results in increased serotonin levels throughout the brain (Smith et al.,
and is of scientific interest due to its possible therapeutic effects, such as 1996; Shikanga et al., 2013, Yohn et al., 2017) in the management of
the enhancement of physical well-being and the treatment of anxiety, anxiety, depression, bulimia nervosa, and obsessive-compulsive disor-
stress, and depression (Gericke and Viljoen, 2008). Traditionally, pas- der (Patnala and Kanfer, 2017). A recent report from our group also
toralists and hunter-gatherers have used this plant for managing predicted the moderation of anxiety-like behaviour in zebrafish larvae
mood-swings and improving general well-being (Van Wyk and Gericke, by M. tortuosum; in which, amongst the various medicinal plants studied
* Corresponding author. Department of Pharmaceutical Sciences, Faculty of Science, Tshwane University of Technology, Private Bag X680, Pretoria, 0001, South
Africa.
E-mail address: viljoenam@tut.ac.za (A.M. Viljoen).
https://doi.org/10.1016/j.jep.2022.115068
Received 30 September 2021; Received in revised form 29 January 2022; Accepted 31 January 2022
Availableonline5February2022
0378-8741/©2022ElsevierB.V.Allrightsreserved.

## Page 2

V.B. Maphanga et al. J o u r n a l o f E t h n o p h a r m a c o l o g y 290(2022)115068
Abbreviations GABA gamma aminobutyric acid
HPCCC high performance counter current chromatography
5-dpf 5 days post fertilization MTC maximum tolerated concentration
5-HT 5-hydroxytryptamine; PDE4 phosphodiester-4
5-HTT 5-hydroxytryptamine transporter SERT serotonin transporter
ADMET absorption, distribution, metabolism, excretion and SSRI selective serotonin reuptake inhibitor
toxicity SAR structure-activity relationships
AMPA α-amino-3-hydroxy-5-methyl-4-isoxazolepropionic acid RCSB PDB Research Collaboratory for Structural Bioinformatics
BBB blood brain barrier Protein Data Bank
cAMP cyclic adenosine monophosphate TPSA topological polar surface area
CNS central nervous system UCSF University of California San Francisco
DZ diazepam; UPLC-MS ultra-performance liquid chromatography coupled with
DMSO dimethyl sulfoxide; mass spectrometry
for anxiolytic activity, the water extract of M. tortuosum exhibited the Champagne et al., 2010; Colwill and Creton, 2011) and humans (Kallai
most favourable anxiolytic-like activity compared to other extracts et al., 2005, 2007) also demonstrate thigmotaxis. These species all tend
(Maphanga et al., 2020). to prefer peripheral areas of a novel environment rather than the central
M. tortuosum introduced to the market under the commercial name area in response to stressful situations (Treit and Fundytus, 1988;
Zembrin®, it is a standardised 70% alcoholic extract, containing Sharma et al., 2009). Thigmotaxis is the normal behavioural response of
0.35–0.45% total Sceletium alkaloids. The reported pharmacological zebrafish larvae when exposed to anxiety-inducing light-dark transitions
effects of Zembrin® include inhibition of the phosphodiester-4 (PDE4) (de Esch et al., 2012; Vignet et al., 2014). In this study, a positive control
enzyme as well as the inhibition of the serotonin (5-hydroxytryptamine, drug (diazepam), which acts as an agonist of gamma aminobutyric acid
5-HT) transporter (5-HTT, also known as SERT) (Harvey et al., 2011). (GABA) receptors in the CNS, was used to attenuate thigmotaxis
Inhibition of PDE4 results in the elevation of the intracellular cyclic behaviour.
adenosine monophosphate (cAMP) levels with resultant modulation of Therefore, in furtherance of our previous investigation on
second messenger effects and has been implicated in the regulation of M. tortuosum, this study aims to investigate the M. tortuosum alkaloids
anxiety and depression in animals models (O’Donnell and Zhang, 2004). for possible anxiolytic-like behavior by assessing thigmotaxis and loco-
For several decades serotonin and serotonin receptors have been linked motor activity using the 5-dpf in vivo zebrafish model. Molecular
to the aetiology of depression and the mechanisms fundamental to the modelling techniques were also employed to confirm and provide
response to antidepressant treatment (Yohn et al., 2017; Bowman and structural perspectives into any possible anxiolytic-like behavior of the
Daws, 2019; Butler and Meegan, 2008; Dell’Osso et al., 2005; Reimold alkaloids via the inhibition of SERT.
et al., 2008).
Selective 5-HT reuptake inhibitors (SSRIs) are widely used for the 2. Materials and methods
treatment of anxiety disorders and depression (Pringle et al., 2011;
Garakani et al., 2021). A combination treatment using an SSRI and a 2.1. Mesembryanthemum tortuosum alkaloids
PDE4 inhibitor has been suggested, due to the potential synergistic ef-
fects, in treating central nervous system (CNS) disorders. Chronic Mesembryanthemum tortuosum L. alkaloids were made available from
treatment with SSRIs has been reported to upregulate PDE4 (Ye et al., previous studies in our group as described by Shikanga et al. (2011). The
2000), resulting in tolerance and reduced sensitivity to SSRIs, suggesting four alkaloids were analysed for purity (>85%) prior to use in the in vivo
that combination treatment with SSRIs and PDE4 inhibitors is a rational assay. The analytical methods and typical spectra of M. tortuosum and
treatment option (Cashman et al., 2009). In a double-blind, cross-over, the isolated alkaloids are shown in supplementary files S1 and S2.
placebo-controlled study (Terburg et al., 2013) the potential synergistic
effects of a PDE4 inhibitor and SSRI combination were investigated. A 2.2. Zebrafish husbandry and embryo collection
standardised extract of M. tortuosum, Zembrin® (25 mg) a dual 5-HT
reuptake and PDE4 inhibitor, administered to 16 healthy study partici- The zebrafish larvae experiments were carried out at the Medical
pants subjected to an anxiety-related activity demonstrated the University of Lublin in Poland. The facility is under the European and
anxiety-attenuating effects of M. tortuosum, providing supporting evi- Polish law regulations, especially Directive 2010/63/EU of the Euro-
dence for the effectiveness of the combination of a PDE4 inhibitor and an pean Parliament and of the Council of September 22, 2010 on the pro-
SSRI. (Terburg et al., 2013). tection of animals used for scientific purposes and Act of 15th January of
By 5 days post fertilisation (5-dpf) zebrafish larvae exhibit a number 2015 on the protection of animals used for scientific or educational
of quantifiable behaviours such as hunting, avoidance, startle response, purposes. According to the practice, all experiments on zebrafish larvae
scototaxis, thigmotaxis, and increased locomotor activity in response to not capable of self-feeding (five days or younger) are exempted from
light-dark transitions (Fetcho and Liu, 1998; Colwill and Creton, 2011; applying for local ethical commission for experiments on animals. Danio
Schno¨rr et al., 2012; Basnet et al., 2019). Scototaxis refers to the pref- rerio of the AB strain (Experimental Medicine Centre, Medical University
erence for darker over brightly lit environments by teleost fish (Max- of Lublin, Poland) were maintained at 28.5 ◦C, on a 14/10 h light/dark
imino et al., 2010), whilst thigmotaxis is the preference for peripheral cycle, under standard aquaculture conditions. Fertilized eggs were
areas of a novel environment as opposed to the central area (Schnӧ;rr collected via natural spawning. Embryos were reared in E3 embryo
et al., 2012). Both behaviors, in addition to the high homology of medium (pH 7.1–7.3; 17.4 μM NaCl, 0.21 μM KCl, 0.12 μM MgSO4 and
zebrafish larva with mammals, present them as valuable models to 0.18 μM Ca(NO3)2) in an incubator (IN 110 Memmert GmbH, Germany)
perform many behavioral analysis, including anxiolytic-likeness. Other at 28.5 ◦C until 5-dpf.
species such as rodents (Treit and Fundytus, 1988; Prut and Belzung,
2003; Sousa et al., 2006; Belzung and Philippot, 2007), other fish species
(Lo´pez-Patiǹ;o et al., 2008; Peitsaro et al., 2003; Sharma et al., 2009;
2

## Page 3

V.B. Maphanga et al. J o u r n a l o f E t h n o p h a r m a c o l o g y 290(2022)115068
2.3. Determination of the maximum tolerated concentration (MTC) Anxiolytic-like activity (% distance moved in central arena) =[distance moved
in central arena/ distance moved in outer region +central arena] x 100 (2)
Stock solutions of 50 mM for each alkaloid were prepared in 1%
The locomotor activity was calculated using the tracking mode of
dimethyl sulfoxide (DMSO) (Sigma-Aldrich, Germany), sonicated for
complete dissolution, and stored at -20 ◦C. Concentrations required for ZebraLab software with recorded videos. The videos of zebrafish larvae
were acquired at 25 frames per second (fps) and were pooled into 1-min
MTC determinations were prepared each day from stock solutions
ranging from 10 to 150 μM. Larvae at 5-dpf were gently transferred into time bins. The detection threshold was set at 25, an arbitrary level that
allowed the software to detect the larvae movement accurately.
a 48 well plate using a plastic Pasteur pipette. Five larvae were trans-
ferred into each well. The medium was removed from each well, and
immediately 600 μL of each test sample was added to duplicate wells. 2.6. Computational methodology
The control group of larvae was exposed to 600 μL of 1% DMSO. The
MTC plates were placed in an incubator for 18 h at 28.5 ◦C overnight and 2.6.1. System preparation
observed under a microscope (ZEISS, Germany) the following morning The X-ray crystal structures of SERT complexed with paroxetine were
to detect the concentration at which sedation occurred, and signs of retrieved from Research Collaboratory for Structural Bioinformatics
acute locomotor impairment were observed, including hypo-activity, Protein Data Bank (RCSB PDB) (Berman et al., 2002) with identification
absence of touch response, decreased touch response, loss of posture, code 6W2B (Coleman et al., 2020). The structure also contained a heavy
body deformations (kryphosis, lordosis, scoliosis, and deformities), slow chain antibody fragment, chain B, while the human SERT was labelled
heartbeat, oedema, precipitation, and death. chain A. The antibody fragment was subsequently deleted during the
preparation of the system to reduce computational cost. The presence of
paroxetine in the SERT structure allowed for the identification of the
2.4. Anxiolytic-like activity assay
inhibitor binding site of the studied inhibitors, the M. tortuosum alka-
loids. The SERT complex was prepared for the molecular docking of the
The anxiolytic-like activity assay measuring thigmotaxis and loco-
four alkaloids. The structures of the alkaloids, as shown in Fig. 1 were
motor activity of the isolated compounds of M. tortuosum was performed
generated using Marvin Sketch 6.3.0 (ChemAxon, 2013). The 3D
according to the method previously described by Maphanga et al. (2020)
structure generation, energy minimization, and optimisation of the al-
and briefly summarised below. The anxiolytic-like activity assay was
kaloids were performed using the Avogadro software 2.0.8 (Hanwell
performed at 5-dpf on the zebrafish larvae. Stock solutions of each iso-
et al., 2012) before preparation on University California San Francisco
lated compound were prepared at 100 mM in 1% DMSO, and working
solutions (10, 15, 30, and 50 μM) were prepared in E3 medium each day (UCSF) Chimera 1.11.2 (Pettersen et al., 2004) for molecular docking.
Preparation of the complex for molecular docking involved removing
immediately prior to the assay, in accordance with the results obtained
hydrogen atoms and adding corresponding Gasteiger charges to each
from MTC determinations. A 100 mM stock solution of diazepam (DZ)
alkaloid using UCSF Chimera 1.11.2. Subsequently, the ligands were
(Sigma-Aldrich, Germany), dissolved in DMSO was prepared to yield a
working solution of 10 μM using the zebrafish system water before the saved in mol2 formats for molecular docking.
experiment. Three dilutions (2.5, 5, and 10 μM) were prepared to
2.6.2. Molecular docking
determine the most effective anxiolytic-like concentration of diazepam
AutoDock Vina 1.1.2 (Trott and Olson, 2010; Nguyen et al., 2019)
in 5-dpf zebrafish larvae as a positive control. The negative control
embedded in the software PyRx (Dallakyan and Olson, 2015) was
group was treated with 1% DMSO. The plate was incubated for 30 min
employed for the molecular docking of the four alkaloids into the par-
prior to the experiment and initiation of video tracking. Zebrabox
oxetine binding pocket on SERT. AutoDock Vina was used because of its
(Viewpoint, Lyon, France) with ZebraLab software was used for video
known scoring power and reliability in predicting accurate binding
tracking. The plate was held in a multi-well plate holder located in the
poses (Nguyen et al., 2019) (A grid box with coordinates X =30.62, Y =
automated video recording bench station (Viewpoint) connected to a
180.21, Z =143.45 for centre and X, Y, and Z dimensions of 9.66, 9.50,
temperature control unit maintaining the temperature between 27 and
29 ◦C (Schno¨rr et al., 2012). and 7.57 respectively, for the size, were used. Generated docked results
were displayed in Protein Data Bank, Partial Charge (Q), & Atom Type
(T)) (pdbqt) format, and the optimal geometric position with the best
2.5. Thigmotaxis and locomotor activity
pose and energy score was selected for each compound and saved in a
complex form with reference to SERT. Intermolecular interactions were
This experiment was conducted over a period of 95 min with 10 min
visualized using Discovery studio visualizer 3.0 (BIOVIA, 2017).
of acclimatization, 40 min of continuous lighting to study spontaneous
locomotor activity, immediately followed by three light-dark transi-
2.6.3. Cheminformatics screening of the physicochemical and
tions, to induce anxiety-like behaviour in the zebrafish larvae (15 min
pharmacological properties of alkaloids
each, i.e., 10 min illumination and 5 min of darkness) (Peng et al.,
The physicochemical and pharmacokinetic properties of the alka-
2016). The protocol of Schno¨rr et al. (2012) was adopted; the inner zone
loids predicted on the SwissADME platform were used to ascertain their
of the well was marked to study reverse-thigmotaxis, and a threshold possible adherence to Lipinski’s rules of five (Lipinski et al., 2001; C. A.
was established to detect larval movement. The threshold for inactivity
Lipinski et al., 2012), a set of rules widely employed in assessing the
and shorter movements was set at 0.2 cm/s, while the total duration
drug-likeness of chemical compounds (Lipinski, 2000; Lipinski et al.,
spent in longer movements was set at 0.8 cm/s. The model for the
2012). An assessment of the oral toxicities of the alkaloids through the
assessment of the thigmotaxis and locomotor activity was in accordance prediction of their LD50 ’s was performed using the ProTox webserver,
with the thorough descriptions outlined in our previous report
which evaluated the toxicities based on structural similarities to identify
(Maphanga et al., 2020). Anxiolytic-like activity was defined as reversed
over-represented fragments in toxic compounds (Drwal et al., 2014;
thigmotaxis and was indicated by an increase in the time spent in the
Hurmath Unnissa and Rajan, 2016). AdmetSAR 2.0 (Hongbin et al.,
central arena. Measurement of the distance moved and the time spent in 2019) was subsequently employed to access the alkaloids’ metabolic
the central arena was acquired for the analysis. The percentage distance
properties and predict their absorption and distribution properties.
moved by zebrafish larvae and percentage time spent in the central
arena were calculated as shown below:
2.7. Statistical analysis
Anxiolytic-like activity (% time in central arena) =[time in central arena/ time
in outer region +central arena] x 100 (1) The Prism software (GraphPad 7.04 Software, San Diego, CA) was
3

## Page 4

V.B. Maphanga et al. J o u r n a l o f E t h n o p h a r m a c o l o g y 290(2022)115068
Fig. 1. Structures of Mesembryanthemum tortuosum alkaloids.
used to determine the statistical differences between various drugs and treatment, the effect on locomotor activity, and the stimulatory effects of
dilutions. Data were presented as mean ± SEM. Light-dark response, the alkaloids on the zebrafish larvae prior to exposure to the anxiety-
dose-dependent response (treatment), or interaction between light-dark mimicking light-dark transitions. The concentrations of alkaloids used
condition and dose was calculated was calculated using two-way in the test groups were informed by the results of the MTC studies, and
ANOVA. According to GraphPad and Statistica software, Tukey Post- encompassed the MTC and dilutions thereof. Concentrations between 75
hoc is dedicated to one-way, whereas the Bonferoni test is dedicated and 150 μM significantly impaired locomotor activity of the zebrafish
to two-way ANOVA. The confidence limit of p <0.05 was considered larvae, so these concentrations were excluded in further studies; 50 μM
statistically significant. was determined as the MTC and accordingly data for 50, 30, 15 and 10
μM test groups is presented. Neither diazepam (10 μM) nor mesembrine
3. Results at concentrations of 10, 15, 30, and 50 μM impaired the locomotor ac-
tivity of 5-dpf zebrafish larvae compared to the negative control (1%
3.1. Anxiolytic activity DMSO)(one way ANOVA: F (5,192) =0.3016, p =0.9995) (Fig. 2A); no
significant differences in total locomotor activity (reported as average
3.1.1. The effect of mesembrine on spontaneous locomotor activity of the distance moved per min in cm) were observed between test groups and
zebrafish larvae during continuous illumination the control. Reverse thigmotaxis behaviour was, however, noted to be
Three different concentrations of diazepam (2.5, 5, and 10 μM), a significant between test and control groups. One-way ANOVA revealed
well-known anxiolytic drug, were tested to identify the most effective statistically significant differences between the percentage of the total
anxiolytic-like response in 5-dpf zebrafish larvae. The 10 μM DZ con- distance that was moved in the central arena during the 40 min of
centration demonstrated the best anxiolytic-like activity (reverse-thig- continuous lighting conditions (F (5,192) =4.165, p =0.0006). Post-hoc
motaxis) and was accordingly used in all further studies at this Tukey’s test confirmed that both 10 μM diazepam (p < 0.001) and
concentration for the positive control. Mesembrine is a well-known mesembrine at a concentration of 50 μM (p <0.01) resulted in statisti-
major compound found in the aerial parts of M. tortuosum; thus, the cally significant reverse-thigmotaxis behaviour when compared to the
results of mesembrine are used as an example to demonstrate its effect negative control, where diazepam and mesembrine showed a 78% and
on spontaneous locomotor activity of the zebrafish larvae during the 40 77% increase in the total distance moved respectively (Fig. 2B).
min of continuous illumination. Similar results were obtained for the One-way ANOVA also revealed statistically significant differences in
other three alkaloids, mesembrenone, mesembrenol, and mesembranol. the percentage of time spent in the central arena (F (5,192) =4.117, p =
To avoid repetition only results for mesembrine are shown. These results 0.0028). A post-hoc Tukey’s test confirmed that diazepam (positive
are provided to demonstrate the response of larvae to alkaloid control) (p < 0.01) and mesembrine (50 μM) (p < 0.01) significantly
Fig. 2. (A) The effects of mesembrine (10, 15, 30 and 50 μM) and diazepam (10 μM) on average distance moved by zebrafish larvae (cm) under continuous illu-
mination. (B) The reverse-thigmotaxis behaviour observed as the percentage distance moved in the central arena under the influence of mesembrine (10, 15, 30 and
50 μM) and diazepam (DZ, 10 μM) under continuous illumination. (C) The thigmotaxis behaviour under continuous lighting was assessed by the percentage of time
spent in the central arena under the influence of mesembrine (10, 15, 30 and 50 μM) and diazepam (10 μM). Data are presented as mean ±SEM, n =32. **p <0.01,
***p <0.001 vs positive control group (Post-hoc Tukey’s test).
4

## Page 5

V.B. Maphanga et al. J o u r n a l o f E t h n o p h a r m a c o l o g y 290(2022)115068
increased observed parameter compared to the negative control group DMSO (p <0.001), and mesembrenol - 10 μM (p <0.05), 15 μM (p <
(Fig. 2C). These results indicated statistically significant decreased 0.01), 30 μM (p <0.01) and 50 μM (p <0.05) compared with the light
thigmotaxis during continuous illumination after treatment with both phase. However, there was a significant statistical decrease in locomotor
diazepam and mesembrine (50 μM), indicative of potential anxiolytic- activities during the dark challenge phase when larvae were treated with
like activity of mesembrine, where diazepam and mesembrine showed diazepam and mesembrenol 50 μM (p <0.01), where a 32% and 26. %
a 52% and 60% increase in the time spent in the central arena decrease was observed respectively (Fig. 4).
respectively. When average distances travelled were observed, two-way ANOVA
for mesembrine showed statistically significant changes in light-dark
3.1.2. The effect of the four alkaloids on distance travelled by the zebrafish condition response [F (1, 204) =36.61, p <0.0001], treatment effect
larvae during the light-dark challenge assay [F (5, 204) =2.88, p =0.0154] as well as interaction [F (5, 204) =3.69,
Changes in locomotor activity were observed in zebrafish larvae in p =0.0032]. The post-hoc Bonferroni’s analysis during the dark chal-
all four alkaloid treatment groups in response to light-dark challenges. lenge phase demonstrated significant increases in locomotor activities
No obvious habituation was observed across all three light-dark cycles when the 5-dpf larvae were treated with 1% DMSO (p < 0.001), and
for all alkaloid test groups (data not shown). In order to better charac- mesembrine at concentrations of 10 μM (p <0.001), 15 μM (p <0.001),
terise the treatment effect for each alkaloid on the locomotor activities 30 μM (p <0.001), 50 μM (p <0.01) compared with the light phase. A
of the zebrafish larvae in response to light-dark challenge, the average significant 27.5% decrease in locomotor activities during the dark
distances travelled per min were determined. When the average dis- challenge phase was observed only on diazepam, the positive control (p
tances were observed, two-way ANOVA showed statistically significant <0.01) compared to the DMSO treated group (Fig. 5).
changes in light-dark condition response (F (1, 204) = 36.61, p < When average distance were considered, two-way ANOVA for
0.0001), treatment effect (F (5, 204) = 2.88, p = 0.0154) as well as mesembranol showed statistically significant changes in light-dark
interaction (F (5, 204) =3.69, p =0.0032). The Post-hoc Bonferroni’s condition response (F(1, 384) = 104.98, p < 0.0001)), treatment ef-
analysis demonstrated a statistically significant decrease in locomotor fect (F (5, 384) =3,89, p =0.0010) as well as interaction (F (5, 384) =
activity of zebrafish larvae during the dark challenge phase at 30 and 50 2.89, p =0.0057). The Post-hoc Bonferroni’s analysis showed a decrease
μM concentrations of mesembrenone (p <0.01), respectively, in com- of locomotor activities during the dark challenge phase after diazepam
parison with the DMSO-treated group during the dark phase (Fig. 3). The and mesembranol 10 μM and 15 μM in comparison with DMSO-treated
observed decrease in locomotor activity was 60% and 80%, respectively. group in dark phase (p <0.01). The percentage decrease in the average
Also, during the dark challenge phase significant increase in locomotor distance moved by larva was 30.57% for diazepam while the percentage
activity was observed when the 5-dpf larvae were treated with DMSO (p decrease for mesembranol 10 and 15 μM was 40.5% and 41% respec-
<0.001), diazepam 10 μM (p <0.01) and mesembrenone - 10 μM (p < tively. During the dark challenge phase significant increases in loco-
0.01) and 15 μM (p <0.05) compared with the light phase. motor activities were observed when the 5-dpf larvae were treated with
On exposure to mesembrenol, the zebrafish larvae demonstrated DMSO (p <0.001), and mesembranol - 10 μM (p <0.05), 15 μM (p <
changes in locomotor activities in response to dark challenges. For the 0.01), 30 μM (p <0.001) and 50 μM (p <0.001) compared with the light
average distance moved by larvae, two-way ANOVA showed statistically phase as shown in Fig. 6.
significant changes in the light-dark condition response (F (1, 384) =
104.98, p <0.0001), treatment effect (F (5, 384) =3,89, p =0.0010) as 3.1.3. The effects of the four alkaloids on percentage distance travelled in
well as interaction (F (5, 384) =2.89, p =0.0057). The Post-hoc Bon- the central arena
ferroni’s analysis showed a significant increase in locomotor activities The effects of the four alkaloid treatments were studied during the
during the dark challenge phase when the 5-dpf larvae were treated with light-dark challenges on reverse-thigmotaxis behaviour of the 5-dpf
zebrafish larvae as they demonstrated an increased percentage on the
distance travelled in the central arena. Two-way ANOVA for mesem-
brenone demonstrated the changes in light-dark response (F (1, 384) =
9.93, p = 0.0001], treatment (F (5, 384) = 159.46, p = 0.0001) and
Fig. 3. Mesembrenone: Average distances moved by zebrafish larvae within Fig. 4. Mesembrenol: Average distances moved by zebrafish larvae within each
each 1-min time bin under either light (open bars) or dark (filled bars) were 1-min time bin under either light (open bars) or dark (filled bars) were plotted.
plotted. Data are presented as mean ±SEM, n =32 animals per group. *p < Data are presented as mean ±SEM, n =32 animals per group. *p <0.05,**p <
0.05,**p <0.01, ***p <0.001 vs the same group under light condition; ##p < 0.01, ***p <0.001 vs the same group under light condition; ##p <0.01 vs
0.01 vs control group under dark condition (Post-hoc Bonferroni). control group under dark condition (Post-hoc Bonferroni).
5

## Page 6

V.B. Maphanga et al. J o u r n a l o f E t h n o p h a r m a c o l o g y 290(2022)115068
<0.01) and 50 μM (p <0.001) compared with the light phase. During
the dark challenge phase a significant increase in locomotor activities
were observed when the 5-dpf larvae were treated with diazepam (p <
0.01) and mesembrenol at the dose of 10 μM (p <0.05) when compared
with 1% DMSO-treated group in dark phase, where a percentage in-
crease of 56.4% and 49% was observed, respectively, as shown in
Fig. 7B.
Two way ANOVA in light-dark condition for mesembrine showed
statistically significant changes in light-dark condition response (F (1,
204) = 36.61, p < 0.0001), treatment effect (F (5, 204) = 2.88, p =
0.0154) as well as interaction (F (5, 204) =3.69, p =0.0032). The Post-
hoc Bonferroni’s analysis showed a decrease in locomotor activities
during the dark challenge phase after diazepam (p <0.01) in compari-
son with DMSO-treated group in dark phase and mesembrine at a con-
centration of 50 μM (p <0.05). Diazepam showed a decrease of 73.5%
whiles mesembrine 50 μM showed a decrease of 31.16% in the distance
moved in the central arena. Also, during the dark challenge phase sig-
nificant increases in locomotor activities were observed when the 5-dpf
Fig. 5. Mesembrine: Average distances moved by zebrafish larvae within each larvae were treated with DMSO (p < 0.001), diazepam (0.001) and
1-min time bin under either light (open bars) or dark (filled bars) were plotted. mesembrine - 10 μM (p <0.001), 15 μM (p <0.001), 30 μM (p <0.001),
Data are presented as mean ±SEM, n =32 animals per group. **p <0.01, ***p 50 μM (p <0.001) compared with the light phase as demonstrated in
<0.00, 1 vs the same group under light condition; ##p <0.01 vs control group
Fig. 7C.
under dark condition (Post-hoc Bonferroni).
For the zebrafish larvae at 5-dpf, mesembranol treatment and dark
challenge altered thigmotaxis behaviours of the larvae, when the trav-
elling distances in the central arena were considered. Two-way ANOVA
light-dark condition (F (1, 384) =19.36, p <0.0001), treatment [F (5,
384) = 168.25, p < 0.0001) and interaction (F (5, 384) = 9.98, p <
0.0001). Post-hoc Bonferroni showed an increase in percentage distance
moved in the central arena after DMSO (p <0.01), diazepam (p <0.001)
and mesembranol 10 μM (p <0.001), 15 μM (p <0.001), 30 μM (p <
0.01) and 50 μM (p <0.001) compared with the light phase. During the
dark challenge phase significant increases in locomotor activities were
observed when the 5-dpf larvae were treated with diazepam (p <0.01)
and mesembranol at the dose of 50 μM (p <0.05) when compared with
DMSO-treated group in dark phase, where the observed percentage in-
crease was 38% and 12.3%, respectively (Fig. 7D).
3.1.4. The effect of the four alkaloids on reverse-thigmotaxis behaviour
with respect to time spent in the central arena, by the zebrafish larvae during
the light-dark challenge
In addition to the distance travelled by the zebrafish larvae in the
central arena of the well, the time spent in the center also plays a role in
Fig. 6. Mesembranol: Average distances moved by zebrafish larvae within each assessing reverse-thigmotaxis behaviour of the zebrafish larvae as an
1-min time bin under either light (open bars) or dark (filled bars) were plotted. indication of potential anxiolytic-like activity. Two-way ANOVA and
Data are presented as mean ±SEM, n =32 animals per group. *p <0.05,**p < post-hoc Bonferroni’s test revealed statistically significant results for the
0.01, ***p <0.0001 vs the same group under light condition; ##p <0.01 vs effects of mesembrenone, mesembrenol, mesembrine, and mesembranol
control group under dark condition (Post-hoc Bonferroni). on the zebrafish larvae with respect to the time spent in the central
arena. When reverse-thigmotaxis behaviour of the larvae for mesem-
interaction (F (5, 384) =4.18, p =0.0011]. Post-hoc Bonferroni showed brenone treated groups were observed, two-way ANOVA under the
an increased percentage on the distance moved in the central arena after light-dark condition showed an increase of response [two way ANOVA
diazepam (p <0.001) and mesembrenone at 10 μM (p <0.001), 15 μM light-dark condition as (F (1, 384) =5.64, p <0.0001), treatment [F (5,
(p <0.01), 30 μM (p <0.001) and 50 μM (p <0.001) in comparison with 384) = 235.93 p < 0.0001] and interaction (F (5, 384) = 4.18, p <
the light phase. During the dark challenge phase significant increases in 0.0001). Post-hoc Bonferroni showed an increase in the percentage of
locomotor activities were observed when the 5-dpf larvae were treated time spent on the central arena the during dark phase after DMSO-
with diazepam (p <0.001), mesembrenone - 10 μM (p <0.05), 15 μM (p treatment (p < 0.01), diazepam and mesembrenone at all doses (p <
<0.05), 30 μM (p <0.01) and 50 μM (p <0.001) compared with DMSO- 0.001) compared with the light phase. During the dark challenge phase a
treated group in dark phase (Fig. 7A). Diazepam showed 120.27% in- significant increase in the percentage time spent on the central arena
crease in the distance moved in the central arena whiles mesembrenone was observed when the 5-dpf larvae were treated with diazepam (p <
10 μM, 15 μ, 30 μM, and 50 μM showed a percentage increase of 28.3%, 0.01) and mesembrenone at 10 μM (p <0.05), 15 μM (p <0.05), 30 μM
32.5%, 67.36% and 106.4%, respectively. (p <0.01) and 50 μM (p <0.001) compared with DMSO-treated group in
Two-way ANOVA in light-dark condition for mesembrenol showed dark phase as shown in Fig. 8A. Thus diazepam showed an increase of
the following statistics for response (F (1, 384) = 9.36, p < 0.0001), 120.3% and mesembrenone 10 μM–28.34%, 15 μM–32.5%; 30
treatment (F (5, 384) =168.25, p =0.0001) and interaction (F (5, 384) μM–67.4%, 50 μM–106.4% in time spent in the central arena (Fig. 8A).
= 9.98, p = 0.0001). Post-hoc Bonferroni showed an increase in the Two-way ANOVA demonstrated the effect of mesembrenol under the
percentage distance moved in the central arena after DMSO (p <0.01), light-dark condition when the time spent in the central arena was
diazepam (p <0.001) and mesembrenol at 10 μM (p <0.001)) 30 μM (p observed on an increased response [F (1, 384) = 8043, p < 0.0001],
6

## Page 7

V.B. Maphanga et al. J o u r n a l o f E t h n o p h a r m a c o l o g y 290(2022)115068
Fig. 7. Reverse-thigmotaxis behaviour demonstrated by the distance moved in the central arena throughout the three light-dark cycles as influenced by compounds
of different concentrations. Open bars signify light cycle while shaded bars are for dark cycle were plotted to demonstrate the percentage distance moved by zebrafish
larvae in the central arena. (A) Mesembrenone. (B) Mesembrenol. (C) Mesembrine (D) Mesembranol. Data are presented as mean ±SEM, n =32.**p <0.01, ***p <
0.001 vs the similar group under light condition; #p <0.05, ##p <0.01, ###p <0.001 vs positive control group under dark condition (Post-hoc Bonferroni’s test).
treatment (F (5, 384) =110.56 p <0.0001) and interaction (F (5, 384) Post-hoc Bonferroni showed an increase in the percentage time spent in
=10.42, p <0.0001). Post-hoc Bonferroni showed an increase in the the central arena during dark phase after DMSO-treatment (p <0.01),
percentage of time spent on the central arena during dark phase after diazepam (p < 0.001) and mesembranol at the dose of 10 μM (p <
DMSO-treatment (p <0.05), diazepam (p <0.001), and mesembrenol at 0.001), 15 μM (p < 0.001), 30 μM (p < 0.01) and 50 μM (p < 0.01)
the dose of 10 μM (p <0.01), 30 μM (p <0.01) and 50 μM (p <0.001) compared with the light phase. During the dark challenge phase a sig-
compared with the light phase. During the dark challenge phase, sig- nificant increase in the percentage time spent in the central arena was
nificant increase in the percentage of time spent on the central arena was observed when the 5-dpf larvae were treated with diazepam (p <0.01)
observed when the 5-dpf larvae were treated with diazepam (p <0.01) and mesembranol at 30 and 50 μM (p <0.001) when compared with
and mesembrenol - 10 μM (p <0.05) when compared with the DMSO- DMSO-treated group in dark phase (Fig. 8D). Diazepam showed a
treated group in the dark phase as shown in Fig. 8B. The observed 120.27% increase in the time spent in the central arena while mesem-
percentage increase was 55.4% and 38.4%, respectively. branol 30 μM and 50 μM showed a percentage increase of 150.5% and
Mesembrine at different concentrations also demonstrated an effect 124.7% respectively.
under the light-dark condition when the time spent in the central arena
was observed [two-way ANOVA light-dark condition response (F (1,
384) =5.64, p <0.0001), treatment (F (5, 384) =235.93 p <0.0001) 3.2. Differential physicochemical, pharmacokinetic and toxicity
and interaction (F (5, 384) = 4.18, p < 0.0001). Post-hoc Bonferroni characteristics of the four alkaloids using in silico techniques
showed an increase in the percentage time spent on the central arena
during the dark phase after DMSO-treatment (p <0.01), diazepam and Several in silico software applications were employed to predict
mesembrenone at all doses (p <0.001) compared with the light phase. crucial properties of the alkaloids that would affect their absorption,
During the dark challenge phase a significant increase in the percentage distribution, metabolism, and potential toxic effects. The physico-
time spent on the central arena was observed when the 5-dpf larvae were chemical properties and drug-likeness assessment of the alkaloids were
treated with diazepam and mesembrine – 50 μM (p <0.01) compared predicted using the SwissADME platform and presented in Table 1.
with DMSO-treated group in dark phase shown in Fig. 8C. The observed These were subsequently validated using AdmetSAR 2.0. All the alka-
percentage increase was 87.4% and 68.3%, respectively. loids have a molecular weight below 500 g/mol, and based on the in
Mesembranol also demonstrated an effect on reverse-thigmotaxis silico predictions, all the alkaloids were shown to possess the following
behaviours on the larvae, when the durations of the activities in the properties: an octanol-water partition coefficient below 5, hydrogen
central arena were observed [two-way ANOVA light-dark condition bond donors below 5, and hydrogen bond acceptors below 10. This
response (F (1, 384) = 8043, p < 0.0001), treatment (F (5, 384) = suggested an adherence of all the alkaloids to Lipinski’s rules of five
110.56 p <0.0001) and interaction (F (5, 384) =10.42, p <0.0001). (Lipinski et al., 2012), thus predicting their drug-likeness and potential
suitability for bioactivity. Adherence of the alkaloids to Lipinski’s rule of
7

## Page 8

V.B. Maphanga et al. J o u r n a l o f E t h n o p h a r m a c o l o g y 290(2022)115068
Fig. 8. Reverse-thigmotaxis behaviour represented by the percentage time spent in the central arena during the three light-dark cycles under the influence of
different concentrations of compounds. The percentage of time spent by a zebrafish larva in the central arena under either light (open bars) or dark (filled bars) was
plotted. Data are presented as mean ±SEM, n =32 animals per group. (A) Mesembrenone. (B) Mesembrenol. (C) Mesembrine. (D) Mesembranol *p <0.05, **p <
0.01, ***p <0.001 vs the same group under light condition; #p <0.05, ##p <0.01, ###p <0.001 vs positive control group under dark condition (Post-hoc
Bonferroni’s test).
Table 1
Differential estimations of physicochemical properties of the M. tortuosum alkaloids.
Compound Mesembrenone Mesembrenol Mesembrine Mesembranol
Chemical formula C17H21NO3 C17H23NO3 C17H23NO3 C17H25NO3
Molecular weight (g/mol) 287.35 289.37 289.37 291.39
Number of heavy atoms 21 21 21 21
Number of aromatic heavy 6 6 6 6
atoms
Number of rotatable bonds 3 3 3 3
Number of H-bond acceptors 4 4 4 4
Number of H-bond donors 0 1 0 1
TPSA (Å2) 38.77 41.93 38.77 41.93
Molar Refractivity 85.04 86.00 85.51 86.48
LogPO/W 2.84 2.13 2.32 2.26
LogS (moles/L) -1.96 -1.91 -2.09 -2.21
LD50 (mg/kg) 580 420 369 340
Bioavailability Radar Summary
five further suggested favourable oral bioavailability and a tendency to alkaloids was shown to fall within the suitable physicochemical space
cross various aqueous and lipophilic barriers such as the blood-brain (colored zone) correlating with oral bioavailability. The ability of the
barrier (BBB) and the gastrointestinal tract (Lipinski et al., 2012). The alkaloids to cross lipophilic barriers was also evidenced by a LogPow of
prediction of the lipophilicity of the alkaloids on SwissADME was based less than 5, representing favourable lipophilicity (Lipinski et al., 2001)
on the Brain Or IntestinaL EstimateD permeation method (BOILED-Egg) and a topological polar surface area (TPSA) below 140Å. A predicted
concept (Daina and Zoete, 2016). As shown in Table 1, each of the TPSA below 140 Å for all the alkaloids suggested the ability of the
8

## Page 9

V.B. Maphanga et al. J o u r n a l o f E t h n o p h a r m a c o l o g y 290(2022)115068
alkaloids to be transported across the lipid bilayer and the BBB since binding of SERT include; Asp98, Try95, and Ile172 (Barker et al., 1998;
TPSA takes into account polar atoms on the surfaces of the compounds Henry et al., 2006; Sørensen et al., 2012). Interaction with these residues
(Ertl et al., 2000; Prasanna and Doerksen, 2009; Shityakov et al., 2013). is known to establish high-affinity recognition of antidepressants.
To augment their predicted drug-likeness and lipophilicity, the LD50 of Interestingly, the alkaloids elicited strong interactions with these crucial
the alkaloids, a parameter that assesses the differential toxicities when residues, as shown in Table 2, thereby suggesting their inhibitory po-
orally administered, was also predicted using the ProTox platform. tential and possible high-affinity recognition similar to known antide-
Compounds with an oral LD50 of 0–50 mg/kg are considered highly pressants. Specifically, mesembranol engaged in salt bridge interaction
toxic, whereas compounds with LD50 greater than 2000 mg/kg are less with Asp98, whereas van der Waals interactions were formed with
toxic (Morris-Schaffer and McCoy, 2021). Accordingly, it could be Try95, Ile172, Asn177, and Ala169. Mesembrenol engaged in salt bridge
deduced that the alkaloids would present no oral toxicity since they each interaction with Asp98, a conventional hydrogen bond with Tyr95, and
showed LD50 values above 0–50 mg/kg, as shown in Table 1. a π-alkyl with Ile172. Mesembrenone, on the other hand, elicited a salt
All the alkaloids were predicted to have the ability to permeate the bridge interaction with Asp98, a conventional hydrogen bond with
BBB, to be absorbed through the human intestinal wall, possessed Caco- Tyr95, and a π-alkyl with Ile172. Mesembrine was also shown to exhibit
2 permeability, were potential substrates of P-glycoprotein, and were a conventional hydrogen bond with Tyr95, π-alkyl with Ile172, and a
non-inhibitors of P-glycoprotein. The favourable predictions towards van der Waals interaction with Asp98. The similarity in the dynamics of
these key markers of drug absorption (Hubatsch et al., 2007; Lin, 2004; the alkaloids’ interactions suggests a similarity in their binding mech-
Lin and Yamazaki, 2003; Van Breemen and Li, 2005) further suggest anisms, whereas their collective similarity with paroxetine also suggests
their therapeutic potential and thereby warrant further investigation. a similarity in binding mechanisms and a possible SERT inhibitory
These findings corroborated reports by Shikanga et al. (2012) in which activity.
the purified or crude extract form of the M. tortuosum alkaloids was As shown in Table 2, the unique orientations of the alkaloids could
shown to permeate across intestinal, buccal, and sublingual mucosal have also contributed to the favourable interactions observed. Mesem-
tissue. branol and mesembrenol assumed unique orientations that allowed for
The prediction of the metabolic properties of the alkaloids using key the formation of salt bridges between the indole ring and Asp98 and
biological markers, notably CYP450 2D6 and CYP450 2C9 on the possibly accounted for the similar docking score of -7.9 kcal/mol. The
AdmetSAR platform, also showed that all the alkaloids were non- observed peculiar orientations of both mesembranol and mesembrenol
substrates and non-inhibitors of CYP450 2C9, a crucial drug- could be attributed to the conventional hydrogen bond-mediated hy-
metabolising enzyme that accounts for about 18% of cytochrome P450 droxyl group on C6, a moiety previously reported by Dimpfel and col-
protein content in the human microsomes (Van Booven et al., 2010). leagues in 2018 as a crucial determinant of their mechanism of action.
Also, all the alkaloids were predicted to be potential substrates and in- Mesemberine and mesembrenone assumed unique orientations charac-
hibitors of CYP450 2D6, except mesembrine, which was the only terized by their anchorage at opposing ends of the binding pocket by
non-inhibitor of CYP450 2D6. As substrates of CYP450 2D6, an enzyme conventional hydrogen bond interactions between Tyr95, Val97, and
implicated in the metabolism of about 25% of current drugs in clinical the indole rings and π-alkyl between the dimethoxy-phenyl moiety and
use, including known antidepressants like paroxetine, suggests a guar- Ile172, Val501 and Phe335. These peculiar orientations and associated
antee of the metabolism of the alkaloids upon absorption (Ingelman-- interaction on both mesembrenone and mesembrine collected accoun-
Sundberg et al., 2007; Vuppalanchi, 2011). The predicted potential ted for the similarity in docking score of -8.1 kcal/mol, particularly, the
inhibition of CYP450 2D6 is characteristic of cotreatment with SERT interactions mediated by the unique carbonyl group on the C6 of both
inhibitors, leading to a decrease in the metabolism of substrate drugs alkaloids. Collectively these varying binding modes could favour bind-
(Tirona and Kim, 2017). Overall the alkaloids were shown to possess ing pocket stability and binding affinity of the alkaloids.
favourable pharmacokinetic and physicochemical properties, which
warrants further investigation of the M. tortuosum alkaloids as potential 4. Discussion
inhibitors of SERT.
Mesembryanthemum tortuosum, known as ‘kougoed’ or ‘channa’ in
3.2.1. Exploring the binding mechanisms of M. tortuosum alkaloids to the South Africa, traditionally used for its tranquillizing and anxiolytic
serotonin reuptake transporter (SERT) properties (Gericke and Viljoen, 2008; Smith, 2011), is marketed as
Having established the anxiolytic-like effects of these alkaloids in the Zembrin®, a standardized ethanolic extract (Shikanga et al., 2012).
previous sections of the study, we further investigated the potential Since 2010 M. tortuosum has been the subject of much in vitro and in vivo
SERT inhibitory mechanism of the alkaloids by comparing their binding research, as well as clinical studies, with respect to its CNS activity. All
mechanism with the known SERT inhibitor, paroxetine (Nevels et al., these studies, with the exception of Fountain (2016), corroborated its
2016; Pollack et al., 2001). Molecular docking of the four M. tortuosum mood elevation, antidepressant or antiepileptic activity (Gericke and
alkaloids; mesembrenol, memsembrine, mesembrenone, and mesem- Viljoen, 2008; Harvey et al., 2011; Loria et al., 2014; Schell, 2014;
branol, revealed docking scores of -7.9 kcal/mol, -8.1 kcal/mol, -8.1 Carpenter et al., 2014; Dimpfel et al., 2018). The anxiolytic-like effects
kcal/mol, and -7.9 kcal/mol, respectively, within the paroxetine binding of M. tortuosum have also been studied and substantiated by some
pocket as shown in Table 2. Redocking of paroxetine also revealed a research groups (Dimpfel et al., 2018; Fountain, 2016). In a recent study
docking score of -11.1 kcal/mol. The similarity in the docking scores of by Maphanga et al. (2020) on various extracts of M. tortuosum, the
the alkaloids suggests a similarity in binding pocket stability and affinity aqueous extract exhibited the highest anxiolytic-like activity in the
towards SERT. The alkaloids were also shown to engage in an extensive larval zebrafish light-dark challenge model of anxiety;
network of interactions with SERT pocket residues similar to paroxetine, reverse-thigmotaxis behaviour was evaluated, and the increased time
suggesting a similarity in a binding mechanism. These extensive in- spent in the central arena demonstrated the superior anxiolytic-like
teractions anchor the alkaloids within their respective binding pockets, activity of the water extract to that of other less polar extracts. These
which intend to favour the formation of high-affinity binding promising results prompted further analysis of compounds potentially
interactions. responsible for the bioactivity of the water extract.
According to a report by Coleman et al., in 2019 and 2020 and a Accordingly, in this study, the psychoactive properties of alkaloids
separate report by Slack et al. (2019), residues Asn177 and Ala169 are (mesembrenone, mesembrenol, mesembrine, and mesembranol) ob-
crucial to therapeutic inhibition of SERT by paroxetine. These particular tained from M. tortuosum were investigated for anxiolytic-like activity
residues were shown to engage in van der Waals and π-alkyl interactions using zebrafish larvae subjected to light-dark challenges as an assay for
with paroxetine, as shown in Table 2. Other residues crucial to drug anxiolytic-like effects; the findings were further confirmed using in silico
9

## Page 10

V.B. Maphanga et al. J o u r n a l o f E t h n o p h a r m a c o l o g y 290(2022)115068
Table 2
Docking score, 3D docked conformations and residue interaction profiles of the M. tortuosum alkaloids bound to
SERT.
10

## Page 11

V.B. Maphanga et al. J o u r n a l o f E t h n o p h a r m a c o l o g y 290(2022)115068
modelling techniques. During the dark challenge, the M. tortuosum al- carbon six, while mesembrine and mesembrenone have a carbonyl
kaloids applied at different concentrations exhibited anxiolytic-like ef- group on the same carbon. Thus, there is a connection between the
fect as evidenced by the reverse-thigmotaxis behaviour of the zebrafish structural activity of these alkaloids (Dimpfel et al., 2018). The impor-
larvae compared to the control group. When the activity of each of the tance of these groups to the structural activity of the respective alkaloids
alkaloids was compared with the other alkaloids and with the positive was corroborated in this report by the implication of the groups in the
control, diazepam, a well-known anxiolytic benzodiazepine, all the al- formation of peculiar intermolecular interactions with SERT binding
kaloids demonstrated an anxiolytic-like effect; however mesembrenone pocket residues observed in the molecular docking performed, and
and mesembranol demonstrated greater anxiolytic-like activity than consequently accounted for the favourable SERT-binding affinity of the
mesembrine and mesembrenol. respective alkaloids.
The pharmacokinetics and physicochemical properties of an Nonetheless, the current study provides some indication that
administered drug are crucial to its absorption, distribution, meta- mesembrenone and mesembranol may potentially exhibit greater
bolism, excretion, and toxicity (ADMET) (Klopman et al., 2002; Lin and anxiolytic-like effects than diazepam, even though they differ structur-
Lu, 1997; Lombardo et al., 2017; Tahir ul Qamar et al., 2019; Van de ally. A further study, comprising full dose-response effects, would be
Waterbeemd and Gifford, 2003). These properties affect the bioavail- required to provide comprehensive substantiating evidence for this.
ability of the drug and, consequently, its safety and efficacy as a thera- Since most of the compounds showed activity at the higher concentra-
peutic agent. The ADMET properties can be investigated via tions applied, this suggests that mesembrenone and its derivatives may
experimental methods; however, these are usually time-consuming and exert their anxiolytic-like activity in a concentration-dependent manner.
expensive. Therefore, multiple computational tools were employed, Further studies using a wider concentration range will be necessary to
namely; Molinspiration Cheminformatics (Ertl, 2002), SwissADME confirm this. Based on these facts, M. tortuosum alkaloids have demon-
(Daina et al., 2017), AdmetSAR 2.0 (Cheng et al., 2012; Hongbin et al., strated a possible anxiolytic-like effect as evidenced by their effects on
2019), and ProTox (Drwal et al., 2014), to evaluate the physicochemical hyper-locomotor activity and thigmotaxis behavior of zebrafish larvae
and pharmacokinetic properties of the compounds under investigation, in the light-dark challenge.
as these relate to the possible inhibitory activity of the alkaloids. The
application of multiple predictive tools was to allow for the reproduc- 5. Conclusions
ibility of the results while validating the methods. Harvey et al. (2011),
in a study of the effects of a standardised ethanolic extract of M. tortuosum alkaloids demonstrated a potential anxiolytic-like effect
M. tortuosum, commercially available as Zembrin® and the purified on the zebrafish larvae under light-dark transitions, an assay that in-
isolated alkaloids, found that the extract exhibited potent inhibitory duces an anxiety-like response in zebrafish larvae. This study provides
effects on the SERT (IC50 4.3 μg/mL) as well as on PDE4 (IC50 8.5 evidence that the four alkaloids (mesembrenone, mesembrenol,
μg/mL), but no effect was observed on other PDEs. Mesembrenol, mesembrine, and mesembranol) produce anxiolytic-like effects in
mesembrenone, and mesembrine inhibited binding to the SERT but M. tortuosum; the extract may however contain yet other compounds
showed minimal effect at GABA receptors. Mesembrine was the most that also exhibit anxiolytic-like effects in zebrafish. Screening these al-
potent inhibitor of the SERT (Ki 1.4 nM). Of the isolated alkaloids, kaloids in higher vertebrates might be considered in future studies to
mesembrenone exhibited the most potent inhibitory effect on PDE4 further validate the potential anxiolytic-like activity. Further computa-
(IC50 <1 μm), as well as an inhibitory effect on the SERT (IC50 <1 μm). tional studies may be valuable in determining qualitative structure-
None of the alkaloids displayed cytotoxicity. The authors concluded that activity relationships (SAR) for the alkaloids, followed by compound
while all three alkaloids are responsible for the observed anxiolytic-like optimisation and experimental validation of the constructed SAR model.
and anti-depressant effects of Zembrin®, mesembrine, and mesem-
brenone contribute the greatest portion to the physiological effect, as CRediT authorship contribution statement
per binding assay predictions. Fountain (2016) studied the effects of
M. tortuosum in a chick anxiety-depression model and showed that an Veronica B. Maphanga: Masters student performed the in vivo
alkaloid enriched M. tortuosum extract reduced anxiety but did not show work, Formal analysis, Writing – original draft, Writing – review &
any effect on depression in this model. editing. Krystyna Skalicka-Wozniak: Project administration, Supervi-
Dimpfel et al. (2018) are of the opinion that all four alkaloids sion, Writing – review & editing. Barbara Budzynska: Assisted with
contribute to the activity of Zembrin®. In an ex vivo (Zembrin®) and statistical, Formal analysis. Andriana Skiba: Assisted with in vivo
direct in vitro (individual alkaloids) study in rat hippocampal slices, the zebrafish assays. Weiyang Chen: Assisted with the phytochemistry
excitability of the tissue was attenuated. In addition, the action of AMPA analytical work. Clement Agoni: Assisted with in silico predictions,
(α-amino-3-hydroxy-5-methyl-4-isoxazolepropionic acid) agonist fluo- Writing – original draft. Gill M. Enslin: Project administration, Super-
rowillardine was inhibited by the full extract and by mesembranol and vision, Writing – review & editing. Alvaro M. Viljoen: Conceptualiza-
mesembrenol, leading the authors to speculate that these two alkaloids tion, Supervision.
present promising therapeutic leads for the development of antiepileptic
medicines. Glutamate gated ion channel receptors of the AMPA re- Declaration of competing interest
ceptors subtype mediate the fast excitatory synapse transmission in the
CNS (Geiger et al., 1995) and so represent a potential therapeutic target A. Viljoen declares his role as Editor-in-Chief of the Journal of Eth-
in the treatment of CNS disorders. nopharmacology. A. Viljoen also acts as a scientific advisor to HGH
The pharmacological activity of the alkaloids at particular target Pharmaceuticals, the producers of Zembrin®. However, all assays were
receptors reported by Harvey et al. (2011) with resultant anxiolytic ef- conducted at an independently facility in Poland with whom A. Viljoen
fects was further established in the current study in which the alkaloids has no affiliation.
were shown to demonstrate a similar binding mechanism to that of
paroxetine (Nevels et al., 2016; Pollack et al., 2001), a known SERT Acknowledgements
inhibitor. The binding mechanisms of alkaloids were particularly char-
acterized by high-affinity interaction with crucial residues highlighted The authors would like to thank the DS 28, Medical University of
in previous reports by Coleman et al. (2020, 2019) and Slack et al. Lublin (Poland) for financing the in vivo work, the Tshwane University of
(2019) as pertinent residues in the inhibition of SERT. Another inter- Technology, National Research Foundation (NRF, South Africa) and the
esting factor to consider is the structural properties of the alkaloid South African Medical Research Council (EMU – Grant number 23015)
molecules. Mesembrenol and mesembranol have a hydroxyl group on for financing the phytochemistry work.
11

## Page 12

V.B. Maphanga et al. J o u r n a l o f E t h n o p h a r m a c o l o g y 290(2022)115068
Appendix A. Supplementary data Garakani, A., Murrough, J.W., Freire, R.C., Thom, R.P., Larkin, K., Buono, F.D.,
Iosifescu, D.V., 2021. Pharmacotherapy of anxiety disorders: current and emerging
treatment options. Focus 19, 222–242. https://doi.org/10.3389/fpsyt.2020.595584.
Supplementary data to this article can be found online at https://doi. Geiger, J.R.P., Melcher, T., Koh, D.-S., Sakmann, B., Seeburg, P.H., Jonas, P., Monyer, H.,
org/10.1016/j.jep.2022.115068. 1995. Relative abundance of subunit mRNAs determines gating and Ca2+
permeability of AMPA receptors in principal neurons and interneurons in rat CNS.
Neuron 15, 193–204. https://doi.org/10.1016/0896-6273(95)90076-4.
References
Gericke, N., Viljoen, A., 2008. Sceletium–a review update. J. Ethnopharmacol. 119,
653–663. https://doi.org/10.1016/j.jep.2008.07.043.
Barker, E.L., Perlman, M.A., Adkins, E.M., Houlihan, W.J., Pristupa, Z.B., Niznik, H.B., Hanwell, M.D., Curtis, D.E., Lonie, D.C., Vandermeersch, T., Zurek, E., Hutchison, G.R.,
Blakely, R.D., 1998. High Affinity Recognition of Serotonin Transporter Antagonists 2012. Avogadro: an advanced semantic chemical editor, visualization, and analysis
Defined by Species-scanning Mutagenesis: an aromatic residue in transmembrane platform. J. Cheminf. 4, 17. https://doi.org/10.1186/1758-2946-4-17.
domain i dictates species-selective recognition of citalopram and mazindol. J. Biol. Harvey, A.L., Young, L.C., Viljoen, A.M., Gericke, N.P., 2011. Pharmacological actions of
Chem. 273, 19459–19468. https://doi.org/10.1074/jbc.273.31.19459. the South African medicinal and functional food plant S. tortuosum and its principal
Basnet, R.M., Zizioli, D., Taweedet, S., Finazzi, D., Memo, M., 2019. Zebrafish larvae as a alkaloids. J. Ethnopharmacol. 137, 1124–1129. https://doi.org/10.1016/j.
behavioral model in neuropharmacology. Biomedicines 7, 23. https://doi:10.3390/ jep.2011.07.035.
biomedicines7010023. Henry, L.K., Field, J.R., Adkins, E.M., Parnas, M.L., Vaughan, R.A., Zou, M.-F.,
Belzung, C., Philippot, P., 2007. Anxiety from a phylogenetic perspective: is there a Newman, A.H., Blakely, R.D., 2006. Tyr-95 and Ile-172 in Transmembrane segments
qualitative difference between human and animal anxiety? Neural Plast. 59676. 1 and 3 of human serotonin transporters interact to establish high affinity
https://doi.org/10.1155/2007/59676, 2007. recognition of antidepressants. J. Biol. Chem. 281, 2012–2023. https://doi.org/
Berman, H.M., Battistuz, T., Bhat, T.N., Bluhm, W.F., Philip, E., Burkhardt, K., Feng, Z., 10.1074/jbc.M505055200.
Gilliland, G.L., Iype, L., Jain, S., Fagan, P., Marvin, J., Padilla, D., Ravichandran, V., Hubatsch, I., Ragnarsson, E.G.E., Artursson, P., 2007. Determination of drug
Thanki, N., Weissig, H., Westbrook, J.D., 2002. The Protein Data Bank Research permeability and prediction of drug absorption in Caco-2 monolayers. Nat. Protoc. 2,
Papers the Protein Data Bank, pp. 899–907. 2111–2119. https://doi.org/10.1038/nprot.2007.303.
BIOVIA, D.S., 2017. Discovery Studio. https://discover.3ds.com/discovery-studio- Hurmath Unnissa, S., Rajan, D., 2016. Drug design, development and biological
visualizer-download. screening of pyridazine derivatives. J. Chem. Pharmaceut. Res. 8, 999–1004.
Bowman, M.A., Daws, L.C., 2019. Targeting serotonin transporters in the treatment of Ingelman-Sundberg, M., Sim, S.C., Gomez, A., Rodriguez-Antona, C., 2007. Influence of
juvenile and adolescent depression. Front. Neurosci. 13, 156. https://doi.org/ cytochrome P450 polymorphisms on drug therapies: pharmacogenetic,
10.3389/fnins.2019.00156. pharmacoepigenetic and clinical aspects. Pharmacol. Ther. 116, 496–526. https://
Butler, S.G., Meegan, M.J., 2008. Recent developments in the design of anti-depressive doi.org/10.1016/j.pharmthera.2007.09.004.
therapies: targeting the serotonin transporter. Curr. Med. Chem. 15, 1737–1761. Kallai, J., Makany, T., Karadi, K., Jacobs, W.J., 2005. Spatial orientation strategies in
https://doi.org/10.2174/092986708784872357. Morris-type virtual water task for humans. Behav. Brain Res. 159, 187–196. https://
Cashman, J.R., Voelker, T., Johnson, R., Janowsky, A., 2009. Stereoselective inhibition doi.org/10.1016/j.bbr.2004.10.015.
of serotonin re-uptake and phosphodiesterase by dual inhibitors as potential agents Kallai, J., Makany, T., Csatho, A., Karadi, K., Horvath, D., Kovacs-Labadi, B., Jarai, R.,
for depression. Bioorg. Med. Chem. 17, 337–343. https://doi.org/10.1016/j. Nadel, L., Jacobs, J.W., 2007. Cognitive and affective aspects of thigmotaxis strategy
bmc.2008.10.065. in humans. Behav. Neurosci. https://doi.org/10.1037/0735-7044.121.1.21.
Champagne, D.L., Hoefnagels, C.C.M., de Kloet, R.E., Richardson, M.K., 2010. Klopman, G., Stefan, L.R., Saiakhov, R.D., 2002. ADME evaluation. 2. A computer model
Translating rodent behavioral repertoire to zebrafish (Danio rerio): relevance for for the prediction of intestinal absorption in humans. Eur. J. Pharmaceut. Sci. 17,
stress research. Behav. Brain Res. 214, 332–342. https://doi.org/10.1016/j. 253–263. https://doi.org/10.1016/s0928-0987(02)00219-1.
bbr.2010.06.001. Lin, J.H., 2004. How significant is the role of P-glycoprotein in drug absorption and brain
ChemAxon, 2013. Marvin Sketch. https://chemaxon.com/products/marvin. uptake? Drugs Today 40, 5–22. https://doi.org/10.1358/dot.2004.40.1.799434.
Cheng, F., Li, W., Zhou, Y., Shen, J., Wu, Z., Liu, G., Lee, P.W., Tang, Y., 2012. admetSAR: Lin, J.H., Lu, A.Y., 1997. Role of pharmacokinetics and metabolism in drug discovery and
a comprehensive source and free tool for assessment of chemical ADMET properties. development. Pharmacol. Rev. 49, 403–449.
J. Chem. Inf. Model. 52, 3099–3105. https://doi.org/10.1021/ci300367a. Lin, J.H., Yamazaki, M., 2003. Role of P-glycoprotein in pharmacokinetics. Clin.
Coleman, J.A., Yang, D., Zhao, Z., Wen, P.-C., Yoshioka, C., Tajkhorshid, E., Gouaux, E., Pharmacokinet. 42, 59–98. https://doi.org/10.2165/00003088-200342010-00003.
2019. Serotonin transporter–ibogaine complexes illuminate mechanisms of Lipinski, C.A., 2000. Drug-like properties and the causes of poor solubility and poor
inhibition and transport. Nature 569, 141–145. https://doi.org/10.1038/s41586- permeability. J. Pharmacol. Toxicol. Methods 44, 235–249. https://doi.org/
019-1135-1. 10.1016/s1056-8719(00)00107-6.
Coleman, J.A., Navratna, V., Antermite, D., Yang, D., Bull, J.A., Gouaux, E., 2020. Lipinski, C.A., Lombardo, F., Dominy, B.W., Feeney, P.J., 2001. Experimental and
Chemical and structural investigation of the paroxetine-human serotonin transporter computational approaches to estimate solubility and permeability in drug discovery
complex. Elife 9, e56427. https://doi.org/10.7554/eLife.56427. and development settings. Adv. Drug Deliv. Rev. 46, 3–26. https://doi.org/10.1016/
Colwill, R.M., Creton, R., 2011. Imaging escape and avoidance behavior in zebrafish s0169-409x(00)00129-0.
larvae. Rev. Neurosci. 22, 63–73. https://doi.org/10.1515/RNS.2011.008. Lipinski, C.A., Lombardo, F., Dominy, B.W., Feeney, P.J., 2012. Experimental and
Daina, A., Zoete, V., 2016. A boiled-egg to predict gastrointestinal absorption and brain computational approaches to estimate solubility and permeability in drug discovery
penetration of small molecules. ChemMedChem 1117–1121. https://doi.org/ and development setting. Adv. Drug Deliv. Rev. 64, 4–17. https://doi.org/10.1016/
10.1002/cmdc.201600182. J.ADDR.2012.09.019.
Daina, A., Michielin, O., Zoete, V., 2017. SwissADME: a free web tool to evaluate Lombardo, F., Desai, P.V., Arimoto, R., Desino, K.E., Fischer, H., Keefer, C.E.,
pharmacokinetics, drug-likeness and medicinal chemistry friendliness of small Petersson, C., Winiwarter, S., Broccatelli, F., 2017. In silico absorption, distribution,
molecules. Sci. Rep. 7 https://doi.org/10.1038/srep42717. metabolism, excretion, and pharmacokinetics (ADME-PK): utility and best practices.
Dallakyan, S., Olson, A.J., 2015. Small-molecule library screening by docking with PyRx. an industry perspective from the international consortium for innovation through
Methods Mol. Biol. 1263, 243–250. https://doi.org/10.1007/978-1-4939-2269-7_ quality in pharmaceutical development. J. Med. Chem. 60, 9097–9113. https://doi.
19. org/10.1021/acs.jmedchem.7b00487.
de Esch, C., van der Linde, H., Slieker, R., Willemsen, R., Wolterbeek, A., Woutersen, R., Lo´pez-Patin˜o, M.A., Yu, L., Cabral, H., Zhdanova, I.V., 2008. Anxiogenic effects of
De Groot, D., 2012. Locomotor activity assay in zebrafish larvae: influence of age, cocaine withdrawal in zebrafish. Physiol. Behav. 93, 160–171. https://doi.org/
strain and ethanol. Neurotoxicol. Teratol. 34, 425–433. https://doi.org/10.1016/j. 10.1016/j.physbeh.2007.08.013.
ntt.2012.03.002. Loria, M.J., Ali, Z., Abe, N., Sufka, K.J., Khan, I.A., 2014. Effects of Sceletium tortuosum in
Dell’Osso, B., Allen, A., Hollander, E., 2005. Fluvoxamine: aselective serotonin re-uptake rats. J. Ethnopharmacol. 155, 731–735. https://doi.org/10.1016/j.jep.2014.06.007.
inhibitor for the treatment of obsessive-compulsive disorder. Expet Opin. Maphanga, V.B., Skalicka-Wo´zniak, K., Budzynska, B., Enslin, G.M., Viljoen, A.M., 2020.
Pharmacother. 6, 2727–2740. Screening selected medicinal plants for potential anxiolytic activity using an in vivo
Dimpfel, W., Franklin, R., Gericke, N., Schombert, L., 2018. Effect of Zembrin® and four zebrafish model. Psychopharmacology (Berl) 237, 3641–3652. https://doi.org/
of its alkaloid constituents on electric excitability of the rat hippocampus. 10.1007/s00213-020-05642-5.
J. Ethnopharmacol. 223, 135–141. https://doi.org/10.1016/j.jep.2018.05.010. Maximino, C., Marques de Brito, T., Dias, C.A.G.deM., Gouveia, A., Morato, S., 2010.
Drwal, M.N., Banerjee, P., Dunkel, M., Wettig, M.R., Preissner, R., 2014. ProTox: a web Scototaxis as anxiety-like behavior in fish. Nat. Protoc. 5, 209–216. https://doi.org/
server for the in silico prediction of rodent oral toxicity. Nucleic Acids Res. 42, 10.1038/nprot.2009.225.
W53–W58. https://doi.org/10.1093/nar/gku401. Morris-Schaffer, K., McCoy, M.J., 2021. A review of the ld50 and its current role in
Ertl, D.P., 2002. Calculation of Molecular Properties and Bioactivity Score © hazard communication. ACS Chem. Heal. Saf. 28, 25–33. https://doi.org/10.1021/
Molinspiration Cheminformatics. acs.chas.0c00096.
Ertl, P., Rohde, B., Selzer, P., 2000. Fast calculation of molecular polar surface area as a Nevels, R.M., Gontkovsky, S.T., Williams, B.E., 2016. Paroxetine-the antidepressant from
sum of fragment-based contributions and its application to the prediction of drug hell? probably not, but caution required. Psychopharmacol. Bull. 46, 77–104.
transport properties. J. Med. Chem. 43, 3714–3717. Nguyen, N.T., Nguyen, T.H., Pham, T.N.H., Huy, N.T., Bay, M.V., Pham, M.Q., Nam, P.C.,
Fetcho, J.R., Liu, K.S., 1998. Zebrafish as a model system for studying neuronal circuits Vu, V.V., Ngo, S.T., 2019. Autodock vina adopts more accurate binding poses but
and behavior. Ann. N. Y. Acad. Sci. 860, 333–345. https://doi.org/10.1111/j.1749- autodock4 forms better binding affinity. J. Chem. Inf. Model. 60, 204–211.
6632.1998.tb09060.x. https://doi: 10.1021/acs.jcim.9b00778.
Fountain, E.M., 2016. The Effects of Sceletium tortuosum in the Chick Anxiety-Depression O’Donnell, J.M., Zhang, H.-T., 2004. Antidepressant effects of inhibitors of cAMP
Model. University of Mississippi Honors Theses. https://egrove.olemiss.edu/hon_t phosphodiesterase (PDE4). Trends Pharmacol. Sci. 25, 158–163. https://doi.org/
hesis/302. 10.1016/j.tips.2004.01.003.
12

## Page 13

V.B. Maphanga et al. J o u r n a l o f E t h n o p h a r m a c o l o g y 290(2022)115068
Patnala, S., Kanfer, I., 2017. Sceletium plant species: Alkaloidal components, chemistry ACS Chem. Neurosci. 10, 3946–3952. https://doi.org/10.1021/
and ethnopharmacology. In: Alkaloids-Alternatives in Synthesis, Modification and acschemneuro.9b00375.
Application. https://doi.org/10.5772/66482. Smith, C., 2011. The effects of S. tortuosum in an in vivo model of psychological stress.
Peitsaro, N., Kaslin, J., Anichtchik, O.V., Panula, P., 2003. Modulation of the J. Ethnopharmacol. 133, 31–36. https://doi.org/10.1016/j.jep.2010.08.058.
histaminergic system and behaviour by α-fluoromethylhistidine in zebrafish. Sørensen, L., Andersen, J., Thomsen, M., Hansen, S.M.R., Zhao, X., Sandelin, A.,
J. Neurochem. 86, 432–441. https://doi.org/10.1046/j.1471-4159.2003.01850.x. Strømgaard, K., Kristensen, A.S., 2012. Interaction of antidepressants with the
Peng, X., Lin, J., Zhu, Y., Liu, X., Zhang, Yinglan, Ji, Y., Yang, X., Zhang, Yan, Guo, N., serotonin and norepinephrine transporters: mutational studies OF the S1 substrate
Li, Q., 2016. Anxiety-related behavioral responses of pentylenetetrazole-treated binding pocket. J. Biol. Chem. 287, 43694–43707. https://doi.org/10.1074/jbc.
zebrafish larvae to light-dark transitions. Pharmacol. Biochem. Behav. 145, 55–65. m112.342212.
https://doi.org/10.1016/j.pbb.2016.03.010. Sousa, N., Almeida, O.F.X., Wotjak, C.T., 2006. A hitchhiker’s guide to behavioral
Pettersen, E.F., Goddard, T.D., Huang, C.C., Couch, G.S., Greenblatt, D.M., Meng, E.C., analysis in laboratory rodents. Gene Brain Behav. 5, 5–24. https://doi.org/10.1111/
Ferrin, T.E., 2004. UCSF Chimera - a visualization system for exploratory research j.1601-183x.2006.00228.x.
and analysis. J. Comput. Chem. 25, 1605–1612. https://doi.org/10.1002/jcc.20084. Tahir ul Qamar, M., Maryam, A., Muneer, I., Xing, F., Ashfaq, U.A., Khan, F.A., Anwar, F.,
Pollack, M.H., Zaninelli, R., Goddard, A., McCafferty, J.P., Bellew, K.M., Burnham, D.B., Geesi, M.H., Khalid, R.R., Rauf, S.A., Siddiqi, A.R., 2019. Computational screening of
Iyengar, M.K., 2001. Paroxetine in the treatment of generalized anxiety disorder: medicinal plant phytochemicals to discover potent pan-serotype inhibitors against
results of a placebo-controlled, flexible-dosage trial. J. Clin. Psychiatr. 62, 350–357. dengue virus. Sci. Rep. 9, 1433. https://doi.org/10.1038/s41598-018-38450-1.
https://doi.org/10.4088/jcp.v62n050. Terburg, D., Syal, S., Rosenberger, L.A., Heany, S., Phillips, N., Gericke, N., Stein, D.J.,
Prasanna, S., Doerksen, R., 2009. Topological polar surface area: a useful descriptor in van Honk, J., 2013. Acute effects of S. tortuosum (Zembrin), a dual 5-HT reuptake
2D-QSAR. Curr. Med. Chem. 16, 21–41. and PDE4 inhibitor, in the human amygdala and its connection to the hypothalamus.
Pringle, A., Browning, M., Cowen, P.J., Harmer, C.J., 2011. A cognitive Neuropsychopharmacology 38, 2708–2716. https://doi.org/10.1038/
neuropsychological model of antidepressant drug action. Prog. Neuro- npp.2013.183.
Psychopharmacol. Biol. Psychiatry. https://doi.org/10.1016/j.pnpbp.2010.07.022. Tirona, R.G., Kim, R.B., 2017. In: Robertson, D., Williams, G.H.B.T.-C., S, T., Second, E.
Prut, L., Belzung, C., 2003. The open field as a paradigm to measure the effects of drugs (Eds.), Chapter 20 - Introduction to Clinical Pharmacology. Academic Press,
on anxiety-like behaviors: a review. Eur. J. Pharmacol. 463, 3–33. https://doi.org/ pp. 365–388. https://doi.org/10.1016/b978-0-12-802101-9.00020-x.
10.1016/s0014-2999(03)01272-x. Treit, D., Fundytus, M., 1988. Thigmotaxis as a test for anxiolytic activity in rats.
Reimold, M., Batra, A., Knobel, A., Smolka, M.N., Zimmer, A., Mann, K., Solbach, C., Pharmacol. Biochem. Behav. 31, 959–962. https://doi.org/10.1016/0091-3057(88)
Reischl, G., Schwa¨rzler, F., Gründer, G., Machulla, H.-J., Bares, R., Heinz, A., 2008. 90413-3.
Anxiety is associated with reduced central serotonin transporter availability in Trott, O., Olson, A.J., 2010. AutoDock Vina: improving the speed and accuracy of
unmedicated patients with unipolar major depression: a [11C]DASB PET study. Mol. docking with a new scoring function, efficient optimization, and multithreading.
Psychiatr. 13, 606–613. https://doi.org/10.1038/sj.mp.4002149. J. Comput. Chem. 31, 455–461. https://doi.org/10.1002/jcc.21334.
Schno¨rr, S.J., Steenbergen, P.J., Richardson, M.K., Champagne, D.L., 2012. Measuring Van Booven, D., Marsh, S., McLeod, H., Carrillo, M.W., Sangkuhl, K., Klein, T.E.,
thigmotaxis in larval zebrafish. Behav. Brain Res. 228, 367–374. https://doi.org/ Altman, R.B., 2010. Cytochrome P450 2C9-CYP2C9. Pharmacogenetics Genom. 20,
10.1016/j.bbr.2011.12.016. 277–281. https://doi.org/10.1097/FPC.0b013e3283349e84.
Sharma, S., Coombs, S., Patton, P., de Perera, T.B., 2009. The function of wall-following Van Breemen, R.B., Li, Y., 2005. Caco-2 cell permeability assays to measure drug
behaviors in the Mexican blind cavefish and a sighted relative, the Mexican tetra absorption. Expet Opin. Drug Metabol. Toxicol. 1, 175–185. https://doi.org/
(Astyanax). J. Comp. Physiol. 195, 225–240. https://doi.org/10.1007/s00359-008- 10.1517/17425255.1.2.175.
0400-9. Van de Waterbeemd, H., Gifford, E., 2003. ADMET in silico modelling: towards
Shikanga, E.A., Viljoen, A., Combrinck, S., Marston, A., 2011. Isolation of Sceletium prediction paradise? Nat. Rev. Drug Discov. 2, 192–204.
alkaloids by high-speed countercurrent chromatography. Phytochem. Lett. 4, Van Wyk, B.-E., Gericke, N., 2000. People’s Plants: A Guide to Useful Plants of Southern
190–193. https://doi.org/10.1016/j.phytol.2011.03.003. Africa. Briza Publications, Pretoria.
Shikanga, E., Viljoen, A.M., Combrinck, S., Marston, Andrew, Gericke, N., 2012. The Vignet, C., Devier, M.-H., Le Menach, K., Lyphout, L., Potier, J., Cachot, J., Budzinski, H.,
chemotypic variation of Sceletium tortuosum alkaloids and commercial product B´egout, M.-L., Cousin, X., 2014. Long-term disruption of growth, reproduction, and
formulations. Biochem. Systemat. Ecol. 44, 364–373. https://doi.org/10.1016/j. behavior after embryonic exposure of zebrafish to PAH-spiked sediment. Environ.
bse.2012.06.025. Sci. Pollut. Res. 21, 13877–13887. https://doi.org/10.1007/s11356-014-2585-5.
Shikanga, E.A., Viljoen, A.M., Vermaak, I., Combrinck, S., 2013. A novel approach in Vuppalanchi, R., 2011. In: Saxena, R.B.T.-P.H.P.A.D.A. (Ed.), 4 - Metabolism of Drugs
herbal quality control using hyperspectral imaging: discriminating between S and Xenobiotics. W.B. Saunders, Saint Louis, pp. 45–52. https://doi.org/10.1016/
celetium tortuosum and Sceletium crassicaule. Phytochem. Anal. 24, 550–555. b978-0-443-06803-4.00004-6.
https://doi.org/10.1002/pca.2431. Yang, Hongbin, Lou, Chaofeng, Sun, Lixia, Li, Jie, Cai, Yingchun, Wang, Zhuang,
Shityakov, S., Neuhaus, W., Dandekar, T., Forster, C., 2013. Analysing molecular polar Li, Weihua, Liu, Guixia, Tang, Yun, 15 March 2019. admetSAR 2.0: web-service for
surface descriptors to predict blood-brain barrier permeation. Int. J. Comput. Biol. prediction and optimization of chemical ADMET properties. Bioinformatics 35 (Issue
Drug Des. 6, 146–156. 6), 1067–1069. https://doi.org/10.1093/bioinformatics/bty707.
Slack, R.D., Abramyan, A.M., Tang, H., Meena, S., Davis, B.A., Bonifazi, A., Giancola, J. Ye, Y., Jackson, K., O’Donnell, J.M., 2000. Effects of repeated antidepressant treatment
B., Deschamps, J.R., Naing, S., Yano, H., Singh, S.K., Newman, A.H., Shi, L., 2019. on type 4A phosphodiesterase (PDE4A) in rat brain. J. Neurochem. 74, 1257–1262.
A novel bromine-containing paroxetine analogue provides mechanistic clues for https://doi.org/10.1046/j.1471-4159.2000.741257.x.
binding ambiguity at the central primary binding site of the serotonin transporter. Yohn, C.N., Gergues, M.M., Samuels, B.A., 2017. The role of 5-HT receptors in
depression. Mol. Brain 10, 28. https://doi.org/10.1186/s13041-017-0306-y, 2017.
13

