T = readtable('raw_data_project.xlsx');
rawdata = T.Variables;

%START BODY ANALYSIS

mm_b_f = rawdata(:,2); %body position no helmet IN MILLIMETERS
b_f = mm_b_f./1000; %b_f = body position no helmet
vb_f = zeros(119,1);

for i = 1:119
    vb_f(i) = (b_f(i+1)-b_f(i))/(1/100); %delta_x/delta_time
end %vb_f = body velocity NO HELMET (UNITS: m/sec)

ab_f = zeros(118,1);

for i = 1:118
    ab_f(i) = (vb_f(i+1)-vb_f(i))/(1/100); %delta_v/delta_time
end %ab_f = body acceleration NO HELMET (UNITS: m/sec^2)

mm_b_t = rawdata(:,5); %body position with helmet IN MILLIMETERS
b_t = mm_b_t./1000; %b_t = body position with helmet
vb_t = zeros(119,1);

for i = 1:119
    vb_t(i) = (b_t(i+1)-b_t(i))/(1/100); %delta_x/delta_time
end %vb_t = body velocity WITH HELMET (UNITS: m/sec)

ab_t = zeros(118,1);

for i = 1:118
    ab_t(i) = (vb_t(i+1)-vb_t(i))/(1/100); %delta_v/delta_time
end %ab_t = body acceleration WITH HELMET (UNITS: m/sec^2)

%END BODY ANALYSIS

%START CART ANALYSIS

mm_c_f = rawdata(:,3); %cart position no helmet IN MILLIMETERS
c_f = mm_c_f./1000; %c_f = cart position no helmet
vc_f = zeros(119,1);

for i = 1:119
    vc_f(i) = (c_f(i+1)-c_f(i))/(1/100); %delta_x/delta_time
end %vc_f = cart velocity NO HELMET (UNITS: m/sec)

ac_f = zeros(118,1);

for i = 1:118
    ac_f(i) = (vc_f(i+1)-vc_f(i))/(1/100); %delta_v/delta_time
end %ac_f = cart acceleration NO HELMET (UNITS: m/sec^2)

mm_c_t = rawdata(:,6); %cart position with helmet IN MILLIMETERS
c_t = mm_c_t./1000; %c_t = cart position with helmet
vc_t = zeros(119,1);

for i = 1:119
    vc_t(i) = (c_t(i+1)-c_t(i))/(1/100); %delta_x/delta_time
end %vc_t = cart velocity WITH HELMET (UNITS: m/sec)

ac_t = zeros(118,1);

for i = 1:118
    ac_t(i) = (vc_t(i+1)-vc_t(i))/(1/100); %delta_v/delta_time
end %ac_t = cart acceleration WITH HELMET (UNITS: m/sec^2)

%END CART ANALYSIS

%PLOT

t_pos = 0.00:0.01:1.19; %time vector for position (UNITS: seconds)
figure(1)
plot(t_pos,b_f,t_pos,c_f,'LineWidth',1.6);
title('Position vs. Time (NO HELMET)','FontSize',14)
xlabel('Time (seconds)','FontSize',12)
ylabel('Position (m)','FontSize',12)
legend('BODY POSITION','CART POSITION')
grid on

t_v = 0.005:0.01:1.185; %time vector for velocity (UNITS: seconds)
figure(2)
plot(t_v,vb_f,t_v,vc_f,'LineWidth',1.6);
title('Velocity vs. Time (NO HELMET)','FontSize',14)
xlabel('Time (seconds)','FontSize',12)
ylabel('Velocity (m/s)','FontSize',12)
legend('BODY VELOCITY','CART VELOCITY')
grid on

t_a = 0.01:0.01:1.18; %time vector for acceleration (UNITS: seconds)
figure(3)
plot(t_a,ab_f,t_a,ac_f,'LineWidth',1.6)
title('Acceleration vs. Time (NO HELMET)','FontSize',14)
xlabel('Time (seconds)','FontSize',12)
ylabel('Acceleration (m/s^2)','FontSize',12)
legend('BODY ACCELERATION','CART ACCELERATION')
grid on

t_pos = 0.00:0.01:1.19; %time vector for position (UNITS: seconds)
figure(4)
plot(t_pos,b_t,t_pos,c_t,'LineWidth',1.6);
title('Position vs. Time (WITH HELMET)','FontSize',14)
xlabel('Time (seconds)','FontSize',12)
ylabel('Position (m)','FontSize',12)
legend('BODY POSITION','CART POSITION')
grid on

t_v = 0.005:0.01:1.185; %time vector for velocity (UNITS: seconds)
figure(5)
plot(t_v,vb_t,t_v,vc_t,'LineWidth',1.6);
title('Velocity vs. Time (WITH HELMET)','FontSize',14)
xlabel('Time (seconds)','FontSize',12)
ylabel('Velocity (m/s)','FontSize',12)
legend('BODY VELOCITY','CART VELOCITY')
grid on

t_a = 0.01:0.01:1.18; %time vector for acceleration (UNITS: seconds)
figure(6)
plot(t_a,ab_t,t_a,ac_t,'LineWidth',1.6)
title('Acceleration vs. Time (WITH HELMET)','FontSize',14)
xlabel('Time (seconds)','FontSize',12)
ylabel('Acceleration (m/s^2)','FontSize',12)
legend('BODY ACCELERATION','CART ACCELERATION')
grid on