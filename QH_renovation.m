%% 规模：60MW/240MWh
clc; clear all; close all;
%% 循环
% j=1;
% for i=80:10:200   
%% 容器参数
V_1 = 2500; % m^3
P_1 = 7e6;  % Pa

V_2 = 2000; % m^3
P_2 = 20e6; % Pa

% V_3_plus = i;
V_3_plus = 25000;
V_3 = 29000+V_3_plus; % m^3
P_3 = 8e6;   % Pa

V_4 = 21000; % m^3
P_4 = 5e6;   % Pa

V_5 = 10000;  % m^3
P_5 = 101325; % Pa

V_6 = 10000;  % m^3
P_6 = 101325; % Pa

V_7 = 1400; % m^3
P_7 = 1e6;  % Pa

P_0 = 101325;
T_0 = 273.15+20;
T_total = 4*3600;
%% 释能部分
%% 水轮机
% V_4 ——》 V_5
% V_4 ——》 V_6
M_hy = (V_5+V_6)*refpropm('D','T',T_0,'P',P_0/1000,'WATER');
g = 9.8;
n_hy = 0.92;
H_hy = (P_4-P_5)/g/refpropm('D','T',T_0,'P',P_0/1000,'WATER');
W_hy = M_hy*g*H_hy*n_hy;
P_hy = W_hy/T_total;

fprintf('===================\n');
fprintf('水轮机功率为%2.2fMW\n',P_hy/1000000);
fprintf('水轮机输出功为%2.2fMWh\n',W_hy/(1000000*3600));
%% 透平1
% V_1 ——》 V_4
P_1_out = 5000000;
M_1_out = V_1*(refpropm('D','T',T_0,'P',P_1/1000,'AIR.MIX')-refpropm('D','T',T_0,'P',P_1_out/1000,'AIR.MIX'));
T_TUR1_IN = 273.15+20;
P_TUR1_IN = P_1_out;
n_tur = 0.88;
P_TUR1_OUT = P_4;
h_TUR1_IN = refpropm('H','T',T_TUR1_IN,'P',P_TUR1_IN/1000,'AIR.MIX');
s_TUR1_IN = refpropm('S','T',T_TUR1_IN,'P',P_TUR1_IN/1000,'AIR.MIX');
h_TUR1_out_rev = refpropm('H','P',P_TUR1_OUT/1000,'S',s_TUR1_IN,'AIR.MIX');
h_TUR1_out = h_TUR1_IN-(h_TUR1_IN-h_TUR1_out_rev)*n_tur;
T_TUR1_out = refpropm('T','P',P_TUR1_OUT/1000,'H',h_TUR1_out,'AIR.MIX');
w_TUR1 = h_TUR1_IN-h_TUR1_out;
W_TUR1 = M_1_out*w_TUR1;
P_TUR1 = W_TUR1/T_total;

fprintf('===================\n');
fprintf('透平1出口温度为%2.2fK\n',T_TUR1_out);
fprintf('透平1功率为%2.2fMW\n',P_TUR1/1000000);
fprintf('透平1输出功为%2.2fMWh\n',W_TUR1/(1000000*3600));
%% 透平3
% V_3 ——》 V_4
% P_3_out = P_4;
P_3_out = 6500000;
M_3_out = V_3*(refpropm('D','T',T_0,'P',P_3/1000,'AIR.MIX')-refpropm('D','T',T_0,'P',P_3_out/1000,'AIR.MIX'));
% T_plus = i;
T_plus = 150;
T_TUR3_IN = 273.15+T_plus;
P_TUR3_IN = P_3_out;
n_tur = 0.88;
P_TUR3_OUT = P_4;
h_TUR3_IN = refpropm('H','T',T_TUR3_IN,'P',P_TUR3_IN/1000,'AIR.MIX');
s_TUR3_IN = refpropm('S','T',T_TUR3_IN,'P',P_TUR3_IN/1000,'AIR.MIX');
h_TUR3_out_rev = refpropm('H','P',P_TUR3_OUT/1000,'S',s_TUR3_IN,'AIR.MIX');
h_TUR3_out = h_TUR3_IN-(h_TUR3_IN-h_TUR3_out_rev)*n_tur;
T_TUR3_out = refpropm('T','P',P_TUR3_OUT/1000,'H',h_TUR3_out,'AIR.MIX');
w_TUR3 = h_TUR3_IN-h_TUR3_out;
W_TUR3 = M_3_out*w_TUR3;
P_TUR3 = W_TUR3/T_total;

fprintf('===================\n');
fprintf('透平3出口温度为%2.2fK\n',T_TUR3_out);
fprintf('透平3功率为%2.2fMW\n',P_TUR3/1000000);
fprintf('透平3输出功为%2.2fMWh\n',W_TUR3/(1000000*3600));
%% 透平2
% V_2 ——》 V_4
M_4_out = (V_5+V_6)*refpropm('D','T',T_0,'P',P_4/1000,'AIR.MIX');
M_2_out = M_4_out-M_1_out-M_3_out;
rho_2_out = refpropm('D','T',T_0,'P',P_2/1000,'AIR.MIX')-M_2_out/V_2;
P_2_out = refpropm('P','T',T_0,'D',rho_2_out,'AIR.MIX')*1000;
T_TUR2_IN = 273.15+T_plus;
P_TUR2_IN = P_2_out;
n_tur = 0.88;
P_TUR2_OUT = P_4;
h_TUR2_IN = refpropm('H','T',T_TUR2_IN,'P',P_TUR2_IN/1000,'AIR.MIX');
s_TUR2_IN = refpropm('S','T',T_TUR2_IN,'P',P_TUR2_IN/1000,'AIR.MIX');
h_TUR2_out_rev = refpropm('H','P',P_TUR2_OUT/1000,'S',s_TUR2_IN,'AIR.MIX');
h_TUR2_out = h_TUR2_IN-(h_TUR2_IN-h_TUR2_out_rev)*n_tur;
T_TUR2_out = refpropm('T','P',P_TUR2_OUT/1000,'H',h_TUR2_out,'AIR.MIX');
w_TUR2 = h_TUR2_IN-h_TUR2_out;
W_TUR2 = M_2_out*w_TUR2;
P_TUR2 = W_TUR2/T_total;
 
fprintf('===================\n');
fprintf('透平2出口温度为%2.2fK\n',T_TUR2_out);
fprintf('透平2功率为%2.2fMW\n',P_TUR2/1000000);
fprintf('透平2输出功为%2.2fMWh\n',W_TUR2/(1000000*3600));

%% 储能部分
%% 水泵
% V_5 ——》 V_4
% V_6 ——》 V_4
M_pump = M_hy;
g = 9.8;
n_pump = 0.90;
H_pump = (P_4-P_5)/g/refpropm('D','T',T_0,'P',P_0/1000,'WATER');
W_pump = M_pump*g*H_pump/n_pump;
P_pump = W_pump/T_total;
%% 增压机1
% V_4 ——》 V_1
M_c1 = M_1_out;
T_c1_IN = T_0;
P_c1_IN = P_4;
n_c = 0.88;
P_c1_OUT = P_1;
h_c1_IN = refpropm('H','T',T_c1_IN,'P',P_c1_IN/1000,'AIR.MIX');
s_c1_IN = refpropm('S','T',T_c1_IN,'P',P_c1_IN/1000,'AIR.MIX');
h_c1_out_rev = refpropm('H','P',P_c1_OUT/1000,'S',s_c1_IN,'AIR.MIX');
h_c1_out = (h_c1_out_rev-h_c1_IN)/n_c+h_c1_IN;
T_c1_out = refpropm('T','P',P_c1_OUT/1000,'H',h_c1_out,'AIR.MIX');
w_c1 = h_c1_out-h_c1_IN;
W_c1 = M_c1*w_c1;
P_c1 = W_c1/T_total;
%% 增压机3
% V_4 ——》 V_3
M_c3 = M_3_out;
T_c3_IN = T_0;
P_c3_IN = P_4;
P_c3_OUT = P_3;
h_c3_IN = refpropm('H','T',T_c3_IN,'P',P_c3_IN/1000,'AIR.MIX');
s_c3_IN = refpropm('S','T',T_c3_IN,'P',P_c3_IN/1000,'AIR.MIX');
h_c3_out_rev = refpropm('H','P',P_c3_OUT/1000,'S',s_c3_IN,'AIR.MIX');
h_c3_out = (h_c3_out_rev-h_c3_IN)/n_c+h_c3_IN;
T_c3_out = refpropm('T','P',P_c3_OUT/1000,'H',h_c3_out,'AIR.MIX');
w_c3 = h_c3_out-h_c3_IN;
W_c3 = M_c3*w_c3;
P_c3 = W_c3/T_total;
%% 增压机2
% V_4 ——》 V_2
M_c2 = M_2_out;
T_c2_IN = T_0;
P_c2_IN = P_4;
P_c2_OUT = P_2;
yabi_c2 = (P_c2_OUT/P_c2_IN)^(1/2);

h_c2_IN = refpropm('H','T',T_c2_IN,'P',P_c2_IN/1000,'AIR.MIX');
s_c2_IN = refpropm('S','T',T_c2_IN,'P',P_c2_IN/1000,'AIR.MIX');
h_c2_out_rev1 = refpropm('H','P',P_c2_IN*yabi_c2/1000,'S',s_c2_IN,'AIR.MIX');
h_c2_out1 = (h_c2_out_rev1-h_c2_IN)/n_c+h_c2_IN;
T_c2_out1 = refpropm('T','P',P_c2_IN*yabi_c2/1000,'H',h_c2_out1,'AIR.MIX');
w_c21 = h_c2_out1-h_c2_IN;

h_c2_IN2 = refpropm('H','T',T_c2_IN+10,'P',P_c2_IN*yabi_c2/1000,'AIR.MIX');
s_c2_IN2 = refpropm('S','T',T_c2_IN+10,'P',P_c2_IN*yabi_c2/1000,'AIR.MIX');
h_c2_out_rev2 = refpropm('H','P',P_c2_OUT/1000,'S',s_c2_IN2,'AIR.MIX');
h_c2_out = (h_c2_out_rev2-h_c2_IN2)/n_c+h_c2_IN2;
T_c2_out = refpropm('T','P',P_c2_OUT/1000,'H',h_c2_out,'AIR.MIX');
w_c22 = h_c2_out-h_c2_IN2;

w_c2 = w_c21+w_c22;
W_c2 = M_c2*w_c2;
P_c2 = W_c2/T_total;
%% 系统评价
n_watrer = W_hy/W_pump;
fprintf('===================\n');
fprintf('抽水蓄能部分效率为%2.3f\n',n_watrer);
n_air = (W_TUR1+W_TUR2+W_TUR3)/(W_c1+W_c2+W_c3);
fprintf('压缩空气部分效率为%2.3f\n',n_air);
n_ele = (W_TUR1+W_TUR2+W_TUR3+W_hy)/(W_c1+W_c2+W_c3+W_pump);
fprintf('系统电电效率为%2.3f\n',n_ele);
% Out = [T_plus	P_3_out	T_TUR3_IN	P_2_out	T_TUR2_IN	P_hy/1000000	W_hy/(1000000*3600)	T_TUR3_out	P_TUR3/1000000	W_TUR3/(1000000*3600)	T_TUR2_out	P_TUR2/1000000	W_TUR2/(1000000*3600)	P_hy/1000000+P_TUR3/1000000+P_TUR2/1000000	W_hy/(1000000*3600)+W_TUR3/(1000000*3600)+W_TUR2/(1000000*3600)	n_watrer	n_air	n_ele];
%% 循环
% Out(j,:) = [T_plus	P_3_out	T_TUR3_IN	P_2_out	T_TUR2_IN	P_hy/1000000	W_hy/(1000000*3600)	T_TUR3_out	P_TUR3/1000000	W_TUR3/(1000000*3600)	T_TUR2_out	P_TUR2/1000000	W_TUR2/(1000000*3600)	P_hy/1000000+P_TUR3/1000000+P_TUR2/1000000	W_hy/(1000000*3600)+W_TUR3/(1000000*3600)+W_TUR2/(1000000*3600)	n_watrer	n_air	n_ele];
% j = j+1;
% end