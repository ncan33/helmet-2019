T = readtable('raw_data_project.xlsx');
rawdata = T.Variables;

%INPUT SUBJECT DIMENSIONS
%5'10'' = 70'' = 177.8 cm = 1.778 m
%165 lb = 74.8427 kg
%8 lb = 3.62874 kg

H = 1.778; %meters
m_tot = 74.8427; %kilograms
m_h = m_tot*0.081;
m_helmet = 3.62874; %kilograms

%START HEAD ANALYSIS

deg_h_f = rawdata(:,1); %head angle no helmet IN DEGREES
h_f = pi.*deg_h_f./180; %h_f = head angle no helmet
w_f = zeros(119,1);

for i = 1:119
    w_f(i) = (h_f(i+1)-h_f(i))/(1/100); %delta_theta/delta_time
end %w_f = angular velocity NO HELMET (UNITS: rad/sec)

deg_h_t = rawdata(:,4); %head angle with helmet IN DEGREES
h_t = pi.*deg_h_t./180; %h_t = head angle with helmet
w_t = zeros(119,1); 

for i = 1:119
    w_t(i) = (h_t(i+1)-h_t(i))/(1/100); %delta_theta/delta_time
end %w_t = angular velocity WITH HELMET (UNITS: rad/sec)

a_f = zeros(118,1);

for i = 1:118
    a_f(i) = (w_f(i+1)-w_f(i))/(1/100); %delta_w/delta_time
end %a_f = head acceleration NO HELMET (UNITS: rad/sec^2)

a_t = zeros(118,1);

for i = 1:118
    a_t(i) = (w_t(i+1)-w_t(i))/(1/100); %delta_w/delta_time
end %a_t = head acceleration WITH HELMET (UNITS: rad/sec^2)

%END HEAD ANALYSIS

%START CART ANALYSIS

mm_c_f = rawdata(:,3); %cart position no helmet IN MILLIMETERS
c_f = mm_c_f./1000; %c_f = cart position no helmet
vc_f = zeros(119,1);

for i = 1:119
    vc_f(i) = (c_f(i+1)-c_f(i))/(1/100); %delta_x/delta_time
end %vc_f = cart velocity NO HELMET (UNITS: m/sec)

mm_c_t = rawdata(:,6); %cart position with helmet IN MILLIMETERS
c_t = mm_c_t./1000; %c_t = cart position with helmet
vc_t = zeros(119,1);

for i = 1:119
    vc_t(i) = (c_t(i+1)-c_t(i))/(1/100); %delta_x/delta_time
end %vc_t = cart velocity WITH HELMET (UNITS: m/sec)

ac_f = zeros(118,1);

for i = 1:118
    ac_f(i) = (vc_f(i+1)-vc_f(i))/(1/100); %delta_v/delta_time
end %ac_f = cart acceleration NO HELMET (UNITS: m/sec^2)

ac_t = zeros(118,1);

for i = 1:118
    ac_t(i) = (vc_t(i+1)-vc_t(i))/(1/100); %delta_v/delta_time
end %ac_t = cart acceleration WITH HELMET (UNITS: m/sec^2)

%END CART ANALYSIS

%START ANGLE VECTOR RESIZE 

t_sample_f = 0.00:0.01:1.19;
t_want_f = 0.01:0.01:1.18;
theta_hor = interp1(t_sample_f,h_f,t_want_f);
theta = theta_hor.';

%END ANGLE VECTOR RESIZE

%START MOMENT ANALYSIS

M_f = (m_h.*9.81.*sin(theta).*(0.182.*H))+(0.182.*H.*cos(theta).*m_h.*ac_f)+(m_h.*(0.182.*H).^2).*(a_f);
%moment without helmet

M_t = ((m_h+m_helmet).*9.81.*sin(theta).*(0.182.*H))+(0.182.*H.*cos(theta).*(m_h+m_helmet).*ac_t)+((m_h+m_helmet).*(0.182.*H).^2).*(a_t);
%moment with helmet

%END MOMENT CALCULATION

p = ttest(M_f,M_t);
disp(p)

%PLOT

t = 0.01:0.01:1.18; %time vector (UNITS: seconds)
figure(10)
plot(t,M_f,t,M_t,'LineWidth',1.6)
title('Moment vs. Time','FontSize',14)
xlabel('Time (seconds)','FontSize',12)
ylabel('Moment About Point O (N·m)','FontSize',12)
legend('NO HELMET','WITH HELMET')
grid on