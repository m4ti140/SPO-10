%% prep
%import
f_A=import_response("f_A_data.csv",3,31);
f_B=import_response("f_B_data.csv",3,27);
f_V=import_response("f_V_data.csv",3,26);
f_A=normalize(f_A);
f_B=normalize(f_B);
f_V=normalize(f_V);

%z innego zrodla
f_A_freq=2e9;
f_B_freq=6e9;
f_V_freq=1e10;

az=(-180:180);
el=(-90:90);

%f_A

az_H_A=interp1(f_A.az_E_phi(~isnan(f_A.az_E_phi)), f_A.az_E_r(~isnan(f_A.az_E_r)), az, 'pchip', 0);
el_H_A=interp1(f_A.az_H_phi(~isnan(f_A.az_H_phi)), f_A.az_H_r(~isnan(f_A.az_H_r)), el, 'pchip', 0);
H_A=crosssection_estimate(az_H_A,el_H_A);

az_V_A=interp1(f_A.el_H_phi(~isnan(f_A.el_H_phi)), f_A.el_H_r(~isnan(f_A.el_H_r)), az, 'pchip', 0);
el_V_A=interp1(f_A.el_E_phi(~isnan(f_A.el_E_phi)), f_A.el_E_r(~isnan(f_A.el_E_r)), el, 'pchip', 0);
V_A=crosssection_estimate(az_V_A,el_V_A);

%f_B

az_H_B=interp1(f_B.az_E_phi(~isnan(f_B.az_E_phi)), f_B.az_E_r(~isnan(f_B.az_E_r)), az, 'pchip', 0);
el_H_B=interp1(f_B.az_H_phi(~isnan(f_B.az_H_phi)), f_B.az_H_r(~isnan(f_B.az_H_r)), el, 'pchip', 0);
H_B=crosssection_estimate(az_H_B,el_H_B);

az_V_B=interp1(f_B.el_H_phi(~isnan(f_B.el_H_phi)), f_B.el_H_r(~isnan(f_B.el_H_r)), az, 'pchip', 0);
el_V_B=interp1(f_B.el_E_phi(~isnan(f_B.el_E_phi)), f_B.el_E_r(~isnan(f_B.el_E_r)), el, 'pchip', 0);
V_B=crosssection_estimate(az_V_B,el_V_B);

%f_V

az_H_V=interp1(f_V.az_E_phi(~isnan(f_V.az_E_phi)), f_V.az_E_r(~isnan(f_V.az_E_r)), az, 'pchip', 0);
el_H_V=interp1(f_V.az_H_phi(~isnan(f_V.az_H_phi)), f_V.az_H_r(~isnan(f_V.az_H_r)), el, 'pchip', 0);
H_V=crosssection_estimate(az_H_V,el_H_V);

az_V_V=interp1(f_V.el_H_phi(~isnan(f_V.el_H_phi)), f_V.el_H_r(~isnan(f_V.el_H_r)), az, 'pchip', 0);
el_V_V=interp1(f_V.el_E_phi(~isnan(f_V.el_E_phi)), f_V.el_E_r(~isnan(f_V.el_E_r)), el, 'pchip', 0);
V_V=crosssection_estimate(az_V_V,el_V_V);

M_V=cat(3,mag2db(zeros(181,361)),mag2db(V_A.'),mag2db(V_B.'),mag2db(V_V.'),mag2db(zeros(181,361)));
M_H=cat(3,mag2db(zeros(181,361)),mag2db(H_A.'),mag2db(H_B.'),mag2db(H_V.'),mag2db(zeros(181,361)));

SZM7 = phased.CustomAntennaElement('FrequencyVector', [0 f_A_freq f_B_freq f_V_freq 1.2e10], 'FrequencyResponse', [0, 0, 0, 0, 0], 'SpecifyPolarizationPattern',true, 'HorizontalMagnitudePattern',M_H,'HorizontalPhasePattern',zeros(181,361,5),'VerticalMagnitudePattern',M_V,'VerticalPhasePattern',zeros(181,361,5));

%% wyn
close all;
figure
pattern(SZM7, f_A_freq, 'Type', 'efield');

%szyk

ypos=[-2.5 2.5 -0.02 0.02];
xpos=[0 0 -5 -5];
zpos=[0 0 1.5 1.5];
normal_az=[-45 45 -135 135];
normal_el=[0 0 0 0];


SPO{1}=phased.ConformalArray('Element', SZM7, 'ElementPosition', [xpos(2); ypos(2); zpos(2)], 'ElementNormal', [normal_az(2); normal_el(2)]);
SPO{2}=phased.ConformalArray('Element', SZM7, 'ElementPosition', [xpos(4); ypos(4); zpos(4)], 'ElementNormal', [normal_az(4); normal_el(4)]);
SPO{3}=phased.ConformalArray('Element', SZM7, 'ElementPosition', [xpos(3); ypos(3); zpos(3)], 'ElementNormal', [normal_az(3); normal_el(3)]);
SPO{4}=phased.ConformalArray('Element', SZM7, 'ElementPosition', [xpos(1); ypos(1); zpos(1)], 'ElementNormal', [normal_az(1); normal_el(1)]);
% figure
% hold on
% for i=1:4
%     viewArray(SPO{i}, 'ShowNormals', true);
% end


fc_e=9.3753e9;
T_e=40e-6;
PRF_e=1/80e-6;
c = physconst('LightSpeed');

for i=1:4
    figure;
pattern(SPO{i},3e9,az,el,'CoordinateSystem','polar','Type','powerdb', 'Normalize',false,'PropagationSpeed',physconst('LightSpeed'))
end

az_r=(-120:5:120);
%e_a_2ghz=[0,0.04,0.07,0.09,0.095,0.1,0.125,0.14,0.16,0.2,0.26,0.32,0.42,0.5,0.55,0.6,0.67,0.74,0.8,0.83,0.84,0.84,0.85,0.9,1,1,0.98,0.95,0.9,0.84,0.73,0.62,0.56,0.51,0.46,0.43,0.38,0.35,0.26,0.2,0.17,0.14,0.11,0.09,0.07,0.06,0.04,0.02,0];
el_r=(-120:5:120);


%% audio

% fs=8192;
% tl=0.08;
% fr=800;
% val=0:1/fs:tl;
% audioout=sin(2*pi*fr*val);