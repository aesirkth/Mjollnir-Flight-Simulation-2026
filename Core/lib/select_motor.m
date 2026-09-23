function motor = select_motor(motor_number, instruct)
if ~exist("instruct", "var"); instruct = struct(); end

motors = repmat({instruct}, 34, 1);

motors{1}.name = "4842L610-P";
motors{1}.thrust = 930.00;
motors{1}.burn_time = 8.13;
motors{1}.casing_name = "P98 2G";
motors{1}.propellant_mass = 2415.00*1e-3;
motors{1}.casing_mass = 2434.00*1e-3;
motors{1}.link = "https://pro38.com/products/p98-2g/4842l610-p/";
motors{1}.length = 0;
motors{1}.position = [0;0;motors{1}.length*0.5];

motors{2}.name = "4807L3150-P";
motors{2}.thrust = 3670.40;
motors{2}.burn_time = 1.53;
motors{2}.casing_name = "P98 2G";
motors{2}.propellant_mass = 2386.00*1e-3;
motors{2}.casing_mass = 2355.00*1e-3;
motors{2}.link = "https://pro38.com/products/p98-2g/4807l3150-p/";
motors{2}.length = 0;
motors{2}.position = [0;0;motors{2}.length*0.5];

motors{3}.name = "5342M1560-P";
motors{3}.thrust = 1805.2;
motors{3}.burn_time = 3.42;
motors{3}.casing_name = "P98 2G";
motors{3}.propellant_mass = 2452*1e-3;
motors{3}.casing_mass = 2394*1e-3;
motors{3}.link = "https://pro38.com/products/p98-2g/5342m1560-p/";
motors{3}.length = 0;
motors{3}.position = [0;0;motors{3}.length*0.5];

motors{4}.name = "7441M1060-P";
motors{4}.thrust = 1495.20;
motors{4}.burn_time = 7.23;
motors{4}.casing_name = "P98 3G";
motors{4}.propellant_mass = 3622.00*1e-3;
motors{4}.casing_mass = 2946.00*1e-3;
motors{4}.link = "https://pro38.com/products/p98-3g/7441m1060-p/";
motors{4}.length = 0;
motors{4}.position = [0;0;motors{4}.length*0.5];

motors{5}.name = "7450M2505-P";
motors{5}.thrust = 2952.61;
motors{5}.burn_time = 3.00;
motors{5}.casing_name = "P98 3G";
motors{5}.propellant_mass = 3339.00*1e-3;
motors{5}.casing_mass = 2866.00*1e-3;
motors{5}.link = "https://pro38.com/products/p98-3g/7450m2505-p/";
motors{5}.length = 0;
motors{5}.position = [0;0;motors{5}.length*0.5];

motors{6}.name = "7312M4770-P";
motors{6}.thrust = 6053.40;
motors{6}.burn_time = 1.53;
motors{6}.casing_name = "P98 3G";
motors{6}.propellant_mass = 3579.00*1e-3;
motors{6}.casing_mass = 2918.00*1e-3;
motors{6}.link = "https://pro38.com/products/p98-3g/7312m4770-p/";
motors{6}.length = 0;
motors{6}.position = [0;0;motors{6}.length*0.5];

motors{7}.name = "7400M520-P";
motors{7}.thrust = 1184.20;
motors{7}.burn_time = 13.81;
motors{7}.casing_name = "P98 3G";
motors{7}.propellant_mass = 3658.00*1e-3;
motors{7}.casing_mass = 2871.00*1e-3;
motors{7}.link = "https://pro38.com/products/p98-3g/7400m520-p/";
motors{7}.length = 540*1e-3;
motors{7}.position = [0;0;motors{7}.length*0.5];

motors{8}.name = "7579M1520-P";
motors{8}.thrust = 1824.9;
motors{8}.burn_time = 4.97;
motors{8}.casing_name = "P98 3G";
motors{8}.propellant_mass = 3602*1e-3;
motors{8}.casing_mass = 2981*1e-3;
motors{8}.link = "https://pro38.com/products/p98-3g/7579m1520-p/";
motors{8}.length = 0;
motors{8}.position = [0;0;motors{8}.length*0.5];

motors{9}.name = "7649M1290-P";
motors{9}.thrust = 1562.2;
motors{9}.burn_time = 5.94;
motors{9}.casing_name = "P98 3G";
motors{9}.propellant_mass = 4295*1e-3;
motors{9}.casing_mass = 2990*1e-3;
motors{9}.link = "https://pro38.com/products/p98-3g/7649m1290-p/";
motors{9}.length = 0;
motors{9}.position = [0;0;motors{9}.length*0.5];

motors{10}.name = "9955M1450-P";
motors{10}.thrust = 2416.35;
motors{10}.burn_time = 6.87;
motors{10}.casing_name = "P98 4G";
motors{10}.propellant_mass = 4830.00*1e-3;
motors{10}.casing_mass = 3610.00*1e-3;
motors{10}.link = "https://pro38.com/products/p98-4g/9955m1450-p/";
motors{10}.length = 0;
motors{10}.position = [0;0;motors{10}.length*0.5];

motors{11}.name = "9876M1890-P";
motors{11}.thrust = 2401.60;
motors{11}.burn_time = 5.25;
motors{11}.casing_name = "P98 4G";
motors{11}.propellant_mass = 5280.00*1e-3;
motors{11}.casing_mass = 3507.00*1e-3;
motors{11}.link = "https://pro38.com/products/p98-4g/9876m1890-p/";
motors{11}.length = 0;
motors{11}.position = [0;0;motors{11}.length*0.5];

motors{12}.name = "10133M795-P";
motors{12}.thrust = 1721.46;
motors{12}.burn_time = 12.76;
motors{12}.casing_name = "P98 4G";
motors{12}.propellant_mass = 4892.00*1e-3;
motors{12}.casing_mass = 3381.00*1e-3;
motors{12}.link = "https://pro38.com/products/p98-4g/10133m795-p/";
motors{12}.length = 0;
motors{12}.position = [0;0;motors{12}.length*0.5];

motors{13}.name = "8088M1790-P";
motors{13}.thrust = 2092.7;
motors{13}.burn_time = 4.53;
motors{13}.casing_name = "P98 4G";
motors{13}.propellant_mass = 4706*1e-3;
motors{13}.casing_mass = 3456*1e-3;
motors{13}.link = "https://pro38.com/products/p98-4g/8088m1790-p/";
motors{13}.length = 0;
motors{13}.position = [0;0;motors{13}.length*0.5];

motors{14}.name = "9870M1800-P";
motors{14}.thrust = 2240.6;
motors{14}.burn_time = 5.49;
motors{14}.casing_name = "P98 4G";
motors{14}.propellant_mass = 4802*1e-3;
motors{14}.casing_mass = 3383*1e-3;
motors{14}.link = "https://pro38.com/products/p98-4g/9870m1800-p/";
motors{14}.length = 0;
motors{14}.position = [0;0;motors{14}.length*0.5];

motors{15}.name = "9994M3400-P";
motors{15}.thrust = 3983.0;
motors{15}.burn_time = 2.92;
motors{15}.casing_name = "P98 4G";
motors{15}.propellant_mass = 4452*1e-3;
motors{15}.casing_mass = 3342*1e-3;
motors{15}.link = "https://pro38.com/products/p98-4g/9994m3400-p/";
motors{15}.length = 0;
motors{15}.position = [0;0;motors{15}.length*0.5];

motors{16}.name = "10367N1800-P";
motors{16}.thrust = 2216.4;
motors{16}.burn_time = 5.89;
motors{16}.casing_name = "P98 4G";
motors{16}.propellant_mass = 5727*1e-3;
motors{16}.casing_mass = 3338*1e-3;
motors{16}.link = "https://pro38.com/products/p98-4g/10367n1800-p/";
motors{16}.length = 0;
motors{16}.position = [0;0;motors{16}.length*0.5];

motors{17}.name = "8634M6400-P";
motors{17}.thrust = 7237.8;
motors{17}.burn_time = 1.36;
motors{17}.casing_name = "P98 4G";
motors{17}.propellant_mass = 4175*1e-3;
motors{17}.casing_mass = 3611*1e-3;
motors{17}.link = "https://pro38.com/products/p98-4g/8634m6400-p/";
motors{17}.length = 0;
motors{17}.position = [0;0;motors{17}.length*0.5];

motors{18}.name = "13766N2500-P";
motors{18}.thrust = 3875.85;
motors{18}.burn_time = 5.38;
motors{18}.casing_name = "P98 6G";
motors{18}.propellant_mass = 6778*1e-3;
motors{18}.casing_mass = 4553*1e-3;
motors{18}.link = "https://pro38.com/products/p98-6g/13766n2500-p/";
motors{18}.length = 0;
motors{18}.position = [0;0;motors{18}.length*0.5];

motors{19}.name = "14200N3180-P";
motors{19}.thrust = 3770.20;
motors{19}.burn_time = 4.47;
motors{19}.casing_name = "P98 6G";
motors{19}.propellant_mass = 7460*1e-3;
motors{19}.casing_mass = 4654*1e-3;
motors{19}.link = "https://pro38.com/products/p98-6g/14200n3180-p/";
motors{19}.length = 0;
motors{19}.position = [0;0;motors{19}.length*0.5];

motors{20}.name = "14005N1100-P";
motors{20}.thrust = 2708.97;
motors{20}.burn_time = 12.49;
motors{20}.casing_name = "P98 6G";
motors{20}.propellant_mass = 6790*1e-3;
motors{20}.casing_mass = 4728*1e-3;
motors{20}.link = "https://pro38.com/products/p98-6g/14005n1100-p/";
motors{20}.length = 0;
motors{20}.position = [0;0;motors{20}.length*0.5];

motors{21}.name = "11077N2600-P";
motors{21}.thrust = 3047.7;
motors{21}.burn_time = 4.28;
motors{21}.casing_name = "P98 6G";
motors{21}.propellant_mass = 6618*1e-3;
motors{21}.casing_mass = 4712*1e-3;
motors{21}.link = "https://pro38.com/products/p98-6g/11077n2600-p/";
motors{21}.length = 0;
motors{21}.position = [0;0;motors{21}.length*0.5];

motors{22}.name = "13767N2850-P";
motors{22}.thrust = 3377.2;
motors{22}.burn_time = 4.85;
motors{22}.casing_name = "P98 6G";
motors{22}.propellant_mass = 6759*1e-3;
motors{22}.casing_mass = 4723*1e-3;
motors{22}.link = "https://pro38.com/products/p98-6g/13767n2850-p/";
motors{22}.length = 0;
motors{22}.position = [0;0;motors{22}.length*0.5];

motors{23}.name = "10347N10000-P";
motors{23}.thrust = 11564.5;
motors{23}.burn_time = 1.01;
motors{23}.casing_name = "P98 6G";
motors{23}.propellant_mass = 5200*1e-3;
motors{23}.casing_mass = 4583.5*1e-3;
motors{23}.link = "https://pro38.com/products/p98-6g/10347n10000-p/";
motors{23}.length = 0;
motors{23}.position = [0;0;motors{23}.length*0.5];

motors{24}.name = "14272N1975-P";
motors{24}.thrust = 2567.8;
motors{24}.burn_time = 7.23;
motors{24}.casing_name = "P98 6G";
motors{24}.propellant_mass = 8560*1e-3;
motors{24}.casing_mass = 4663.5*1e-3;
motors{24}.link = "https://pro38.com/products/p98-6g/14272n1975-p/";
motors{24}.length = 0;
motors{24}.position = [0;0;motors{24}.length*0.5];

motors{25}.name = "15227N2501-P";
motors{25}.thrust = 3892.3;
motors{25}.burn_time = 6.09;
motors{25}.casing_name = "P98 6G";
motors{25}.propellant_mass = 8496*1e-3;
motors{25}.casing_mass = 4604*1e-3;
motors{25}.link = "https://pro38.com/products/p98-6g/15227n2501-p/";
motors{25}.length = 0;
motors{25}.position = [0;0;motors{25}.length*0.5];

motors{26}.name = "13628N5600-P";
motors{26}.thrust = 6788.9;
motors{26}.burn_time = 2.42;
motors{26}.casing_name = "P98 6GXL";
motors{26}.propellant_mass = 6363*1e-3;
motors{26}.casing_mass = 4794*1e-3;
motors{26}.link = "https://pro38.com/products/p98-6g/13628n5600-p/";
motors{26}.length = 1239.00*1e-3;
motors{26}.position = [0;0;motors{26}.length*0.5];

motors{27}.name = "17790N4100-P";
motors{27}.thrust = 4797.0;
motors{27}.burn_time = 4.31;
motors{27}.casing_name = "P98 6GXL";
motors{27}.propellant_mass = 9101*1e-3;
motors{27}.casing_mass = 5368*1e-3;
motors{27}.link = "https://pro38.com/products/p98-6gxl/17790n4100-p/";
motors{27}.length = 1239.00*1e-3;
motors{27}.position = [0;0;motors{27}.length*0.5];

motors{28}.name = "14263N3400-P";
motors{28}.thrust = 3741.6;
motors{28}.burn_time = 4.19;
motors{28}.casing_name = "P98 6GXL";
motors{28}.propellant_mass = 8282*1e-3;
motors{28}.casing_mass = 5501*1e-3;
motors{28}.link = "https://pro38.com/products/p98-6gxl/14263n3400-p/";
motors{28}.length = 1239.00*1e-3;
motors{28}.position = [0;0;motors{28}.length*0.5];

motors{29}.name = "17613N2900-P";
motors{29}.thrust = 4164.5;
motors{29}.burn_time = 6.14;
motors{29}.casing_name = "P98 6GXL";
motors{29}.propellant_mass = 8449*1e-3;
motors{29}.casing_mass = 5378*1e-3;
motors{29}.link = "https://pro38.com/products/p98-6gxl/17613n2900-p/";
motors{29}.length = 1239.00*1e-3;
motors{29}.position = [0;0;motors{29}.length*0.5];

motors{30}.name = "17631N3800-P";
motors{30}.thrust = 5097.2;
motors{30}.burn_time = 4.65;
motors{30}.casing_name = "P98 6GXL";
motors{30}.propellant_mass = 8449*1e-3;
motors{30}.casing_mass = 5551*1e-3;
motors{30}.link = "https://pro38.com/products/p98-6gxl/17631n3800-p/";
motors{30}.length = 1239.00*1e-3;
motors{30}.position = [0;0;motors{30}.length*0.5];

motors{31}.name = "20146N5800-P";
motors{31}.thrust = 8034.6;
motors{31}.burn_time = 3.49;
motors{31}.casing_name = "P98 6GXL";
motors{31}.propellant_mass = 9021*1e-3;
motors{31}.casing_mass = 5401*1e-3;
motors{31}.link = "https://pro38.com/products/p98-6gxl/20146n5800-p/";
motors{31}.length = 1239.00*1e-3;
motors{31}.position = [0;0;motors{31}.length*0.5];

motors{32}.name = "19318N3301-P";
motors{32}.thrust = 5075.7;
motors{32}.burn_time = 5.86;
motors{32}.casing_name = "P98 6GXL";
motors{32}.propellant_mass = 10658*1e-3;
motors{32}.casing_mass = 5606*1e-3;
motors{32}.link = "https://pro38.com/products/p98-6gxl/19318n3301-p/";
motors{32}.length = 1239.00*1e-3;
motors{32}.position = [0;0;motors{32}.length*0.5];

motors{33}.name = "17907N2540-P";
motors{33}.thrust = 2915.3;
motors{33}.burn_time = 7.04;
motors{33}.casing_name = "P98 6GXL";
motors{33}.propellant_mass = 10700*1e-3;
motors{33}.casing_mass = 5576.3*1e-3;
motors{33}.link = "https://pro38.com/products/p98-6gxl/17907n2540-p/";
motors{33}.length = 1239.00*1e-3;
motors{33}.position = [0;0;motors{33}.length*0.5];

motors{34}.name = "21062O3400-P";
motors{34}.thrust = 4750.3;
motors{34}.burn_time = 6.16;
motors{34}.casing_name = "P98 6GXL";
motors{34}.propellant_mass = 10930*1e-3;
motors{34}.casing_mass = 5570*1e-3;
motors{34}.link = "https://pro38.com/products/p98-6gxl/21062o3400-p/";
motors{34}.length = 1239.00*1e-3;
motors{34}.position = [0;0;motors{34}.length*0.5];

motors{35}.name = "16803N1560-P";
motors{35}.thrust = 3216.3;
motors{35}.burn_time = 10.76;
motors{35}.casing_name = "P98 6GXL";
motors{35}.propellant_mass = 9946*1e-3;
motors{35}.casing_mass = 5471*1e-3;
motors{35}.link = "https://pro38.com/products/p98-6gxl/16803n1560-p/";
motors{35}.length = 1239.00*1e-3;
motors{35}.position = [0;0;motors{35}.length*0.5];


motor = motors{motor_number};
motor.is_body = true;
motor.position = [0;0;0.6];
motor.attitude = eye(3);

end