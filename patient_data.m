close all;
clear;
clc;

%A{i,1} = time difference //  i  is the patient number
%A{i,2} = Total volume
%A{i,3} = Maximum diameter
%A{i,4} = contains the time shift
%A{i,5} = is the patient's name
%A{i,6} = is the sum time difference plus time constant
%A{i,7} = is also the sum time difference
%A{i,8} = is modified time difference
%A{i,9} = is modifed time sum including time constant
%A{i,10} = the time factor
%A{i,11}= average slope


A{1,1}=[0%%%%%%%%%%%%%%%%%%%%%%%%%%%A
    6.03];
A{1,3}=[51.3014432549699;51.6321040811453];
A{1,2}=[144261.16;%%%%%%%%%%%%%%%%%%%%%%%%%%%A
    161048.38;];
A{1,5}='P01';

A{2,1}=[    0%%%%%%%%%%%%%%%%%%%%%%%%%%%B
6.7
17.4];
A{2,3}=[42.9927311839905;44.8405116883506;51.2538849819127];
 A{2,2}=[   117133.4175786;%%%%%%%%%%%%%%%%%%%%%%%%%%%B
        121927.2342876            ;
        133463.5705775            ;];
A{2,5}='P02';

A{3,1}=[0%%%%%%%%%%%%%%%%%%%%%%%%%%%C
21.06];
A{3,3}=[36.9703416270967;39.0680464140366;];
A{3,2}=[        95713.2629111;%%%%%%%%%%%%%%%%%%%%%%%%%%%C
        103762.0192194;];
A{3,5}='P03';

A{4,1}=[0%%%%%%%%%%%%%%%%%%%%%%%%%%%D
16.23
28.37];
A{4,3}=[47.7753356155934;54.5044059331892;65.0936576279512;];
A{4,5}='P04';
A{4,2}=[        122596.1045248;%%%%%%%%%%%%%%%%%%%%%%%%%%%D
        157007.9007601;
        213183.3935731;];
A{5,1}=[0%%%%%%%%%%%%%%%%%%%%%%%%%%%G
6.06
5.97
5.7
6.33];
A{5,3}=[41.6702255634888;42.8231183211393;45.6522048805158;48.7205190244929;51.1170886276689;];
A{5,5}='P05';
A{5,2}=[       124551.6385170;%%%%%%%%%%%%%%%%%%%%%%%%%%%G from G2
        127036.2262091;
        148988.7777550;
        158594.6962379;
        175738.8997324;];
A{6,1}=[0%%%%%%%%%%%%%%%%%%%%%%%%%%%H
12.8
56.3
11.36666667
11.66666667
11.6
5.5];

A{6,3}=[39.2117610149123;40.7616550609356;47.0895634132537;49.8962343431192;51.2100280968906;57.3939744305892;58.0920275343867;];
A{6,5}='P06';
A{6,2}=[        88216.5740598            ;%%%%%%%%%%%%%%%%%%%%%%%%%%%H
        87239.9158598            ;
        91509.2441543            ;
        97671.6043166            ;
        130632.4489716            ;
        192329.4162239           ;
        204138.0445419           ;];
A{7,1}=[0%%%%%%%%%%%%%%%%%%%%%%%%%%%I
12.2
12.26666667
10.83333333
11.96666667
22.9];
A{7,3}=[30.2185029613456;31.8404379002345;31.7005085295989;33.3549755931505;33.9704726898914;34.7373116771462;];
A{7,5}='P07';
A{7,2}=[        48451.9301336             ;%%%%%%%%%%%%%%%%%%%%%%%%%%%I
        62816.4839320            ;
        62139.0050474            ;
        65480.5735554            ;
        68746.7625790            ;
        78208.2588482            ;];
A{8,1}=[0%%%%%%%%%%%%%%%%%%%%%%%%%%%J
12.7
12.16666667
11.96666667
5.6];
A{8,3}=[38.9611636055682;40.5703441753723;42.5723440428015;45.0699405851413;46.8270222477665;];
A{8,5}='P08';
A{8,2}=[        85556.5884948            ;%%%%%%%%%%%%%%%%%%%%%%%%%%%J
        82665.1133305            ;
        90733.9629686            ;
        102872.0862225            ;
        114221.5774306            ;];
    
A{9,1}=[0%%%%%%%%%%%%%%%%%%%%%%%%%%%K
7.5
14.66666667
12.3
11.63333333
];
A{9,3}=[38.9020130219578;41.4609863673402;43.7422099316231;46.8001689561449;55.0949387920257;];
A{9,5}='P09';

A{9,2}=[        111157.4879140            ;%%%%%%%%%%%%%%%%%%%%%%%%%%%K
        112270.7455350            ;
        124664.1851114            ;
        147611.3212364            ;
        184126.3223890       ;];

    
 A{10,1}=[0%%%%%%%%%%%%%%%%%%%%%%%%%%%P10
3.233333333
5.633333333
9.933333333
];
A{10,3}=[40.54150582;41.62645776;43.79765247;44.84099098;];   
 A{10,5}='P10';

A{10,2}=[                95542.9660759             ;%%%%%%%%%%%%%%%%%%%%%%%%%%%P10
        105271.6699338            ;     
        133997.1581523            ;
        127195.2351930            ;];
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%P11
    A{11,1}=[0
5.566666667
12.83333333
12.33333333
14.06666667
12.33333333
];
A{11,3}=[39.32088197;39.34574112;41.34656131;43.34681206;46.91803141;46.54823638;];
    A{11,5}='P11';

A{11,2}=[                76000.0777776            ;%%%%%%%%%%%%%%%%%%%%%%%%%%%P11
        79601.2651242            ;
        88494.0075879            ;
                95138.1703047            ;
        104659.7265994            ;
        102808.6497889             ;];
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%P12
    A{12,1}=[0
25.4
5.533333333
8.433333333
8.5
3.866666667
];
A{12,3}=[29.09840429;30.83259791;31.75771505;32.31014551;32.54715429;31.56017933;];
    A{12,5}='P12';

A{12,2}=[                  56790.0466592            ;%%%%%%%%%%%%%%%%%%%%%%%%%%%P12
        60799.8985715            ;
        59965.1178596            ;
                62205.1017339            ;
        62359.9939384            ;
        63206.9146641                     ;];
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%P13
    
    A{13,1}=[0
13.3
12.5
12.6
];
A{13,3}=[39.96548563;43.07468269;46.12624151;50.50950621;];
    A{13,5}='P13';

A{13,2}=[        100300.7016434            ;%%%%%%%%%%%%%%%%%%%%%%%%%%%P13
        114180.1211492            ;
        127568.3575331            ;
                158392.8532944            ;];
    
            
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%P14
A{14,1}=[0
14.93333333
5.6
];
A{14,3}=[46.6721487;46.19694277;47.28009741;];
    A{14,5}='P14';

A{14,2}=[            105220.6421986            ;%%%%%%%%%%%%%%%%%%%%%%%%%%%P14
        99164.6234819;
        108829.5454489;];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    